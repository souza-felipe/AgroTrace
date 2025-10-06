import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/animal.dart';
import '../api/endpoints.dart';

class AnimalRepository {
  Future<List<Animal>> getAllAnimals() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.animais),
        headers: ApiEndpoints.headers,
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        List<dynamic> jsonList;

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            jsonList = responseData['data'] as List<dynamic>;
          } else if (responseData.containsKey('animals')) {
            jsonList = responseData['animals'] as List<dynamic>;
          } else if (responseData.containsKey('items')) {
            jsonList = responseData['items'] as List<dynamic>;
          } else {
            jsonList = [];
          }
        } else if (responseData is List) {
          jsonList = responseData;
        } else {
          jsonList = [];
        }

        return jsonList.map((json) => Animal.fromMap(json)).toList();
      } else {
        throw Exception('Erro ao buscar animais: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<Animal> getAnimalById(String id) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.animalById(id)),
        headers: ApiEndpoints.headers,
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        Map<String, dynamic> animalData;

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            animalData = responseData['data'] as Map<String, dynamic>;
          } else if (responseData.containsKey('animal')) {
            animalData = responseData['animal'] as Map<String, dynamic>;
          } else {
            animalData = responseData;
          }
        } else {
          throw Exception('Formato de resposta não reconhecido');
        }

        return Animal.fromMap(animalData);
      } else {
        throw Exception('Erro ao buscar animal: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<Animal> updateAnimal(String id, Animal animal) async {
    try {
      final response = await http.put(
        Uri.parse(ApiEndpoints.animalById(id)),
        headers: ApiEndpoints.headers,
        body: json.encode(animal.toMap()),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        Map<String, dynamic> animalData;

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            animalData = responseData['data'] as Map<String, dynamic>;
          } else if (responseData.containsKey('animal')) {
            animalData = responseData['animal'] as Map<String, dynamic>;
          } else {
            animalData = responseData;
          }
        } else {
          throw Exception('Formato de resposta não reconhecido');
        }

        return Animal.fromMap(animalData);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Erro ao atualizar animal: ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<bool> deleteAnimal(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(ApiEndpoints.animalById(id)),
        headers: ApiEndpoints.headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Erro ao deletar animal: ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<Animal> createAnimal(Animal animal) async {
    try {
      if (!animal.isValid()) {
        final missingFields = animal.getMissingRequiredFields();
        throw Exception(
          'Campos obrigatórios não preenchidos: ${missingFields.join(', ')}',
        );
      }

      final response = await http.post(
        Uri.parse(ApiEndpoints.animais),
        headers: ApiEndpoints.headers,
        body: json.encode(animal.toMap()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Animal.fromMap(json);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Erro ao criar animal: ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}
