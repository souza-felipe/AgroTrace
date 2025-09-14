import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/animal.dart';
import '../../components/navigation_wrapper.dart';
import 'components/animal_search_bar.dart';
import 'components/animal_list_item.dart';
import 'components/animal_details_modal.dart';
import 'components/animal_form_modal.dart';
import 'components/empty_animals_widget.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Animal> _animals = [];
  List<Animal> _filteredAnimals = [];

  @override
  void initState() {
    super.initState();
    _animals = Animal.getSampleAnimals();
    _filteredAnimals = _animals;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationWrapper(
      currentIndex: 1,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            AnimalSearchBar(
              controller: _searchController,
              onChanged: _filterAnimals,
            ),
            Expanded(child: _buildAnimalsList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddAnimalModal,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'PRODUTOS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Color.fromARGB(51, 255, 255, 255),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimalsList() {
    if (_filteredAnimals.isEmpty) {
      return const EmptyAnimalsWidget();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredAnimals.length,
      separatorBuilder: (context, index) => Divider(
        color: Color.fromARGB(51, 0, 0, 0),
        height: 1,
      ),
      itemBuilder: (context, index) => AnimalListItem(
        animal: _filteredAnimals[index],
        onTap: () => _showAnimalDetails(_filteredAnimals[index]),
      ),
    );
  }

  void _filterAnimals(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAnimals = _animals;
      } else {
        _filteredAnimals = _animals
            .where((animal) =>
                (animal.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                animal.id.toLowerCase().contains(query.toLowerCase()) ||
                animal.breed.toLowerCase().contains(query.toLowerCase()) ||
                animal.sisbovCode.toLowerCase().contains(query.toLowerCase()) ||
                animal.electronicId.toLowerCase().contains(query.toLowerCase()) ||
                animal.qrCode.toLowerCase().contains(query.toLowerCase()) ||
                animal.currentLot.toLowerCase().contains(query.toLowerCase()) ||
                animal.coatColor.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showAnimalDetails(Animal animal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnimalDetailsModal(animal: animal),
    );
  }

  void _showAddAnimalModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnimalFormModal(
        onSubmit: _addAnimal,
      ),
    );
  }

  void _addAnimal(Animal animal) {
    setState(() {
      _animals.add(animal);
      _filteredAnimals = _animals;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${animal.name ?? 'Animal'} cadastrado com sucesso!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}