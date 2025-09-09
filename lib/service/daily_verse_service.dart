import 'dart:convert';
import 'dart:math';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';

class DailyVerseService {
  final model = FirebaseAI.vertexAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  Future<Map<String, dynamic>> generateDailyVerse() async {
    final prompt = [
      Content.text(
        'Generate an inspirational Bible verse for today. The response should be a JSON object '
        'with the following format:\n\n'
        '{\n'
        '  "verse": "The Bible verse text here.",\n'
        '  "reference": "Book Chapter:Verse",\n'
        '  "theme": "A brief theme or message of the verse (e.g., Peace, Hope, Faith, Love)"\n'
        '}\n\n'
        'Choose a verse that would be encouraging and uplifting for someone starting their day. '
        'Make sure the verse is accurate and the reference is correct. '
        'Ensure the JSON is properly formatted.',
      ),
    ];

    final response = await model.generateContent(prompt);
    // Get the raw AI output
    var raw = response.text ?? '';

    // Strip code fences if present
    raw = raw
        .replaceAll(RegExp(r'```json'), '')
        .replaceAll(RegExp(r'```'), '')
        .trim();

    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      return data;
    } catch (error) {
      if (kDebugMode) {
        print('Error parsing JSON: $error');
        print('Raw response: $raw');
      }
      rethrow;
    }
  }

  // Fallback verses in case AI generation fails
  List<Map<String, dynamic>> getFallbackVerses() {
    return [
      {
        "verse":
            "Be still, and know that I am God; I will be exalted among the nations, I will be exalted in the earth.",
        "reference": "Psalm 46:10",
        "theme": "Peace",
      },
      {
        "verse":
            "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, to give you hope and a future.",
        "reference": "Jeremiah 29:11",
        "theme": "Hope",
      },
      {
        "verse": "I can do all things through Christ who strengthens me.",
        "reference": "Philippians 4:13",
        "theme": "Strength",
      },
      {
        "verse":
            "Trust in the Lord with all your heart and lean not on your own understanding.",
        "reference": "Proverbs 3:5",
        "theme": "Trust",
      },
      {
        "verse":
            "The Lord your God is with you, the Mighty Warrior who saves. He will take great delight in you; in his love he will no longer rebuke you, but will rejoice over you with singing.",
        "reference": "Zephaniah 3:17",
        "theme": "Love",
      },
    ];
  }

  Map<String, dynamic> getRandomFallbackVerse() {
    final verses = getFallbackVerses();
    final random = Random();
    return verses[random.nextInt(verses.length)];
  }
}
