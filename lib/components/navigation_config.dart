import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_navigation_bar.dart';

class NavigationConfig {
  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      icon: FontAwesomeIcons.house,
      label: 'Home',
      route: '/home',
    ),
    NavigationItem(
      icon: FontAwesomeIcons.cow,
      label: 'Produtos',
      route: '/animals',
    ),
    NavigationItem(
      icon: FontAwesomeIcons.plus,
      label: 'Cadastrar',
      route: '/register',
    ),
    NavigationItem(
      icon: FontAwesomeIcons.chartLine,
      label: 'Relatórios',
      route: '/reports',
    ),
    NavigationItem(
      icon: FontAwesomeIcons.user,
      label: 'Perfil',
      route: '/profile',
    ),
  ];

  static const List<String> routes = [
    '/home',
    '/products',
    '/register',
    '/reports',
    '/profile',
  ];
}
