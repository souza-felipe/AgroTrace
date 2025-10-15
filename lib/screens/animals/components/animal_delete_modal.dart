import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/animal.dart';

class AnimalDeleteModal extends StatelessWidget {
  final Animal animal;
  final VoidCallback onConfirm;

  const AnimalDeleteModal({
    super.key,
    required this.animal,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildContent(),
            const SizedBox(height: 24),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.delete, color: Colors.red[600], size: 24),
        const SizedBox(width: 8),
        const Text(
          'Deletar Animal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Icon(Icons.warning, size: 64, color: Colors.orange[600]),
        const SizedBox(height: 16),
        Text(
          'Tem certeza que deseja deletar este animal?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          '${animal.nomeAnimal ?? 'Animal'} (${animal.idEletronico ?? 'N/A'})',
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.red[600], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Esta ação não pode ser desfeita. Todos os dados do animal serão perdidos permanentemente.',
                  style: TextStyle(fontSize: 12, color: Colors.red[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Cancelar'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Deletar'),
          ),
        ),
      ],
    );
  }
}
