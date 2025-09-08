import 'package:flutter/foundation.dart';
import 'package:aetheria/service/sermon_service.dart';

enum SermonState { idle, loading, success, error }

class SermonProvider with ChangeNotifier {
  final SermonService _sermonService = SermonService();

  SermonState _state = SermonState.idle;
  Map<String, dynamic>? _currentSermon;
  String? _errorMessage;
  List<Map<String, dynamic>> _savedSermons = [];

  SermonState get state => _state;
  Map<String, dynamic>? get currentSermon => _currentSermon;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get savedSermons => _savedSermons;

  Future<void> generateSermon(String topic) async {
    _state = SermonState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final sermon = await _sermonService.generateSermon(topic);
      _currentSermon = sermon;
      _savedSermons.insert(0, sermon); // Add to beginning of list
      _state = SermonState.success;
    } catch (error) {
      _errorMessage = error.toString();
      _state = SermonState.error;
      if (kDebugMode) {
        print('Error generating sermon: $error');
      }
    }
    notifyListeners();
  }

  void clearCurrentSermon() {
    _currentSermon = null;
    _state = SermonState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  void removeSermon(int index) {
    if (index >= 0 && index < _savedSermons.length) {
      _savedSermons.removeAt(index);
      notifyListeners();
    }
  }
}
