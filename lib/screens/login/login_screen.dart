import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'components/login_header.dart';
import 'components/login_form.dart';
import 'components/social_login.dart';
import 'components/signup_link.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const LoginHeader(),
              const SizedBox(height: 10),
              const LoginForm(),
              const SocialLogin(),
              const SizedBox(height: 30),
              const SignupLink(),
            ],
          ),
        ),
      ),
    );
  }
}
