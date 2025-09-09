// ignore_for_file: avoid_print

import 'package:aetheria/providers/sermon_provider.dart';
import 'package:aetheria/screens/sermon_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SermonFormScreen extends StatefulWidget {
  final String? presetFeeling;

  const SermonFormScreen({super.key, this.presetFeeling});

  @override
  State<SermonFormScreen> createState() => _SermonFormScreenState();
}

class _SermonFormScreenState extends State<SermonFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feelingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.presetFeeling != null) {
      _feelingController.text = widget.presetFeeling!;
    }
  }

  @override
  void dispose() {
    _feelingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D3748),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Share Your Heart',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<SermonProvider>(
        builder: (context, sermonProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Simple Header
                  const Text(
                    'What\'s on your mind?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Share your thoughts, feelings, or what you\'re going through.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Input Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _feelingController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'I\'ve been feeling anxious about work lately...\n\nI\'m grateful for my family but...\n\nI need guidance on...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 1.6,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Color(0xFF2D3748),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please share what\'s on your heart';
                        }
                        if (value.trim().length < 5) {
                          return 'Please provide more details';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Quick suggestions (only if no preset)
                  if (widget.presetFeeling == null) ...[
                    Text(
                      'Or tap one of these:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildSuggestionChip('Feeling anxious'),
                        _buildSuggestionChip('Need peace'),
                        _buildSuggestionChip('Feeling grateful'),
                        _buildSuggestionChip('Feeling lost'),
                        _buildSuggestionChip('Need hope'),
                        _buildSuggestionChip('Struggling with doubt'),
                      ],
                    ),
                  ],

                  const SizedBox(height: 40),

                  // Generate Button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: sermonProvider.state == SermonState.loading
                          ? null
                          : () => _generateSermon(context, sermonProvider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sermonProvider.state == SermonState.loading
                            ? Colors.grey[400]
                            : const Color(0xFF2D3748),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: sermonProvider.state == SermonState.loading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Creating your sermon...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Create Sermon',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),

                  // Error Message
                  if (sermonProvider.state == SermonState.error) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red[600],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              sermonProvider.errorMessage ??
                                  'Something went wrong. Please try again.',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  // Privacy Notice
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Colors.blue[600],
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your thoughts are private and only used to create your personalized sermon.',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return GestureDetector(
      onTap: () {
        _feelingController.text = text;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2D3748),
          ),
        ),
      ),
    );
  }

  Future<void> _generateSermon(
    BuildContext context,
    SermonProvider sermonProvider,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    await sermonProvider.generateSermon(_feelingController.text.trim());

    if (sermonProvider.state == SermonState.success &&
        sermonProvider.currentSermon != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                SermonDisplayScreen(sermon: sermonProvider.currentSermon!),
          ),
        );
      }
    }
  }
}