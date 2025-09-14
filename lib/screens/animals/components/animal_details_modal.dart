import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/animal.dart';
import '../../../components/cow_icon.dart';

class AnimalDetailsModal extends StatelessWidget {
  final Animal animal;

  const AnimalDetailsModal({
    super.key,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Color.fromARGB(77, 0, 0, 0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color.fromARGB(77, 0, 0, 0), width: 1),
                        ),
                        child: CowIcon(size: 30, color: Colors.black, isFilled: true),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              animal.name ?? 'Sem Nome',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '#${animal.id}',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow('Raça', animal.breed),
                  _buildDetailRow('Sexo', animal.sex == AnimalSex.male ? 'Macho' : 'Fêmea'),
                  _buildDetailRow('Data de Nascimento', 
                      '${animal.birthDate.day}/${animal.birthDate.month}/${animal.birthDate.year}'),
                  _buildDetailRow('Idade', '${animal.ageInYears} anos e ${animal.ageInMonths % 12} meses'),
                  _buildDetailRow('Código SISBOV', animal.sisbovCode),
                  _buildDetailRow('ID Eletrônico', animal.electronicId),
                  _buildDetailRow('Lote Atual', animal.currentLot),
                  _buildDetailRow('Status Reprodutivo', _getReproductiveStatusText(animal.reproductiveStatus)),
                  _buildDetailRow('Status de Venda', _getSaleStatusText(animal.saleStatus)),
                  if (animal.currentWeight != null)
                    _buildDetailRow('Peso Atual', '${animal.currentWeight!.toStringAsFixed(1)} kg'),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Editar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Excluir'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color.fromARGB(179, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getReproductiveStatusText(ReproductiveStatus status) {
    switch (status) {
      case ReproductiveStatus.maleApt:
        return 'Macho Apto';
      case ReproductiveStatus.femaleInCycle:
        return 'Fêmea em Ciclo';
      case ReproductiveStatus.pregnant:
        return 'Gestante';
      case ReproductiveStatus.lactating:
        return 'Lactante';
      case ReproductiveStatus.dry:
        return 'Seco';
      case ReproductiveStatus.castrated:
        return 'Castrado';
      case ReproductiveStatus.infertile:
        return 'Infértil';
    }
  }

  String _getSaleStatusText(SaleStatus status) {
    switch (status) {
      case SaleStatus.available:
        return 'Disponível';
      case SaleStatus.sold:
        return 'Vendido';
      case SaleStatus.destinedForSlaughter:
        return 'Destinado ao Abate';
      case SaleStatus.reserved:
        return 'Reservado';
    }
  }
}
