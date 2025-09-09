import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';

class SermonService {
  final model = FirebaseAI.vertexAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  Future<Map<String, dynamic>> generateSermon(String topic) async {
    final prompt = [
      Content.text(
        'Give me a short sermon, should include a Bible verse and short preaching '
        'on this topic/feeling: $topic. The response should comeback as a json with '
        'a title, intro, a bible verse object, preaching and a call to action.\n\n'
        'Make sure the bible verse object has two fields, verse and reference. '
        'The response should be in the following format:\n\n'
        '{\n'
        '  "title": "Your Title Here",\n'
        '  "poster": "poster svg - generate a suitable svg poster for the sermon",\n'
        '  "intro": "Your introduction here.",\n'
        '  "bible_verse": {\n'
        '    "verse": "The Bible verse here.",\n'
        '    "reference": "Book Chapter:Verse"\n'
        '  },\n'
        '  "preaching": "Your preaching content here.",\n'
        '  "call_to_action": "Your call to action here."\n'
        '}\n\n'
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
}
