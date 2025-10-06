class ApiEndpoints {
  static const String baseUrl = 'http://192.168.1.10:8080/api';

  static const String animais = '$baseUrl/animais';

  static String animalById(String id) => '$baseUrl/animais/$id';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
