import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/app_colors.dart';

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final Function(Map<String, String> formData)? onSignup;
  final VoidCallback? onButtonPressed;

  // Controladores externos
  final TextEditingController? nameController;
  final TextEditingController? cpfController;
  final TextEditingController? birthDateController;
  final TextEditingController? phoneController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const SignupForm({
    super.key,
    this.formKey,
    this.onSignup,
    this.onButtonPressed,
    this.nameController,
    this.cpfController,
    this.birthDateController,
    this.phoneController,
    this.emailController,
    this.passwordController,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // Controladores locais (fallback se não fornecidos externamente)
  late final TextEditingController _nameController;
  late final TextEditingController _cpfController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _nameController = widget.nameController ?? TextEditingController();
    _cpfController = widget.cpfController ?? TextEditingController();
    _birthDateController =
        widget.birthDateController ?? TextEditingController();
    _phoneController = widget.phoneController ?? TextEditingController();
    _emailController = widget.emailController ?? TextEditingController();
    _passwordController = widget.passwordController ?? TextEditingController();

    _cpfController.addListener(_formatCpf);
    _birthDateController.addListener(_formatBirthDate);
    _phoneController.addListener(_formatPhone);
  }

  @override
  void dispose() {
    _cpfController.removeListener(_formatCpf);
    _birthDateController.removeListener(_formatBirthDate);
    _phoneController.removeListener(_formatPhone);

    if (widget.nameController == null) _nameController.dispose();
    if (widget.cpfController == null) _cpfController.dispose();
    if (widget.birthDateController == null) _birthDateController.dispose();
    if (widget.phoneController == null) _phoneController.dispose();
    if (widget.emailController == null) _emailController.dispose();
    if (widget.passwordController == null) _passwordController.dispose();

    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _formatCpf() {
    final text = _cpfController.text;
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length <= 11) {
      String formatted = '';
      for (int i = 0; i < digits.length; i++) {
        if (i == 3 || i == 6) {
          formatted += '.';
        } else if (i == 9) {
          formatted += '-';
        }
        formatted += digits[i];
      }

      if (formatted != text) {
        _cpfController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }
  }

  void _formatBirthDate() {
    final text = _birthDateController.text;
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length <= 8) {
      String formatted = '';
      for (int i = 0; i < digits.length; i++) {
        if (i == 2 || i == 4) {
          formatted += '/';
        }
        formatted += digits[i];
      }

      if (formatted != text) {
        _birthDateController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }
  }

  void _formatPhone() {
    final text = _phoneController.text;
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length <= 11) {
      String formatted = '';
      for (int i = 0; i < digits.length; i++) {
        if (i == 0) {
          formatted += '(';
        } else if (i == 2) {
          formatted += ') ';
        } else if (i == 7 && digits.length == 11) {
          formatted += '-';
        } else if (i == 6 && digits.length == 10) {
          formatted += '-';
        }
        formatted += digits[i];
      }

      if (formatted != text) {
        _phoneController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }
  }

  Map<String, String> getFormData() {
    return {
      'name': _nameController.text.trim(),
      'cpf': _cpfController.text.trim(),
      'birthDate': _birthDateController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };
  }

  void clearForm() {
    _nameController.clear();
    _cpfController.clear();
    _birthDateController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void submitForm() {
    if (widget.onSignup != null) {
      final formData = getFormData();
      widget.onSignup!(formData);
    }
  }

  bool validateAndSubmit() {
    if (widget.formKey?.currentState?.validate() == true) {
      submitForm();
      return true;
    }
    return false;
  }

  bool areAllFieldsFilled() {
    final data = getFormData();
    return data.values.every((value) => value.isNotEmpty);
  }

  void validateAndSendData() {
    if (widget.formKey?.currentState?.validate() == true) {
      submitForm();
    }
  }

  Map<String, String> getFormDataPublic() {
    return getFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            hintText: 'Nome Completo',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome completo';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _buildTextField(
            controller: _cpfController,
            hintText: 'CPF',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu CPF';
              }
              final digits = value.replaceAll(RegExp(r'[^\d]'), '');
              if (digits.length != 11) {
                return 'CPF deve ter 11 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _buildTextField(
            controller: _birthDateController,
            hintText: 'Data de Nascimento (DD/MM/AAAA)',
            keyboardType: TextInputType.datetime,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua data de nascimento';
              }
              final digits = value.replaceAll(RegExp(r'[^\d]'), '');
              if (digits.length != 8) {
                return 'Data deve ter 8 dígitos (DDMMAAAA)';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _buildTextField(
            controller: _phoneController,
            hintText: 'Telefone',
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu telefone';
              }
              final digits = value.replaceAll(RegExp(r'[^\d]'), '');
              if (digits.length < 10 || digits.length > 11) {
                return 'Telefone deve ter 10 ou 11 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _buildTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu email';
              }
              if (!value.contains('@')) {
                return 'Por favor, insira um email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _buildTextField(
            controller: _passwordController,
            hintText: 'Senha',
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua senha';
              }
              if (value.length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Repetir Senha',
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, confirme sua senha';
              }
              if (value != _passwordController.text) {
                return 'As senhas não coincidem';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary.withValues(alpha: 0.7),
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
