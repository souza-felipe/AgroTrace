import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/animal.dart';
import '../../stores/animal_store.dart';
import '../../components/custom_app_bar.dart';

class AddAnimalScreen extends StatefulWidget {
  final String? prefilledId;
  
  const AddAnimalScreen({super.key, this.prefilledId});

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimalStore _animalStore;
  
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  
  int _currentTab = 0;

  final _codigoSisbovController = TextEditingController();
  final _idEletronicoController = TextEditingController();
  final _lotePiqueteController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _nomeAnimalController = TextEditingController();
  final _idPaiController = TextEditingController();
  final _nomePaiController = TextEditingController();
  final _idMaeController = TextEditingController();
  final _nomeMaeController = TextEditingController();
  final _alturaCernelhaController = TextEditingController();
  final _circunferenciaToracicaController = TextEditingController();
  final _perimetroEscrotalController = TextEditingController();
  final _valorAquisicaoController = TextEditingController();
  final _observacoesController = TextEditingController();

  String? _sexo;
  String? _raca;
  String? _corPelagem;
  String? _marcacoesFisicas;
  String? _origem;
  String? _statusReprodutivo;
  String? _statusVenda;
  int? _escoreCorporal;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
    _initializeStore();
    
    if (widget.prefilledId != null) {
      _idEletronicoController.text = widget.prefilledId!;
    }
  }

  Future<void> _initializeStore() async {
    _animalStore = await AnimalStore.getInstance();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _codigoSisbovController.dispose();
    _idEletronicoController.dispose();
    _lotePiqueteController.dispose();
    _dataNascimentoController.dispose();
    _nomeAnimalController.dispose();
    _idPaiController.dispose();
    _nomePaiController.dispose();
    _idMaeController.dispose();
    _nomeMaeController.dispose();
    _alturaCernelhaController.dispose();
    _circunferenciaToracicaController.dispose();
    _perimetroEscrotalController.dispose();
    _valorAquisicaoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Cadastrar Animal',
        showBackButton: true,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIdentificacaoTab(),
                _buildDadosBasicosTab(),
                _buildFiliacaoTab(),
                _buildCaracteristicasTab(),
                _buildComercialTab(),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.primary,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Tab(text: 'Identificação'),
          Tab(text: 'Dados Básicos'),
          Tab(text: 'Filiação'),
          Tab(text: 'Características'),
          Tab(text: 'Comercial'),
        ],
      ),
    );
  }

  Widget _buildIdentificacaoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Identificação'),
            
            _buildTextField(
              controller: _codigoSisbovController,
              label: 'Código SISBOV *',
              hint: '15 dígitos numéricos',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Código SISBOV é obrigatório';
                }
                if (value.length != 15) {
                  return 'Deve ter exatamente 15 dígitos (atual: ${value.length})';
                }
                if (!RegExp(r'^\d{15}$').hasMatch(value)) {
                  return 'Apenas números são permitidos';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildTextField(
              controller: _idEletronicoController,
              label: 'ID Eletrônico (Brinco/Chip) *',
              hint: 'Máximo 50 caracteres',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ID Eletrônico é obrigatório';
                }
                if (value.length > 50) {
                  return 'Máximo 50 caracteres';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildTextField(
              controller: _lotePiqueteController,
              label: 'Lote/Piquete Atual *',
              hint: 'Máximo 100 caracteres',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lote/Piquete é obrigatório';
                }
                if (value.length > 100) {
                  return 'Máximo 100 caracteres';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildTextField(
              controller: _dataNascimentoController,
              label: 'Data de Nascimento *',
              hint: 'YYYY-MM-DD',
              readOnly: true,
              onTap: () => _selectDate(context),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Data de nascimento é obrigatória';
                }
                
                final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                if (!dateRegex.hasMatch(value)) {
                  return 'Formato inválido (use YYYY-MM-DD)';
                }
                
                final date = DateTime.tryParse(value);
                if (date == null) {
                  return 'Data inválida';
                }
                
                final now = DateTime.now();
                final minDate = DateTime(1900);
                final maxDate = DateTime(now.year - 1);
                
                if (date.isBefore(minDate)) {
                  return 'Data muito antiga (mín: 1900)';
                }
                if (date.isAfter(maxDate)) {
                  return 'Data muito recente (máx: ano passado)';
                }
                
                return null;
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildTextField(
              controller: _nomeAnimalController,
              label: 'Nome do Animal',
              hint: 'Máximo 100 caracteres (opcional)',
              validator: (value) {
                if (value != null && value.length > 100) {
                  return 'Máximo 100 caracteres';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDadosBasicosTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Dados Básicos'),
          const SizedBox(height: 16),
          
          _buildDropdown(
            value: _sexo,
            label: 'Sexo *',
            items: const ['Macho', 'Fêmea'],
            onChanged: (value) => setState(() => _sexo = value),
            validator: (value) => value == null ? 'Sexo é obrigatório' : null,
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: TextEditingController(text: _raca),
            label: 'Raça *',
            hint: 'Máximo 50 caracteres',
            onChanged: (value) => _raca = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Raça é obrigatória';
              }
              if (value.length > 50) {
                return 'Máximo 50 caracteres (atual: ${value.length})';
              }
              if (value.length < 2) {
                return 'Mínimo 2 caracteres';
              }
              if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                return 'Apenas letras são permitidas';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: TextEditingController(text: _corPelagem),
            label: 'Cor da Pelagem *',
            hint: 'Máximo 50 caracteres',
            onChanged: (value) => _corPelagem = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Cor da pelagem é obrigatória';
              }
              if (value.length > 50) {
                return 'Máximo 50 caracteres (atual: ${value.length})';
              }
              if (value.length < 2) {
                return 'Mínimo 2 caracteres';
              }
              if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                return 'Apenas letras são permitidas';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: TextEditingController(text: _marcacoesFisicas),
            label: 'Marcações Físicas *',
            hint: 'Máximo 200 caracteres',
            maxLines: 3,
            onChanged: (value) => _marcacoesFisicas = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Marcações físicas são obrigatórias';
              }
              if (value.length > 200) {
                return 'Máximo 200 caracteres';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildDropdown(
            value: _origem,
            label: 'Origem *',
            items: const ['Nascimento Interno', 'Compra'],
            onChanged: (value) => setState(() => _origem = value),
            validator: (value) => value == null ? 'Origem é obrigatória' : null,
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: TextEditingController(text: _statusReprodutivo),
            label: 'Status Reprodutivo *',
            hint: 'Máximo 50 caracteres',
            onChanged: (value) => _statusReprodutivo = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Status reprodutivo é obrigatório';
              }
              if (value.length > 50) {
                return 'Máximo 50 caracteres';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: TextEditingController(text: _statusVenda),
            label: 'Status de Venda *',
            hint: 'Máximo 50 caracteres',
            onChanged: (value) => _statusVenda = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Status de venda é obrigatório';
              }
              if (value.length > 50) {
                return 'Máximo 50 caracteres';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFiliacaoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Filiação'),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _idPaiController,
            label: 'ID do Pai',
            hint: 'ID do animal pai (opcional)',
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _nomePaiController,
            label: 'Nome do Pai',
            hint: 'Nome do animal pai (opcional)',
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _idMaeController,
            label: 'ID da Mãe',
            hint: 'ID do animal mãe (opcional)',
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _nomeMaeController,
            label: 'Nome da Mãe',
            hint: 'Nome do animal mãe (opcional)',
          ),
        ],
      ),
    );
  }

  Widget _buildCaracteristicasTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Características Físicas'),
          const SizedBox(height: 16),
          
            _buildTextField(
              controller: _alturaCernelhaController,
              label: 'Altura da Cernelha (cm)',
              hint: '0-300 cm',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final height = double.tryParse(value);
                  if (height == null) {
                    return 'Digite um número válido';
                  }
                  if (height < 0) {
                    return 'Não pode ser negativo';
                  }
                  if (height > 300) {
                    return 'Máximo 300 cm';
                  }
                  if (height < 50) {
                    return 'Mínimo 50 cm (muito baixo)';
                  }
                }
                return null;
              },
            ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _circunferenciaToracicaController,
            label: 'Circunferência Torácica (cm)',
            hint: '0-500 cm',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final circumference = double.tryParse(value);
                if (circumference == null) {
                  return 'Digite um número válido';
                }
                if (circumference < 0) {
                  return 'Não pode ser negativo';
                }
                if (circumference > 500) {
                  return 'Máximo 500 cm';
                }
                if (circumference < 80) {
                  return 'Mínimo 80 cm (muito baixo)';
                }
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildDropdown(
            value: _escoreCorporal?.toString(),
            label: 'Escore Corporal',
            items: const ['1', '2', '3', '4', '5'],
            onChanged: (value) => setState(() => _escoreCorporal = value != null ? int.parse(value) : null),
          ),
          
          const SizedBox(height: 16),
          
          if (_sexo == 'Macho') ...[
            _buildTextField(
              controller: _perimetroEscrotalController,
              label: 'Perímetro Escrotal (cm)',
              hint: '0-100 cm (apenas machos)',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final perimeter = double.tryParse(value);
                  if (perimeter == null) {
                    return 'Digite um número válido';
                  }
                  if (perimeter < 0) {
                    return 'Não pode ser negativo';
                  }
                  if (perimeter > 100) {
                    return 'Máximo 100 cm';
                  }
                  if (perimeter < 10) {
                    return 'Mínimo 10 cm (muito baixo)';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildComercialTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Dados Comerciais'),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _valorAquisicaoController,
            label: 'Valor de Aquisição (R\$)',
            hint: 'Valor em reais',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final valor = double.tryParse(value);
                if (valor == null) {
                  return 'Digite um número válido';
                }
                if (valor < 0) {
                  return 'Valor não pode ser negativo';
                }
                if (valor > 1000000) {
                  return 'Valor muito alto (máx: R\$ 1.000.000)';
                }
                if (valor < 100) {
                  return 'Valor muito baixo (mín: R\$ 100)';
                }
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _observacoesController,
            label: 'Observações',
            hint: 'Máximo 1000 caracteres',
            maxLines: 5,
            validator: (value) {
              if (value != null && value.length > 1000) {
                return 'Máximo 1000 caracteres';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool readOnly = false,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentTab > 0)
            Expanded(
              child: ElevatedButton(
                onPressed: _previousTab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                child: const Text('Anterior'),
              ),
            ),
          if (_currentTab > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentTab < 4 ? _nextTab : _saveAnimal,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(_currentTab < 4 ? 'Próximo' : 'Salvar'),
            ),
          ),
        ],
      ),
    );
  }

  void _nextTab() {
    if (_currentTab == 0) {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {
          _currentTab++;
        });
        _tabController.animateTo(_currentTab);
      }
    } else {
      if (_currentTab < 4) {
        setState(() {
          _currentTab++;
        });
        _tabController.animateTo(_currentTab);
      }
    }
  }

  void _previousTab() {
    if (_currentTab > 0) {
      setState(() {
        _currentTab--;
      });
      _tabController.animateTo(_currentTab);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dataNascimentoController.text = 
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _saveAnimal() async {
    if (_currentTab == 0 && _formKey.currentState != null) {
      if (!_formKey.currentState!.validate()) {
        return;
      }
    }


    try {
      final animal = Animal(
        codigoSisbov: _codigoSisbovController.text,
        idEletronico: _idEletronicoController.text,
        lotePiqueteAtual: _lotePiqueteController.text,
        dataNascimento: _dataNascimentoController.text,
        nomeAnimal: _nomeAnimalController.text.isNotEmpty ? _nomeAnimalController.text : null,
        sexo: _sexo,
        raca: _raca,
        corPelagem: _corPelagem,
        marcacoesFisicas: _marcacoesFisicas,
        origem: _origem,
        statusReprodutivo: _statusReprodutivo,
        statusVenda: _statusVenda,
        idPai: _idPaiController.text.isNotEmpty ? _idPaiController.text : null,
        nomePai: _nomePaiController.text.isNotEmpty ? _nomePaiController.text : null,
        idMae: _idMaeController.text.isNotEmpty ? _idMaeController.text : null,
        nomeMae: _nomeMaeController.text.isNotEmpty ? _nomeMaeController.text : null,
        alturaCernelha: _alturaCernelhaController.text.isNotEmpty 
            ? double.tryParse(_alturaCernelhaController.text) : null,
        circunferenciaToracica: _circunferenciaToracicaController.text.isNotEmpty 
            ? double.tryParse(_circunferenciaToracicaController.text) : null,
        escoreCorporal: _escoreCorporal,
        perimetroEscrotal: _perimetroEscrotalController.text.isNotEmpty 
            ? double.tryParse(_perimetroEscrotalController.text) : null,
        valorAquisicao: _valorAquisicaoController.text.isNotEmpty 
            ? double.tryParse(_valorAquisicaoController.text) : null,
        observacoes: _observacoesController.text.isNotEmpty ? _observacoesController.text : null,
        dataCadastro: DateTime.now().toIso8601String().split('T')[0],
        dataAtualizacao: DateTime.now().toIso8601String().split('T')[0],
      );

   
      final missingFields = <String>[];
      if (animal.codigoSisbov == null || animal.codigoSisbov!.isEmpty) missingFields.add('Código SISBOV');
      if (animal.idEletronico == null || animal.idEletronico!.isEmpty) missingFields.add('ID Eletrônico');
      if (animal.lotePiqueteAtual == null || animal.lotePiqueteAtual!.isEmpty) missingFields.add('Lote/Piquete');
      if (animal.dataNascimento == null || animal.dataNascimento!.isEmpty) missingFields.add('Data de Nascimento');
      if (animal.sexo == null || animal.sexo!.isEmpty) missingFields.add('Sexo');
      if (animal.raca == null || animal.raca!.isEmpty) missingFields.add('Raça');
      if (animal.corPelagem == null || animal.corPelagem!.isEmpty) missingFields.add('Cor da Pelagem');
      if (animal.marcacoesFisicas == null || animal.marcacoesFisicas!.isEmpty) missingFields.add('Marcações Físicas');
      if (animal.origem == null || animal.origem!.isEmpty) missingFields.add('Origem');
      if (animal.statusReprodutivo == null || animal.statusReprodutivo!.isEmpty) missingFields.add('Status Reprodutivo');
      if (animal.statusVenda == null || animal.statusVenda!.isEmpty) missingFields.add('Status de Venda');

      if (missingFields.isNotEmpty) {
        throw Exception('Campos obrigatórios não preenchidos: ${missingFields.join(', ')}');
      }

      final success = await _animalStore.addAnimal(animal);
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Animal cadastrado com sucesso!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar animal: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
    }
  }
}
