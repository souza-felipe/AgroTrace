import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/animal.dart';
import '../../stores/animal_store.dart';
import 'components/animal_detail_app_bar.dart';
import 'components/animal_detail_content.dart';
import 'components/animal_detail_loading.dart';
import 'components/animal_edit_modal.dart';
import 'components/animal_delete_modal.dart';

class AnimalDetailScreen extends StatefulWidget {
  final String animalId;

  const AnimalDetailScreen({super.key, required this.animalId});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  late AnimalStore _animalStore;
  Animal? _animal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeStore();
  }

  Future<void> _initializeStore() async {
    try {
      _animalStore = await AnimalStore.getInstance();
      _animalStore.errorStream.listen((error) {
        if (error != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: AppColors.error),
          );
        }
      });
      final animal = await _animalStore.getAnimalById(widget.animalId);
      if (mounted) {
        setState(() {
          _animal = animal;
          _isLoading = false;
        });
      }
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
      appBar: AnimalDetailAppBar(
        animalName: _animal?.nomeAnimal ?? 'Animal',
        onEdit: _showEditModal,
        onDelete: _showDeleteModal,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const AnimalDetailLoading();
    }

    if (_animal == null) {
      return _buildErrorState();
    }

    return AnimalDetailContent(animal: _animal!);
  }

  void _showEditModal() {
    if (_animal != null) {
      showDialog(
        context: context,
        builder:
            (context) =>
                AnimalEditModal(animal: _animal!, onSave: _updateAnimal),
      );
    }
  }

  void _showDeleteModal() {
    if (_animal != null) {
      showDialog(
        context: context,
        builder:
            (context) =>
                AnimalDeleteModal(animal: _animal!, onConfirm: _deleteAnimal),
      );
    }
  }

  Future<void> _updateAnimal(Animal updatedAnimal) async {
    try {
      final success = await _animalStore.updateAnimal(
        widget.animalId,
        updatedAnimal,
      );

      if (success && mounted) {
        setState(() {
          _animal = updatedAnimal;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Animal atualizado com sucesso!'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar animal: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _deleteAnimal() async {
    try {
      final success = await _animalStore.deleteAnimal(widget.animalId);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Animal deletado com sucesso!'),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao deletar animal: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Animal não encontrado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'O animal solicitado não foi encontrado',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
