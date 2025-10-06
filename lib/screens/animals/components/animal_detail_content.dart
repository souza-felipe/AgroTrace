import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/animal.dart';

class AnimalDetailContent extends StatelessWidget {
  final Animal animal;

  const AnimalDetailContent({
    super.key,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimalHeader(),
          const SizedBox(height: 24),
          _buildIdentificationSection(),
          const SizedBox(height: 24),
          _buildBasicDataSection(),
          const SizedBox(height: 24),
          _buildParentageSection(),
          const SizedBox(height: 24),
          _buildPhysicalCharacteristicsSection(),
          const SizedBox(height: 24),
          _buildCommercialSection(),
        ],
      ),
    );
  }

  Widget _buildAnimalHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/images/gado_icon.png',
                width: 36,
                height: 36,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  animal.nomeAnimal ?? 'Sem nome',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: ${animal.idEletronico ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${animal.raca ?? 'N/A'} • ${animal.sexo ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(animal.statusVenda).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        animal.statusVenda ?? 'N/A',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: _getStatusColor(animal.statusVenda),
        ),
      ),
    );
  }

  Widget _buildIdentificationSection() {
    return _buildSection(
      title: 'Identificação',
      icon: Icons.fingerprint,
      children: [
        _buildInfoRow('Nome do Animal', animal.nomeAnimal ?? 'Não informado'),
        _buildInfoRow('Código SISBOV', animal.codigoSisbov ?? 'Não informado'),
        _buildInfoRow('ID Eletrônico', animal.idEletronico ?? 'Não informado'),
        _buildInfoRow('Lote/Piquete', animal.lotePiqueteAtual ?? 'Não informado'),
        _buildInfoRow('Data de Nascimento', animal.dataNascimento ?? 'Não informado'),
      ],
    );
  }

  Widget _buildBasicDataSection() {
    return _buildSection(
      title: 'Dados Básicos',
      icon: Icons.info,
      children: [
        _buildInfoRow('Sexo', animal.sexo ?? 'Não informado'),
        _buildInfoRow('Raça', animal.raca ?? 'Não informado'),
        _buildInfoRow('Cor da Pelagem', animal.corPelagem ?? 'Não informado'),
        _buildInfoRow('Marcações Físicas', animal.marcacoesFisicas ?? 'Não informado'),
        _buildInfoRow('Origem', animal.origem ?? 'Não informado'),
        _buildInfoRow('Status Reprodutivo', animal.statusReprodutivo ?? 'Não informado'),
      ],
    );
  }

  Widget _buildParentageSection() {
    return _buildSection(
      title: 'Filiação',
      icon: Icons.family_restroom,
      children: [
        _buildInfoRow('ID do Pai', animal.idPai ?? 'Não informado'),
        _buildInfoRow('Nome do Pai', animal.nomePai ?? 'Não informado'),
        _buildInfoRow('ID da Mãe', animal.idMae ?? 'Não informado'),
        _buildInfoRow('Nome da Mãe', animal.nomeMae ?? 'Não informado'),
      ],
    );
  }

  Widget _buildPhysicalCharacteristicsSection() {
    return _buildSection(
      title: 'Características Físicas',
      icon: Icons.straighten,
      children: [
        _buildInfoRow('Altura na Cernelha', animal.alturaCernelha != null ? '${animal.alturaCernelha} cm' : 'Não informado'),
        _buildInfoRow('Circunferência Torácica', animal.circunferenciaToracica != null ? '${animal.circunferenciaToracica} cm' : 'Não informado'),
        _buildInfoRow('Escore Corporal', animal.escoreCorporal != null ? '${animal.escoreCorporal}/5' : 'Não informado'),
        _buildInfoRow('Perímetro Escrotal', animal.perimetroEscrotal != null ? '${animal.perimetroEscrotal} cm' : 'Não informado'),
      ],
    );
  }

  Widget _buildCommercialSection() {
    return _buildSection(
      title: 'Dados Comerciais',
      icon: Icons.attach_money,
      children: [
        _buildInfoRow('Valor de Aquisição', animal.valorAquisicao != null ? 'R\$ ${animal.valorAquisicao!.toStringAsFixed(2)}' : 'Não informado'),
        _buildInfoRow('Status de Venda', animal.statusVenda ?? 'Não informado'),
        _buildInfoRow('Observações', animal.observacoes ?? 'Não informado'),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
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
