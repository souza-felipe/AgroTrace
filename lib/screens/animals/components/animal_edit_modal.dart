import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/animal.dart';

class AnimalEditModal extends StatefulWidget {
  final Animal animal;
  final Function(Animal) onSave;

  const AnimalEditModal({
    super.key,
    required this.animal,
    required this.onSave,
  });

  @override
  State<AnimalEditModal> createState() => _AnimalEditModalState();
}

class _AnimalEditModalState extends State<AnimalEditModal> {
  late TextEditingController _nomeController;
  late TextEditingController _codigoSisbovController;
  late TextEditingController _idEletronicoController;
  late TextEditingController _lotePiqueteController;
  late TextEditingController _dataNascimentoController;
  late TextEditingController _racaController;
  late TextEditingController _corPelagemController;
  late TextEditingController _marcacoesFisicasController;
  late TextEditingController _origemController;
  late TextEditingController _statusReprodutivoController;
  late TextEditingController _idPaiController;
  late TextEditingController _nomePaiController;
  late TextEditingController _idMaeController;
  late TextEditingController _nomeMaeController;
  late TextEditingController _alturaCernelhaController;
  late TextEditingController _circunferenciaToracicaController;
  late TextEditingController _escoreCorporalController;
  late TextEditingController _perimetroEscrotalController;
  late TextEditingController _valorAquisicaoController;
  late TextEditingController _observacoesController;

