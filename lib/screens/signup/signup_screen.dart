import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';
import 'components/signup_header.dart';
import 'components/signup_form.dart';
import 'components/terms_checkbox.dart';
import 'components/signup_button.dart';
import 'components/login_link.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _termsAccepted = false;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onTermsChanged(bool? value) {
    setState(() {
      _termsAccepted = value ?? false;
    });
  }

  Future<void> _handleSignup() async {
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você deve aceitar os termos de uso para continuar.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _showConfirmationModal();
  }

  void _showConfirmationModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmar Cadastro',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Confirme os dados antes de continuar:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildDataRow('Nome:', _nameController.text),
              _buildDataRow('CPF:', _cpfController.text),
              _buildDataRow('Data de Nascimento:', _birthDateController.text),
              _buildDataRow('Telefone:', _phoneController.text),
              _buildDataRow('Email:', _emailController.text),
              const SizedBox(height: 16),
              const Text(
                ' Confirmar os dados antes de continuar?',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = false;
                });
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _createAccount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Confirmar e Criar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'Não preenchido',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: value.isNotEmpty ? Colors.black87 : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final validationResult = _validateData();
      if (!validationResult['isValid']) {
        throw Exception(validationResult['message']);
      }

      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        cpf: _cpfController.text.trim(),
        birthDate: _birthDateController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conta criada com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        _clearForm();

        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Erro desconhecido';

        if (e.toString().contains('network error') ||
            e.toString().contains('timeout') ||
            e.toString().contains('unreachable')) {
          errorMessage =
              'Verifique sua conexão com a internet. A conta pode ter sido criada com sucesso.';
        } else if (e.toString().contains('already in use')) {
          errorMessage = 'Este email já está sendo usado.';
        } else if (e.toString().contains('weak password')) {
          errorMessage = 'A senha deve ter pelo menos 6 caracteres.';
        } else if (e.toString().contains('invalid email')) {
          errorMessage = 'Email inválido.';
        } else {
          errorMessage = 'Erro ao criar conta: ${e.toString()}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Map<String, dynamic> _validateData() {
    final name = _nameController.text.trim();
    final cpf = _cpfController.text.trim();
    final birthDate = _birthDateController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty ||
        cpf.isEmpty ||
        birthDate.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return {'isValid': false, 'message': 'Todos os campos são obrigatórios.'};
    }

    if (name.length < 3) {
      return {
        'isValid': false,
        'message': 'Nome deve ter pelo menos 3 caracteres.',
      };
    }

    final cleanCpf = cpf.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanCpf.length != 11) {
      return {'isValid': false, 'message': 'CPF deve ter 11 dígitos.'};
    }

    final cleanBirthDate = birthDate.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanBirthDate.length != 8) {
      return {
        'isValid': false,
        'message':
            'Data de nascimento deve ter 8 dígitos (DD/MM/AAAA ou DDMMAAAA).',
      };
    }

    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanPhone.length < 10 || cleanPhone.length > 11) {
      return {
        'isValid': false,
        'message': 'Telefone deve ter 10 ou 11 dígitos.',
      };
    }

    if (!email.contains('@') || !email.contains('.')) {
      return {'isValid': false, 'message': 'Email inválido.'};
    }

    if (password.length < 6) {
      return {
        'isValid': false,
        'message': 'Senha deve ter pelo menos 6 caracteres.',
      };
    }

    return {'isValid': true, 'message': 'Dados válidos.'};
  }

  void _clearForm() {
    _nameController.clear();
    _cpfController.clear();
    _birthDateController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _termsAccepted = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SignupHeader(),
              const SizedBox(height: 20),
              SignupForm(
                formKey: _formKey,
                nameController: _nameController,
                cpfController: _cpfController,
                birthDateController: _birthDateController,
                phoneController: _phoneController,
                emailController: _emailController,
                passwordController: _passwordController,
                onSignup: (formData) {},
                onButtonPressed: () {},
              ),
              const SizedBox(height: 10),
              TermsCheckbox(onChanged: _onTermsChanged, value: _termsAccepted),
              const SizedBox(height: 20),
              SignupButton(
                onSignupPressed: _handleSignup,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),
              const LoginLink(),
            ],
          ),
        ),
      ),
    );
  }
}
