import 'package:flutter/material.dart';
import 'custom_navigation_bar.dart';
import 'custom_app_bar.dart';
import 'navigation_config.dart';
import '../screens/home/home_screen.dart';
import '../screens/animals/animals_screen.dart';
import '../screens/scanner/qr_scanner_screen.dart';
import '../screens/map/enhanced_map_screen.dart';

class NavigationWrapper extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const NavigationWrapper({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          Widget targetScreen;
          switch (index) {
            case 0:
              targetScreen = const HomeScreen();
              break;
            case 1:
              targetScreen = const AnimalsScreen();
              break;
            case 2:
              targetScreen = const QRScannerScreen();
              break;
            case 3:
              targetScreen = const EnhancedMapScreen();
              break;
            case 4:
              targetScreen = const PlaceholderScreen(title: 'Perfil');
              break;
            default:
              targetScreen = const HomeScreen();
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        items: NavigationConfig.navigationItems,
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '$title em desenvolvimento',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF483231),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Esta funcionalidade será implementada em breve',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
