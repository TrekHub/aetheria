// ignore_for_file: avoid_print

import 'package:aetheria/providers/sermon_provider.dart';
import 'package:aetheria/screens/sermon_display_screen.dart';
import 'package:aetheria/utils/app_theme.dart';
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
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        title: const Text('Share Your Heart'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<SermonProvider>(
        builder: (context, sermonProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingL),
                      decoration: AppTheme.glassMorphism,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppTheme.spacingM),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusXL,
                              ),
                            ),
                            child: const Icon(
                              Icons.favorite_outline,
                              color: AppTheme.primaryBlue,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          Text(
                            'What\'s on your heart?',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppTheme.spacingS),
                          Text(
                            'Share your feelings, struggles, joys, or thoughts. Our AI will create a personalized sermon to comfort, guide, and inspire you.',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Input Section
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingL),
                      decoration: AppTheme.glassMorphism,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your feeling or situation',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: AppTheme.spacingS),
                          TextFormField(
                            controller: _feelingController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText:
                                  'I\'m feeling anxious about the future...\nI\'m grateful for...\nI\'m struggling with...\nI need guidance on...',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please share what\'s on your heart';
                              }
                              if (value.trim().length < 5) {
                                return 'Please provide more details (at least 5 characters)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Quick suggestions
                          if (widget.presetFeeling == null) ...[
                            Text(
                              'Quick suggestions:',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            Wrap(
                              spacing: AppTheme.spacingS,
                              runSpacing: AppTheme.spacingXS,
                              children: [
                                _buildSuggestionChip('Feeling anxious'),
                                _buildSuggestionChip('Need hope'),
                                _buildSuggestionChip('Feeling grateful'),
                                _buildSuggestionChip('Struggling with doubt'),
                                _buildSuggestionChip('Need peace'),
                                _buildSuggestionChip('Feeling lonely'),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Generate Button
                    Container(
                      height: 56,
                      decoration: sermonProvider.state == SermonState.loading
                          ? null
                          : AppTheme.primaryButtonDecoration,
                      child: ElevatedButton.icon(
                        onPressed: sermonProvider.state == SermonState.loading
                            ? null
                            : () => _generateSermon(context, sermonProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              sermonProvider.state == SermonState.loading
                              ? AppTheme.textLight
                              : Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusMedium,
                            ),
                          ),
                        ),
                        icon: sermonProvider.state == SermonState.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.auto_fix_high,
                                color: Colors.white,
                              ),
                        label: Text(
                          sermonProvider.state == SermonState.loading
                              ? 'Creating your sermon...'
                              : 'Generate Sermon',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Error Message
                    if (sermonProvider.state == SermonState.error) ...[
                      const SizedBox(height: AppTheme.spacingM),
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        decoration: BoxDecoration(
                          color: AppTheme.errorRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                          border: Border.all(
                            color: AppTheme.errorRed.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppTheme.errorRed,
                            ),
                            const SizedBox(width: AppTheme.spacingS),
                            Expanded(
                              child: Text(
                                sermonProvider.errorMessage ??
                                    'Failed to generate sermon. Please try again.',
                                style: const TextStyle(
                                  color: AppTheme.errorRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppTheme.spacingXL),

                    // Privacy Notice
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppTheme.lightBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.privacy_tip_outlined,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacingS),
                          Expanded(
                            child: Text(
                              'Your thoughts are private and secure. We use them only to create your personalized sermon.',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppTheme.textMedium),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return InkWell(
      onTap: () {
        _feelingController.text = text;
      },
      borderRadius: BorderRadius.circular(AppTheme.radiusXL),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingXS,
        ),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppTheme.primaryBlue,
            fontSize: 12,
            fontWeight: FontWeight.w500,
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
