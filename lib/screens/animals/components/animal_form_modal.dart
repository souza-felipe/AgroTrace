import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/animal.dart';

class AnimalFormModal extends StatefulWidget {
  final Function(Animal) onSubmit;

  const AnimalFormModal({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AnimalFormModal> createState() => _AnimalFormModalState();
}

class _AnimalFormModalState extends State<AnimalFormModal> with TickerProviderStateMixin {
  late TabController _tabController;
  
  // Controllers para identificação
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sisbovController = TextEditingController();
  final TextEditingController _electronicIdController = TextEditingController();
  final TextEditingController _currentLotController = TextEditingController();
  
  // Controllers para dados básicos
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _coatColorController = TextEditingController();
  final TextEditingController _markingsController = TextEditingController();
  
  // Controllers para filiação
  final TextEditingController _fatherIdController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherIdController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  
  // Controllers para características físicas
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _scrotalController = TextEditingController();
  
  // Controllers para comercial
  final TextEditingController _acquisitionValueController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  
  // Variáveis de estado
  DateTime _selectedDate = DateTime.now();
  AnimalSex _selectedSex = AnimalSex.male;
  AnimalOrigin _selectedOrigin = AnimalOrigin.internal;
  ReproductiveStatus _selectedReproductiveStatus = ReproductiveStatus.maleApt;
  SaleStatus _selectedSaleStatus = SaleStatus.available;
  int _bodyConditionScore = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _generateDefaultIds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _sisbovController.dispose();
    _electronicIdController.dispose();
    _currentLotController.dispose();
    _breedController.dispose();
    _coatColorController.dispose();
    _markingsController.dispose();
    _fatherIdController.dispose();
    _fatherNameController.dispose();
    _motherIdController.dispose();
    _motherNameController.dispose();
    _heightController.dispose();
    _chestController.dispose();
    _scrotalController.dispose();
    _acquisitionValueController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  void _generateDefaultIds() {
    final now = DateTime.now();
    _sisbovController.text = 'BR${now.millisecondsSinceEpoch.toString().substring(0, 13)}';
    _electronicIdController.text = 'EID${now.millisecondsSinceEpoch.toString().substring(8)}';
    _currentLotController.text = 'LOTE-A';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Text(
                  'Cadastrar Animal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primary,
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'Identificação'),
              Tab(text: 'Dados Básicos'),
              Tab(text: 'Filiação'),
              Tab(text: 'Físicas'),
              Tab(text: 'Comercial'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIdentificationTab(),
                _buildBasicDataTab(),
                _buildParentageTab(),
                _buildPhysicalTab(),
                _buildCommercialTab(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _clearForm();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Aba de Identificação
  Widget _buildIdentificationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'Nome do Animal (opcional)',
            hint: 'Ex: Robson',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _sisbovController,
            label: 'Código SISBOV (15 dígitos)',
            hint: 'BR123456789012345',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _electronicIdController,
            label: 'ID Eletrônico (Brinco/Chip)',
            hint: 'EID001',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _currentLotController,
            label: 'Lote/Piquete Atual',
            hint: 'LOTE-A',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          _buildDateField(),
        ],
      ),
    );
  }

  // Aba de Dados Básicos
  Widget _buildBasicDataTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          _buildSexSelector(),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _breedController,
            label: 'Raça',
            hint: 'Ex: Nelore',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _coatColorController,
            label: 'Cor da Pelagem',
            hint: 'Ex: Branco, Amarelo, Preto',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _markingsController,
            label: 'Marcações Físicas',
            hint: 'Ex: Ferro na coxa, Tatuagem 1234',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          _buildOriginSelector(),
          const SizedBox(height: 12),
          _buildReproductiveStatusSelector(),
        ],
      ),
    );
  }

  // Aba de Filiação
  Widget _buildParentageTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          _buildTextField(
            controller: _fatherIdController,
            label: 'ID do Pai',
            hint: 'Ex: 001',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _fatherNameController,
            label: 'Nome do Pai',
            hint: 'Ex: Touro Nelore 001',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _motherIdController,
            label: 'ID da Mãe',
            hint: 'Ex: 002',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _motherNameController,
            label: 'Nome da Mãe',
            hint: 'Ex: Vaca Gir 002',
          ),
        ],
      ),
    );
  }

  // Aba de Características Físicas
  Widget _buildPhysicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          _buildTextField(
            controller: _heightController,
            label: 'Altura na Cernelha (cm)',
            hint: 'Ex: 140',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _chestController,
            label: 'Circunferência Torácica (cm)',
            hint: 'Ex: 180',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          _buildBodyConditionScoreSelector(),
          const SizedBox(height: 12),
          if (_selectedSex == AnimalSex.male)
            _buildTextField(
              controller: _scrotalController,
              label: 'Perímetro Escrotal (cm)',
              hint: 'Ex: 35',
              keyboardType: TextInputType.number,
            ),
        ],
      ),
    );
  }

  // Aba Comercial
  Widget _buildCommercialTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          _buildTextField(
            controller: _acquisitionValueController,
            label: 'Valor de Aquisição (R\$)',
            hint: 'Ex: 2500.00',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          _buildSaleStatusSelector(),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _observationsController,
            label: 'Observações',
            hint: 'Informações adicionais sobre o animal',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  // Widgets auxiliares
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Color.fromARGB(153, 0, 0, 0)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color.fromARGB(77, 0, 0, 0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color.fromARGB(77, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data de Nascimento *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(77, 0, 0, 0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.black),
                const SizedBox(width: 12),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSexSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sexo *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: [
            RadioListTile<AnimalSex>(
              title: const Text('Macho'),
              value: AnimalSex.male,
              groupValue: _selectedSex,
              onChanged: (value) {
                setState(() {
                  _selectedSex = value!;
                  _updateReproductiveStatus();
                });
              },
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
            RadioListTile<AnimalSex>(
              title: const Text('Fêmea'),
              value: AnimalSex.female,
              groupValue: _selectedSex,
              onChanged: (value) {
                setState(() {
                  _selectedSex = value!;
                  _updateReproductiveStatus();
                });
              },
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOriginSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Origem *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: [
            RadioListTile<AnimalOrigin>(
              title: const Text('Nascimento Interno'),
              value: AnimalOrigin.internal,
              groupValue: _selectedOrigin,
              onChanged: (value) => setState(() => _selectedOrigin = value!),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
            RadioListTile<AnimalOrigin>(
              title: const Text('Compra'),
              value: AnimalOrigin.purchased,
              groupValue: _selectedOrigin,
              onChanged: (value) => setState(() => _selectedOrigin = value!),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReproductiveStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status Reprodutivo *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<ReproductiveStatus>(
          value: _selectedReproductiveStatus,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color.fromARGB(77, 0, 0, 0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: ReproductiveStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(_getReproductiveStatusText(status)),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedReproductiveStatus = value!),
        ),
      ],
    );
  }

  Widget _buildBodyConditionScoreSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escore Corporal (1-5)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(5, (index) {
            final score = index + 1;
            return SizedBox(
              width: 60,
              child: RadioListTile<int>(
                title: Text(
                  score.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                value: score,
                groupValue: _bodyConditionScore,
                onChanged: (value) => setState(() => _bodyConditionScore = value!),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSaleStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status de Venda *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<SaleStatus>(
          value: _selectedSaleStatus,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color.fromARGB(77, 0, 0, 0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: SaleStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(_getSaleStatusText(status)),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedSaleStatus = value!),
        ),
      ],
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

  void _updateReproductiveStatus() {
    if (_selectedSex == AnimalSex.male) {
      _selectedReproductiveStatus = ReproductiveStatus.maleApt;
    } else {
      _selectedReproductiveStatus = ReproductiveStatus.femaleInCycle;
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_sisbovController.text.isEmpty || 
        _electronicIdController.text.isEmpty || 
        _breedController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha os campos obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final now = DateTime.now();
    final animal = Animal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sisbovCode: _sisbovController.text,
      electronicId: _electronicIdController.text,
      qrCode: 'QR${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.isEmpty ? null : _nameController.text.toUpperCase(),
      currentLot: _currentLotController.text,
      sex: _selectedSex,
      breed: _breedController.text,
      birthDate: _selectedDate,
      coatColor: _coatColorController.text,
      markings: _markingsController.text,
      origin: _selectedOrigin,
      fatherId: _fatherIdController.text.isEmpty ? null : _fatherIdController.text,
      fatherName: _fatherNameController.text.isEmpty ? null : _fatherNameController.text,
      motherId: _motherIdController.text.isEmpty ? null : _motherIdController.text,
      motherName: _motherNameController.text.isEmpty ? null : _motherNameController.text,
      heightAtWithers: _heightController.text.isEmpty ? null : double.tryParse(_heightController.text),
      chestCircumference: _chestController.text.isEmpty ? null : double.tryParse(_chestController.text),
      bodyConditionScore: _bodyConditionScore,
      scrotalCircumference: _scrotalController.text.isEmpty ? null : double.tryParse(_scrotalController.text),
      reproductiveStatus: _selectedReproductiveStatus,
      currentLocation: 'Fazenda Principal',
      acquisitionValue: _acquisitionValueController.text.isEmpty ? null : double.tryParse(_acquisitionValueController.text),
      saleStatus: _selectedSaleStatus,
      observations: _observationsController.text.isEmpty ? null : _observationsController.text,
      createdAt: now,
      updatedAt: now,
      createdBy: 'admin',
      updatedBy: 'admin',
    );

    widget.onSubmit(animal);
    Navigator.pop(context);
    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _sisbovController.clear();
    _electronicIdController.clear();
    _currentLotController.clear();
    _breedController.clear();
    _coatColorController.clear();
    _markingsController.clear();
    _fatherIdController.clear();
    _fatherNameController.clear();
    _motherIdController.clear();
    _motherNameController.clear();
    _heightController.clear();
    _chestController.clear();
    _scrotalController.clear();
    _acquisitionValueController.clear();
    _observationsController.clear();
    _selectedDate = DateTime.now();
    _selectedSex = AnimalSex.male;
    _selectedOrigin = AnimalOrigin.internal;
    _selectedReproductiveStatus = ReproductiveStatus.maleApt;
    _selectedSaleStatus = SaleStatus.available;
    _bodyConditionScore = 3;
    _generateDefaultIds();
  }
}
