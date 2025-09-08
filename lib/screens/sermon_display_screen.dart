import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aetheria/utils/app_theme.dart';

class SermonDisplayScreen extends StatelessWidget {
  final Map<String, dynamic> sermon;

  const SermonDisplayScreen({super.key, required this.sermon});

  @override
  Widget build(BuildContext context) {
    final bibleVerse = sermon['bible_verse'] as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.skyBlue,
        title: Text('Your Sermon'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster SVG
            if (sermon['poster'] != null)
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SvgPicture.string(
                    sermon['poster'],
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) => Container(
                      color: AppTheme.skyBlue.withOpacity(0.3),
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),

            // Title
            Text(
              sermon['title'] ?? 'Untitled Sermon',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Introduction
            if (sermon['intro'] != null) ...[
              _buildSectionCard(
                title: 'Introduction',
                content: sermon['intro'],
                icon: Icons.lightbulb_outline,
              ),
              const SizedBox(height: 16),
            ],

            // Bible Verse
            if (bibleVerse != null) ...[
              _buildBibleVerseCard(bibleVerse),
              const SizedBox(height: 16),
            ],

            // Preaching
            if (sermon['preaching'] != null) ...[
              _buildSectionCard(
                title: 'Message',
                content: sermon['preaching'],
                icon: Icons.auto_stories,
              ),
              const SizedBox(height: 16),
            ],

            // Call to Action
            if (sermon['call_to_action'] != null) ...[
              _buildCallToActionCard(sermon['call_to_action']),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.skyBlue, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBibleVerseCard(Map<String, dynamic> bibleVerse) {
    return Card(
      elevation: 3,
      color: AppTheme.skyBlue.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book, color: AppTheme.skyBlue, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Scripture',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.skyBlue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${bibleVerse['verse'] ?? ''}"',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '— ${bibleVerse['reference'] ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.skyBlue,
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
  }

  Widget _buildCallToActionCard(String callToAction) {
    return Card(
      elevation: 3,
      color: AppTheme.skyBlue.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red.shade400, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Call to Action',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              callToAction,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
