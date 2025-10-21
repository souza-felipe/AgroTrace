import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../theme/app_colors.dart';
import '../../components/custom_app_bar.dart';

class EnhancedMapScreen extends StatefulWidget {
  const EnhancedMapScreen({super.key});

  @override
  State<EnhancedMapScreen> createState() => _EnhancedMapScreenState();
}

class _EnhancedMapScreenState extends State<EnhancedMapScreen> {
  GoogleMapController? _mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const LatLng _center = LatLng(-15.7801, -47.9292);

  List<AnimalData> _animals = [];
  Set<Marker> markers = {};
  String _selectedStatus = 'todos';

  @override
  void initState() {
    super.initState();
    _createAnimalsData();
    _createMarkers();
  }

  void _createAnimalsData() {
    _animals = [
      AnimalData(
        id: 'animal_1',
        name: 'Boi João',
        status: 'online',
        batteryLevel: 85,
        signalStrength: 'Forte',
        lastUpdate: DateTime.now().subtract(Duration(minutes: 2)),
        position: LatLng(-15.7791, -47.9282),
        color: Colors.green,
      ),
      AnimalData(
        id: 'animal_2',
        name: 'Vaca Maria',
        status: 'online',
        batteryLevel: 92,
        signalStrength: 'Muito Forte',
        lastUpdate: DateTime.now().subtract(Duration(minutes: 1)),
        position: LatLng(-15.7811, -47.9302),
        color: Colors.green,
      ),
      AnimalData(
        id: 'animal_3',
        name: 'Boi Pedro',
        status: 'offline',
        batteryLevel: 15,
        signalStrength: 'Fraco',
        lastUpdate: DateTime.now().subtract(Duration(minutes: 8)),
        position: LatLng(-15.7771, -47.9312),
        color: Colors.red,
      ),
      AnimalData(
        id: 'animal_4',
        name: 'Vaca Ana',
        status: 'online',
        batteryLevel: 78,
        signalStrength: 'Forte',
        lastUpdate: DateTime.now().subtract(Duration(minutes: 3)),
        position: LatLng(-15.7831, -47.9272),
        color: Colors.green,
      ),
      AnimalData(
        id: 'animal_5',
        name: 'Boi Carlos',
        status: 'error',
        batteryLevel: 5,
        signalStrength: 'Muito Fraco',
        lastUpdate: DateTime.now().subtract(Duration(minutes: 12)),
        position: LatLng(-15.7751, -47.9292),
        color: Colors.orange,
      ),
    ];
  }

  void _createMarkers() {
    markers.clear();

    for (var animal in _animals) {
      markers.add(
        Marker(
          markerId: MarkerId(animal.id),
          position: animal.position,
          infoWindow: InfoWindow(
            title: animal.name,
            snippet:
                '${animal.status.toUpperCase()} - ${animal.batteryLevel}% bateria',
          ),
          icon: _getMarkerIcon(animal.status),
        ),
      );
    }
  }

  BitmapDescriptor _getMarkerIcon(String status) {
    switch (status) {
      case 'online':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'offline':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'error':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  void _centerMapOnAnimals() {
    if (_mapController != null && markers.isNotEmpty) {
      List<LatLng> positions =
          markers.map((marker) => marker.position).toList();

      double minLat = positions
          .map((p) => p.latitude)
          .reduce((a, b) => a < b ? a : b);
      double maxLat = positions
          .map((p) => p.latitude)
          .reduce((a, b) => a > b ? a : b);
      double minLng = positions
          .map((p) => p.longitude)
          .reduce((a, b) => a < b ? a : b);
      double maxLng = positions
          .map((p) => p.longitude)
          .reduce((a, b) => a > b ? a : b);

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat - 0.001, minLng - 0.001),
            northeast: LatLng(maxLat + 0.001, maxLng + 0.001),
          ),
          100.0,
        ),
      );
    }
  }

  void _filterByStatus(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  void _focusOnAnimal(AnimalData animal) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(animal.position, 18.0),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Localização dos Animais',
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            tooltip: 'Lista de Animais',
          ),
          IconButton(
            icon: Icon(Icons.center_focus_strong, color: Colors.white),
            onPressed: _centerMapOnAnimals,
            tooltip: 'Centralizar nos Animais',
          ),
        ],
      ),
      endDrawer: _buildAnimalsDrawer(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: markers,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }

  Widget _buildInfoCard() {
    int onlineCount = _animals.where((a) => a.status == 'online').length;
    int offlineCount = _animals.where((a) => a.status == 'offline').length;
    int errorCount = _animals.where((a) => a.status == 'error').length;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text(
                'Estatísticas dos Animais',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatusChip('Total', _animals.length, Colors.blue),
              _buildStatusChip('Online', onlineCount, Colors.green),
              _buildStatusChip('Offline', offlineCount, Colors.red),
              _buildStatusChip('Erro', errorCount, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6),
          Text(
            '$label: $count',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalsDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lista de Animais',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${_animals.length} animais cadastrados',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  SizedBox(height: 20),

                  Text(
                    'Filtrar por Status:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildFilterChip('Todos', 'todos'),
                      _buildFilterChip('Online', 'online'),
                      _buildFilterChip('Offline', 'offline'),
                      _buildFilterChip('Erro', 'error'),
                    ],
                  ),

                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 16),

                  Text(
                    'Lista de Animais',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 12),

                  ..._animals
                      .where(
                        (animal) =>
                            _selectedStatus == 'todos' ||
                            animal.status == _selectedStatus,
                      )
                      .map(
                        (animal) => Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: _buildAnimalListItem(animal),
                        ),
                      ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedStatus == value;
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          _filterByStatus(value);
        },
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        checkmarkColor: AppColors.primary,
        backgroundColor: Colors.grey[100],
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.grey[300]!,
          width: isSelected ? 1.5 : 1,
        ),
        elevation: isSelected ? 2 : 0,
        pressElevation: 1,
      ),
    );
  }

  Widget _buildAnimalListItem(AnimalData animal) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: animal.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: animal.color.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        title: Text(
          animal.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: animal.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    animal.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: animal.color,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.battery_std, size: 14, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  '${animal.batteryLevel}%',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'Última atualização: ${_formatLastUpdate(animal.lastUpdate)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: animal.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.location_on, color: animal.color, size: 20),
        ),
        onTap: () => _focusOnAnimal(animal),
      ),
    );
  }

  String _formatLastUpdate(DateTime lastUpdate) {
    final now = DateTime.now();
    final difference = now.difference(lastUpdate);

    if (difference.inMinutes < 1) {
      return 'Agora';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}min atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h atrás';
    } else {
      return '${difference.inDays}d atrás';
    }
  }
}

class AnimalData {
  final String id;
  final String name;
  final String status;
  final int batteryLevel;
  final String signalStrength;
  final DateTime lastUpdate;
  final LatLng position;
  final Color color;

  AnimalData({
    required this.id,
    required this.name,
    required this.status,
    required this.batteryLevel,
    required this.signalStrength,
    required this.lastUpdate,
    required this.position,
    required this.color,
  });
}
