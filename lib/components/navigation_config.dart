import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_navigation_bar.dart';

class NavigationConfig {
  static const List<NavigationItem> navigationItems = [
    NavigationItem(icon: FontAwesomeIcons.house, label: 'Home', route: '/home'),
    NavigationItem(
      icon: FontAwesomeIcons.cow,
      label: 'Animais',
      route: '/animals',
    ),
    NavigationItem(
      icon: FontAwesomeIcons.qrcode,
      label: 'Scanner',
      route: '/scanner',
    ),
    NavigationItem(
      icon: FontAwesomeIcons.map,
      label: 'Mapa',
      route: '/map',
    ),
  ];

  static const List<String> routes = [
    '/home',
    '/animals',
    '/scanner',
    '/map',
  ];
}
