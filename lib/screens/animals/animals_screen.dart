import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/animal.dart';
import '../../stores/animal_store.dart';
import 'components/animal_app_bar.dart';
import 'components/animal_list_item.dart';
import 'components/animal_empty_state.dart';
import 'components/animal_loading_state.dart';
import 'components/animal_filter_modal.dart';
import 'add_animal_screen.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  late AnimalStore _animalStore;
  List<Animal> _animals = [];
  List<Animal> _filteredAnimals = [];
  bool _isLoading = true;
  
  String? _loteFilter;
  String? _nomeFilter;

  @override
  void initState() {
    super.initState();
    _initializeStore();
  }

  Future<void> _initializeStore() async {
    try {
      _animalStore = await AnimalStore.getInstance();
      _animalStore.animalsStream.listen((animals) {
        if (mounted) {
          setState(() {
            _animals = animals;
            _applyFilters();
            _isLoading = false;
          });
        }
      });
      _animalStore.errorStream.listen((error) {
        if (error != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: AppColors.error),
          );
        }
      });
      await _animalStore.loadAnimals();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar dados: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AnimalAppBar(
        onFilterTap: _showFilterModal,
      ),
      body: Column(
        children: [
          if (_loteFilter != null || _nomeFilter != null) _buildActiveFiltersIndicator(),
          Expanded(child: _buildBody()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAnimalModal,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }


  Widget _buildBody() {
    if (_isLoading) {
      return const AnimalLoadingState();
    }

    if (_animals.isEmpty) {
      return const AnimalEmptyState();
    }

    if (_filteredAnimals.isEmpty) {
      return _buildNoResultsState();
    }

    return _buildAnimalsList();
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum animal encontrado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tente ajustar os filtros',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showFilterModal,
            icon: const Icon(Icons.filter_list),
            label: const Text('Ajustar Filtros'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _filteredAnimals.length,
      separatorBuilder:
          (context, index) =>
              Divider(color: Color.fromARGB(51, 0, 0, 0), height: 1),
      itemBuilder: (context, index) => AnimalListItem(animal: _filteredAnimals[index]),
    );
  }

  void _applyFilters() {
    setState(() {
      _filteredAnimals = _animals.where((animal) {
        bool loteMatch = _loteFilter == null || 
            _loteFilter!.isEmpty ||
            (animal.lotePiqueteAtual?.toLowerCase().contains(_loteFilter!.toLowerCase()) ?? false);
        
        bool nomeMatch = _nomeFilter == null || 
            _nomeFilter!.isEmpty ||
            (animal.nomeAnimal?.toLowerCase().contains(_nomeFilter!.toLowerCase()) ?? false);
        
        return loteMatch && nomeMatch;
      }).toList();
    });
  }

  void _onApplyFilters(String? loteFilter, String? nomeFilter) {
    setState(() {
      _loteFilter = loteFilter;
      _nomeFilter = nomeFilter;
      _applyFilters();
    });
  }

  Widget _buildActiveFiltersIndicator() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
      child: Row(
        children: [
          Icon(Icons.filter_list, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Filtros ativos: ${_getActiveFiltersText()}',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _onApplyFilters(null, null),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
  }

  String _getActiveFiltersText() {
    List<String> filters = [];
    if (_loteFilter != null && _loteFilter!.isNotEmpty) {
      filters.add('Lote: $_loteFilter');
    }
    if (_nomeFilter != null && _nomeFilter!.isNotEmpty) {
      filters.add('Nome: $_nomeFilter');
    }
    return filters.join(', ');
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnimalFilterModal(
        currentLoteFilter: _loteFilter,
        currentNameFilter: _nomeFilter,
        onApplyFilters: _onApplyFilters,
      ),
    );
  }


  void _showAddAnimalModal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddAnimalScreen(),
      ),
    ).then((_) {
      _animalStore.loadAnimals();
    });
  }
}
