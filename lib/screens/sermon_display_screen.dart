import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SermonDisplayScreen extends StatelessWidget {
  final Map<String, dynamic> sermon;

  const SermonDisplayScreen({super.key, required this.sermon});

  @override
  Widget build(BuildContext context) {
    final bibleVerse = sermon['bible_verse'] as Map<String, dynamic>?;

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
          'Your Sermon',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster (if available) - simplified
            if (sermon['poster'] != null) ...[
              Container(
                width: double.infinity,
                height: 180,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SvgPicture.string(
                    sermon['poster'],
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) => Container(
                      color: Colors.grey[100],
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ),
            ],

            // Title
            Text(
              sermon['title'] ?? 'Your Sermon',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Color(0xFF2D3748),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 32),

            // Bible Verse - featured prominently
            if (bibleVerse != null) ...[
              _buildBibleVerse(bibleVerse),
              const SizedBox(height: 32),
            ],

            // Introduction
            if (sermon['intro'] != null) ...[
              _buildSection('Introduction', sermon['intro']),
              const SizedBox(height: 24),
            ],

            // Main Message
            if (sermon['preaching'] != null) ...[
              _buildSection('Message', sermon['preaching']),
              const SizedBox(height: 24),
            ],

            // Call to Action
            if (sermon['call_to_action'] != null) ...[
              _buildCallToAction(sermon['call_to_action']),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBibleVerse(Map<String, dynamic> bibleVerse) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scripture',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '"${bibleVerse['verse'] ?? ''}"',
            style: const TextStyle(
              fontSize: 20,
              height: 1.6,
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              bibleVerse['reference'] ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildCallToAction(String callToAction) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reflection',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            callToAction,
            style: const TextStyle(
              fontSize: 18,
              height: 1.6,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}