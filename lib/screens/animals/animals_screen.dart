import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/animal.dart';
import '../../stores/animal_store.dart';
import '../../components/navigation_wrapper.dart';
import 'components/animal_app_bar.dart';
import 'components/animal_list_item.dart';
import 'components/animal_empty_state.dart';
import 'components/animal_loading_state.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  late AnimalStore _animalStore;
  List<Animal> _animals = [];
  bool _isLoading = true;

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
    return NavigationWrapper(
      currentIndex: 1,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const AnimalAppBar(),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddAnimalModal,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      _animalStore.loadAnimals();
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const AnimalLoadingState();
    }

    if (_animals.isEmpty) {
      return const AnimalEmptyState();
    }

    return _buildAnimalsList();
  }

  Widget _buildAnimalsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _animals.length,
      separatorBuilder:
          (context, index) =>
              Divider(color: Color.fromARGB(51, 0, 0, 0), height: 1),
      itemBuilder: (context, index) => AnimalListItem(animal: _animals[index]),
    );
  }

  void _showAddAnimalModal() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Modal de adição será implementado em breve'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
