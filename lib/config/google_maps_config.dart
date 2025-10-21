class GoogleMapsConfig {
  // Chave da API do Google Maps
  static const String apiKey = 'AIzaSyA6YaZeM1TXN6LwydvZPOEF5vL9zz-cOU0';
  
  // Configurações do mapa
  static const double defaultZoom = 15.0;
  static const double minZoom = 3.0;
  static const double maxZoom = 20.0;
  
  // Configurações de localização
  static const double defaultLatitude = -15.7801; // Brasília
  static const double defaultLongitude = -47.9292;
  
  // Configurações de atualização
  static const int locationUpdateIntervalSeconds = 30;
  static const int maxLocationAgeMinutes = 5;
  
  // Configurações de filtros
  static const double defaultProximityRadiusKm = 10.0;
  static const double maxProximityRadiusKm = 100.0;
}
