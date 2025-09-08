// ignore_for_file: avoid_print

import 'package:aetheria/providers/sermon_provider.dart';
import 'package:aetheria/screens/sermon_display_screen.dart';
import 'package:aetheria/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SermonFormScreen extends StatelessWidget {
  SermonFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _feelingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.skyBlue,
        title: const Text('Share Your Heart'),
        elevation: 0,
      ),
      body: Consumer<SermonProvider>(
        builder: (context, sermonProvider, child) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0),

                  // Header text
                  Text(
                    'Tell us what\'s on your heart',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Share your feelings, struggles, or thoughts, and receive a personalized sermon to comfort and guide you.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Input field
                  TextFormField(
                    controller: _feelingController,
                    maxLines: 8,
                    maxLength: 1000,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(fontSize: 16.0),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please share what you\'re feeling';
                      }
                      if (value.trim().length < 10) {
                        return 'Please share a bit more about what you\'re feeling';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Share your heart...',
                      hintText:
                          'I\'ve been feeling anxious about work lately...\nI\'m struggling with loneliness...\nI need hope during this difficult time...',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: AppTheme.skyBlue,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: AppTheme.skyBlue,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Generate button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: sermonProvider.state == SermonState.loading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final topic = _feelingController.text.trim();
                                await sermonProvider.generateSermon(topic);

                                if (context.mounted &&
                                    sermonProvider.state ==
                                        SermonState.success) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SermonDisplayScreen(
                                        sermon: sermonProvider.currentSermon!,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.skyBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: sermonProvider.state == SermonState.loading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Generating your sermon...'),
                              ],
                            )
                          : const Text(
                              'Generate My Sermon',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  // Error message
                  if (sermonProvider.state == SermonState.error) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Sorry, we couldn\'t generate your sermon right now. Please try again.',
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
