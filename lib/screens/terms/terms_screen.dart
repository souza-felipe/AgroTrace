import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'components/terms_content.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Termos e Políticas AgroTrace'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: const TermsContent()),
          ],
        ),
      ),
    );
  }
}
