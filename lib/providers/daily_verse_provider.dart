import 'package:flutter/foundation.dart';
import 'package:aetheria/service/daily_verse_service.dart';

enum DailyVerseState { idle, loading, success, error }

class DailyVerseProvider with ChangeNotifier {
  final DailyVerseService _dailyVerseService = DailyVerseService();

  DailyVerseState _state = DailyVerseState.idle;
  Map<String, dynamic>? _currentVerse;
  String? _errorMessage;
  DateTime? _lastGeneratedDate;

  DailyVerseState get state => _state;
  Map<String, dynamic>? get currentVerse => _currentVerse;
  String? get errorMessage => _errorMessage;
  DateTime? get lastGeneratedDate => _lastGeneratedDate;

  bool get isToday =>
      _lastGeneratedDate != null &&
      _isSameDay(_lastGeneratedDate!, DateTime.now());

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> generateTodaysVerse() async {
    // If we already have today's verse, don't generate a new one
    if (isToday && _currentVerse != null) {
      return;
    }

    _state = DailyVerseState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final verse = await _dailyVerseService.generateDailyVerse();
      _currentVerse = verse;
      _lastGeneratedDate = DateTime.now();
      _state = DailyVerseState.success;
    } catch (error) {
      // Use fallback verse if AI generation fails
      _currentVerse = _dailyVerseService.getRandomFallbackVerse();
      _lastGeneratedDate = DateTime.now();
      _state = DailyVerseState.success;
      _errorMessage = null; // Clear error since we have a fallback

      if (kDebugMode) {
        print('Error generating daily verse, using fallback: $error');
      }
    }
    notifyListeners();
  }

  void clearVerse() {
    _currentVerse = null;
    _state = DailyVerseState.idle;
    _errorMessage = null;
    _lastGeneratedDate = null;
    notifyListeners();
  }

  // Force regenerate a new verse (useful for testing or if user wants a new one)
  Future<void> regenerateVerse() async {
    _lastGeneratedDate = null; // Clear the date to force regeneration
    await generateTodaysVerse();
  }
}
