class ApiEndpoints {
  static const String baseUrl = 'http://192.168.1.9:8080/api';

  static const String animais = '$baseUrl/animais';

  static String animalById(String id) => '$baseUrl/animais/$id';
  
  static const String animaisLocalizacao = '$baseUrl/animais/localizacao';
  static String animalLocalizacaoById(String id) => '$baseUrl/animais/$id/localizacao';
  static const String animaisLocalizacaoTempoReal = '$baseUrl/animais/localizacao/tempo-real';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
