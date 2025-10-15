import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/animal.dart';
import '../animal_detail_screen.dart';

class AnimalListItem extends StatelessWidget {
  final Animal animal;

  const AnimalListItem({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetail(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            _buildAnimalIcon(),
            const SizedBox(width: 16),
            _buildAnimalInfo(),
            _buildStatusBadge(),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    if (animal.id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnimalDetailScreen(animalId: animal.id!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID do animal não encontrado'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildAnimalIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/gado_icon.png',
          width: 26,
          height: 26,
        ),
      ),
    );
  }

  Widget _buildAnimalInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            animal.nomeAnimal ?? 'Sem nome',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ID: ${animal.idEletronico ?? 'N/A'}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${animal.raca ?? 'N/A'} • ${animal.sexo ?? 'N/A'}',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(animal.statusVenda).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        animal.statusVenda ?? 'N/A',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _getStatusColor(animal.statusVenda),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Disponível':
        return Colors.green[600]!;
      case 'Vendido':
        return Colors.red[600]!;
      case 'Reservado':
        return Colors.amber[700]!;
      default:
        return AppColors.textSecondary;
    }
  }
}
