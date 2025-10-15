import 'dart:async';
import '../models/animal.dart';
import '../repositories/animal_repository.dart';

class AnimalStore {
  static AnimalStore? _instance;
  static AnimalRepository? _repository;

  final StreamController<List<Animal>> _animalsController =
      StreamController<List<Animal>>.broadcast();
  final StreamController<bool> _loadingController =
      StreamController<bool>.broadcast();
  final StreamController<String?> _errorController =
      StreamController<String?>.broadcast();

  List<Animal> _animals = [];
  bool _isLoading = false;
  String? _error;

  AnimalStore._();

  static Future<AnimalStore> getInstance() async {
    if (_instance == null) {
      _instance = AnimalStore._();
      _repository = AnimalRepository();
    }
    return _instance!;
  }

  Stream<List<Animal>> get animalsStream => _animalsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<String?> get errorStream => _errorController.stream;

  List<Animal> get animals => List.unmodifiable(_animals);
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAnimals() async {
    try {
      _setLoading(true);
      _setError(null);

      final animals = await _repository!.getAllAnimals();
      _animals = animals;
      if (!_animalsController.isClosed) {
        _animalsController.add(_animals);
      }
    } catch (e) {
      _setError('Erro ao carregar animais: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<Animal?> getAnimalById(String id) async {
    try {
      _setLoading(true);
      _setError(null);
      final animal = await _repository!.getAnimalById(id);
      return animal;
    } catch (e) {
      _setError('Erro ao buscar animal: $e');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateAnimal(String id, Animal animal) async {
    try {
      _setLoading(true);
      _setError(null);
      final updatedAnimal = await _repository!.updateAnimal(id, animal);
      if (_animals.isNotEmpty) {
        final index = _animals.indexWhere((a) => a.id == id);
        if (index != -1) {
          _animals[index] = updatedAnimal;
          if (!_animalsController.isClosed) {
            _animalsController.add(_animals);
          }
        }
      }
      return true;
    } catch (e) {
      _setError('Erro ao atualizar animal: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteAnimal(String id) async {
    try {
      _setLoading(true);
      _setError(null);
      final success = await _repository!.deleteAnimal(id);
      if (success) {
        if (_animals.isNotEmpty) {
          _animals.removeWhere((a) => a.id == id);
          if (!_animalsController.isClosed) {
            _animalsController.add(_animals);
          }
        }
        await loadAnimals();
      }
      return success;
    } catch (e) {
      _setError('Erro ao deletar animal: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addAnimal(Animal animal) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repository!.createAnimal(animal);
      return true;
    } catch (e) {
      _setError('Erro ao adicionar animal: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _setError(null);
  }

  void clearAnimals() {
    _animals.clear();
    if (!_animalsController.isClosed) {
      _animalsController.add(_animals);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    if (!_loadingController.isClosed) {
      _loadingController.add(_isLoading);
    }
  }

  void _setError(String? error) {
    _error = error;
    if (!_errorController.isClosed) {
      _errorController.add(_error);
    }
  }

  void dispose() {
    if (!_animalsController.isClosed) {
      _animalsController.close();
    }
    if (!_loadingController.isClosed) {
      _loadingController.close();
    }
    if (!_errorController.isClosed) {
      _errorController.close();
    }
  }
}