  late String _sexo;
  late String _statusVenda;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _sexo = widget.animal.sexo ?? 'Macho';
    _statusVenda = widget.animal.statusVenda ?? 'Disponível';
  }

  void _initializeControllers() {
    _nomeController = TextEditingController(
      text: widget.animal.nomeAnimal ?? '',
    );
    _codigoSisbovController = TextEditingController(
      text: widget.animal.codigoSisbov ?? '',
    );
    _idEletronicoController = TextEditingController(
      text: widget.animal.idEletronico ?? '',
    );
    _lotePiqueteController = TextEditingController(
      text: widget.animal.lotePiqueteAtual ?? '',
    );
    _dataNascimentoController = TextEditingController(
      text: widget.animal.dataNascimento ?? '',
    );
    _racaController = TextEditingController(text: widget.animal.raca ?? '');
    _corPelagemController = TextEditingController(
      text: widget.animal.corPelagem ?? '',
    );
    _marcacoesFisicasController = TextEditingController(
      text: widget.animal.marcacoesFisicas ?? '',
    );
    _origemController = TextEditingController(text: widget.animal.origem ?? '');
    _statusReprodutivoController = TextEditingController(
      text: widget.animal.statusReprodutivo ?? '',
    );
    _idPaiController = TextEditingController(text: widget.animal.idPai ?? '');
    _nomePaiController = TextEditingController(
      text: widget.animal.nomePai ?? '',
    );
    _idMaeController = TextEditingController(text: widget.animal.idMae ?? '');
    _nomeMaeController = TextEditingController(
      text: widget.animal.nomeMae ?? '',
    );
    _alturaCernelhaController = TextEditingController(
      text: widget.animal.alturaCernelha?.toString() ?? '',
    );
    _circunferenciaToracicaController = TextEditingController(
      text: widget.animal.circunferenciaToracica?.toString() ?? '',
    );
    _escoreCorporalController = TextEditingController(
      text: widget.animal.escoreCorporal?.toString() ?? '',
    );
    _perimetroEscrotalController = TextEditingController(
      text: widget.animal.perimetroEscrotal?.toString() ?? '',
    );
    _valorAquisicaoController = TextEditingController(
      text: widget.animal.valorAquisicao?.toString() ?? '',
    );
    _observacoesController = TextEditingController(
      text: widget.animal.observacoes ?? '',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoSisbovController.dispose();
    _idEletronicoController.dispose();
    _lotePiqueteController.dispose();
    _dataNascimentoController.dispose();
    _racaController.dispose();
    _corPelagemController.dispose();
    _marcacoesFisicasController.dispose();
    _origemController.dispose();
    _statusReprodutivoController.dispose();
    _idPaiController.dispose();
    _nomePaiController.dispose();
    _idMaeController.dispose();
    _nomeMaeController.dispose();
    _alturaCernelhaController.dispose();
    _circunferenciaToracicaController.dispose();
    _escoreCorporalController.dispose();
    _perimetroEscrotalController.dispose();
    _valorAquisicaoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildIdentificationSection(),
                    const SizedBox(height: 24),
                    _buildBasicDataSection(),
                    const SizedBox(height: 24),
                    _buildParentageSection(),
                    const SizedBox(height: 24),
                    _buildPhysicalCharacteristicsSection(),
                    const SizedBox(height: 24),
                    _buildCommercialSection(),
                    const SizedBox(height: 24),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.edit, color: AppColors.primary, size: 24),
        const SizedBox(width: 8),
        const Text(
          'Editar Animal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildIdentificationSection() {
    return _buildSection(
      title: 'Identificação',
      icon: Icons.fingerprint,
      children: [
        _buildTextField(
          controller: _nomeController,
          label: 'Nome do Animal',
          hint: 'Digite o nome do animal',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _codigoSisbovController,
          label: 'Código SISBOV',
          hint: 'Digite o código SISBOV (15 dígitos)',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _idEletronicoController,
          label: 'ID Eletrônico',
          hint: 'Digite o ID eletrônico (brinco/chip)',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _lotePiqueteController,
          label: 'Lote/Piquete Atual',
          hint: 'Digite o lote ou piquete atual',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _dataNascimentoController,
          label: 'Data de Nascimento',
          hint: 'YYYY-MM-DD',
        ),
      ],
    );
  }

  Widget _buildBasicDataSection() {
    return _buildSection(
      title: 'Dados Básicos',
      icon: Icons.info,
      children: [
        _buildSexDropdown(),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _racaController,
          label: 'Raça',
          hint: 'Digite a raça do animal',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _corPelagemController,
          label: 'Cor da Pelagem',
          hint: 'Digite a cor da pelagem',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _marcacoesFisicasController,
          label: 'Marcações Físicas',
          hint: 'Descreva as marcações físicas',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _origemController,
          label: 'Origem',
          hint: 'Nascimento Interno ou Compra',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _statusReprodutivoController,
          label: 'Status Reprodutivo',
          hint: 'Digite o status reprodutivo',
        ),
      ],
    );
  }

  Widget _buildParentageSection() {
    return _buildSection(
      title: 'Filiação',
      icon: Icons.family_restroom,
      children: [
        _buildTextField(
          controller: _idPaiController,
          label: 'ID do Pai',
          hint: 'Digite o ID do pai',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _nomePaiController,
          label: 'Nome do Pai',
          hint: 'Digite o nome do pai',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _idMaeController,
          label: 'ID da Mãe',
          hint: 'Digite o ID da mãe',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _nomeMaeController,
          label: 'Nome da Mãe',
          hint: 'Digite o nome da mãe',
        ),
      ],
    );
  }

  Widget _buildPhysicalCharacteristicsSection() {
    return _buildSection(
      title: 'Características Físicas',
      icon: Icons.straighten,
      children: [
        _buildTextField(
          controller: _alturaCernelhaController,
          label: 'Altura na Cernelha (cm)',
          hint: 'Digite a altura em cm',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _circunferenciaToracicaController,
          label: 'Circunferência Torácica (cm)',
          hint: 'Digite a circunferência em cm',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _escoreCorporalController,
          label: 'Escore Corporal (1-5)',
          hint: 'Digite o escore de 1 a 5',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _perimetroEscrotalController,
          label: 'Perímetro Escrotal (cm)',
          hint: 'Digite o perímetro em cm',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildCommercialSection() {
    return _buildSection(
      title: 'Dados Comerciais',
      icon: Icons.attach_money,
      children: [
        _buildTextField(
          controller: _valorAquisicaoController,
          label: 'Valor de Aquisição (R\$)',
          hint: 'Digite o valor em reais',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildStatusDropdown(),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _observacoesController,
          label: 'Observações',
          hint: 'Digite observações sobre o animal',
          maxLines: 3,
        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSexDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sexo',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _sexo,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Macho', child: Text('Macho')),
            DropdownMenuItem(value: 'Fêmea', child: Text('Fêmea')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _sexo = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status de Venda',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _statusVenda,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Disponível', child: Text('Disponível')),
            DropdownMenuItem(value: 'Vendido', child: Text('Vendido')),
            DropdownMenuItem(value: 'Reservado', child: Text('Reservado')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _statusVenda = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildActions() {
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
            onPressed: _saveAnimal,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Salvar'),
          ),
        ),
      ],
    );
  }

  void _saveAnimal() {
    final updatedAnimal = widget.animal.copyWith(
      nomeAnimal:
          _nomeController.text.trim().isEmpty
              ? null
              : _nomeController.text.trim(),
      codigoSisbov:
          _codigoSisbovController.text.trim().isEmpty
              ? null
              : _codigoSisbovController.text.trim(),
      idEletronico:
          _idEletronicoController.text.trim().isEmpty
              ? null
              : _idEletronicoController.text.trim(),
      lotePiqueteAtual:
          _lotePiqueteController.text.trim().isEmpty
              ? null
              : _lotePiqueteController.text.trim(),
      dataNascimento:
          _dataNascimentoController.text.trim().isEmpty
              ? null
              : _dataNascimentoController.text.trim(),

      sexo: _sexo,
      raca:
          _racaController.text.trim().isEmpty
              ? null
              : _racaController.text.trim(),
      corPelagem:
          _corPelagemController.text.trim().isEmpty
              ? null
              : _corPelagemController.text.trim(),
      marcacoesFisicas:
          _marcacoesFisicasController.text.trim().isEmpty
              ? null
              : _marcacoesFisicasController.text.trim(),
      origem:
          _origemController.text.trim().isEmpty
              ? null
              : _origemController.text.trim(),
      statusReprodutivo:
          _statusReprodutivoController.text.trim().isEmpty
              ? null
              : _statusReprodutivoController.text.trim(),

      idPai:
          _idPaiController.text.trim().isEmpty
              ? null
              : _idPaiController.text.trim(),
      nomePai:
          _nomePaiController.text.trim().isEmpty
              ? null
              : _nomePaiController.text.trim(),
      idMae:
          _idMaeController.text.trim().isEmpty
              ? null
              : _idMaeController.text.trim(),
      nomeMae:
          _nomeMaeController.text.trim().isEmpty
              ? null
              : _nomeMaeController.text.trim(),

      alturaCernelha:
          _alturaCernelhaController.text.trim().isEmpty
              ? null
              : double.tryParse(_alturaCernelhaController.text.trim()),
      circunferenciaToracica:
          _circunferenciaToracicaController.text.trim().isEmpty
              ? null
              : double.tryParse(_circunferenciaToracicaController.text.trim()),
      escoreCorporal:
          _escoreCorporalController.text.trim().isEmpty
              ? null
              : int.tryParse(_escoreCorporalController.text.trim()),
      perimetroEscrotal:
          _perimetroEscrotalController.text.trim().isEmpty
              ? null
              : double.tryParse(_perimetroEscrotalController.text.trim()),

      valorAquisicao:
          _valorAquisicaoController.text.trim().isEmpty
              ? null
              : double.tryParse(_valorAquisicaoController.text.trim()),
      statusVenda: _statusVenda,
      observacoes:
          _observacoesController.text.trim().isEmpty
              ? null
              : _observacoesController.text.trim(),
    );

    widget.onSave(updatedAnimal);
    Navigator.pop(context);
  }
}
