import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_nome.png',
          width: 340,
          height: 200,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
