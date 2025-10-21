import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../api/endpoints.dart';
import '../models/animal_location.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Timer? _locationTimer;
  StreamController<List<AnimalLocation>> locationController = 
      StreamController<List<AnimalLocation>>.broadcast();
  
  Stream<List<AnimalLocation>> get locationStream => locationController.stream;

  void startLocationMonitoring() {
    _locationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      _fetchRealTimeLocations();
    });
    
    _fetchRealTimeLocations();
  }

  void stopLocationMonitoring() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  Future<void> _fetchRealTimeLocations() async {
    try {
      final List<AnimalLocation> mockLocations = _generateMockLocations();
      locationController.add(mockLocations);
      
      /*
      final response = await http.get(
        Uri.parse(ApiEndpoints.animaisLocalizacaoTempoReal),
        headers: ApiEndpoints.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<AnimalLocation> locations = data
            .map((json) => AnimalLocation.fromMap(json))
            .toList();
        
        _locationController.add(locations);
      } else {
        print('Erro ao buscar localizações: ${response.statusCode}');
        _locationController.addError('Erro ao buscar localizações');
      }
      */
    } catch (e) {
      locationController.addError('Erro na requisição de localização');
    }
  }

  List<AnimalLocation> _generateMockLocations() {
    final now = DateTime.now();
    final baseLat = -15.7801;
    final baseLng = -47.9292;
    
    return [
      AnimalLocation(
        id: '1',
        animalId: 'animal_001',
        nomeAnimal: 'Boi João',
        latitude: baseLat + 0.001,
        longitude: baseLng + 0.001,
        timestamp: now.subtract(Duration(minutes: 2)).toIso8601String(),
        status: 'online',
        accuracy: 5.0,
        batteryLevel: '85%',
        signalStrength: 'Forte',
      ),
      AnimalLocation(
        id: '2',
        animalId: 'animal_002',
        nomeAnimal: 'Vaca Maria',
        latitude: baseLat - 0.002,
        longitude: baseLng + 0.003,
        timestamp: now.subtract(Duration(minutes: 5)).toIso8601String(),
        status: 'online',
        accuracy: 3.0,
        batteryLevel: '92%',
        signalStrength: 'Muito Forte',
      ),
      AnimalLocation(
        id: '3',
        animalId: 'animal_003',
        nomeAnimal: 'Boi Pedro',
        latitude: baseLat + 0.003,
        longitude: baseLng - 0.001,
        timestamp: now.subtract(Duration(minutes: 8)).toIso8601String(),
        status: 'offline',
        accuracy: 10.0,
        batteryLevel: '15%',
        signalStrength: 'Fraco',
      ),
      AnimalLocation(
        id: '4',
        animalId: 'animal_004',
        nomeAnimal: 'Vaca Ana',
        latitude: baseLat - 0.001,
        longitude: baseLng - 0.002,
        timestamp: now.subtract(Duration(minutes: 1)).toIso8601String(),
        status: 'online',
        accuracy: 2.0,
        batteryLevel: '78%',
        signalStrength: 'Forte',
      ),
      AnimalLocation(
        id: '5',
        animalId: 'animal_005',
        nomeAnimal: 'Boi Carlos',
        latitude: baseLat + 0.004,
        longitude: baseLng + 0.004,
        timestamp: now.subtract(Duration(minutes: 12)).toIso8601String(),
        status: 'error',
        accuracy: 15.0,
        batteryLevel: '5%',
        signalStrength: 'Muito Fraco',
      ),
    ];
  }

  Future<List<AnimalLocation>> getAllAnimalLocations() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.animaisLocalizacao),
        headers: ApiEndpoints.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => AnimalLocation.fromMap(json)).toList();
      } else {
        throw Exception('Erro ao buscar localizações: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<AnimalLocation?> getAnimalLocation(String animalId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.animalLocalizacaoById(animalId)),
        headers: ApiEndpoints.headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return AnimalLocation.fromMap(data);
      } else if (response.statusCode == 404) {
        return null; 
      } else {
        throw Exception('Erro ao buscar localização: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<bool> updateAnimalLocation(String animalId, double latitude, double longitude) async {
    try {
      final response = await http.put(
        Uri.parse(ApiEndpoints.animalLocalizacaoById(animalId)),
        headers: ApiEndpoints.headers,
        body: json.encode({
          'latitude': latitude,
          'longitude': longitude,
          'timestamp': DateTime.now().toIso8601String(),
          'status': 'online',
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  List<AnimalLocation> filterByStatus(List<AnimalLocation> locations, String status) {
    return locations.where((location) => location.status == status).toList();
  }

  List<AnimalLocation> filterByProximity(
    List<AnimalLocation> locations, 
    double centerLat, 
    double centerLng, 
    double radiusKm
  ) {
    return locations.where((location) {
      if (location.latitude == null || location.longitude == null) return false;
      
      final distance = _calculateDistance(
        centerLat, centerLng, 
        location.latitude!, location.longitude!
      );
      
      return distance <= radiusKm;
    }).toList();
  }

  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371; 
    
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLng = _degreesToRadians(lng2 - lng1);
    
    final double a = 
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * 
        sin(dLng / 2) * sin(dLng / 2);
    
    final double c = 2 * asin(sqrt(a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  List<AnimalLocation> getMockLocations() {
    return _generateMockLocations();
  }

  void dispose() {
    stopLocationMonitoring();
    locationController.close();
  }
}
