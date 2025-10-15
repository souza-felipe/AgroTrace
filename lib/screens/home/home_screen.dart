import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import '../../components/navigation_wrapper.dart';
import '../../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onProfileTap() {}

  @override
  Widget build(BuildContext context) {
    return NavigationWrapper(
      currentIndex: 0, // Índice para "Home"
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Home', onProfileTap: _onProfileTap),
        body: const Center(
          child: Text(
            'Bem-vindo ao AgroTrace',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
