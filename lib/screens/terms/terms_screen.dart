import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/custom_app_bar.dart';
import 'components/terms_content.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Termos e Políticas',
        showBackButton: true,
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
