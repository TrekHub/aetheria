import 'package:aetheria/providers/sermon_provider.dart';
import 'package:aetheria/screens/sermon_display_screen.dart';
import 'package:aetheria/screens/sermon_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // Simple Header
              _buildHeader(context),
              
              const SizedBox(height: 40),
              
              // Today's Verse - Clean and Simple
              _buildTodaysVerse(context),
              
              const SizedBox(height: 36),
              
              // How are you feeling? Section
              _buildFeelingSection(context),
              
              const SizedBox(height: 36),
              
              // Recent Sermons
              Consumer<SermonProvider>(
                builder: (context, sermonProvider, child) {
                  return _buildRecentSermons(context, sermonProvider);
                },
              ),
              
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: _buildSimpleFAB(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning 🌅',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aetheria',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            color: Color(0xFF2D3748),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysVerse(BuildContext context) {
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
            'Today\'s Verse',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '"Be still, and know that I am God; I will be exalted among the nations, I will be exalted in the earth."',
            style: TextStyle(
              fontSize: 18,
              height: 1.6,
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Psalm 46:10',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildFeelingChip(
              context,
              'Anxious',
              '😰',
              'feeling anxious and need peace',
            ),
            _buildFeelingChip(
              context,
              'Grateful',
              '🙏',
              'grateful and thankful',
            ),
            _buildFeelingChip(
              context,
              'Hurt',
              '💔',
              'hurt and need healing',
            ),
            _buildFeelingChip(
              context,
              'Lost',
              '🌫️',
              'lost and need direction',
            ),
            _buildFeelingChip(
              context,
              'Hopeful',
              '🌟',
              'hopeful and expectant',
            ),
            _buildFeelingChip(
              context,
              'Tired',
              '😴',
              'tired and need rest',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeelingChip(
    BuildContext context,
    String label,
    String emoji,
    String preset,
  ) {
    return GestureDetector(
      onTap: () => _navigateToForm(context, preset),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF2D3748),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSermons(
    BuildContext context,
    SermonProvider sermonProvider,
  ) {
    if (sermonProvider.savedSermons.isEmpty) {
      return _buildEmptyState(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Sermons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2D3748),
              ),
            ),
            if (sermonProvider.savedSermons.length > 2)
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to all sermons
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sermonProvider.savedSermons.length.clamp(0, 2),
          itemBuilder: (context, index) {
            final sermon = sermonProvider.savedSermons[index];
            return _buildSermonCard(context, sermon);
          },
        ),
      ],
    );
  }

  Widget _buildSermonCard(BuildContext context, Map<String, dynamic> sermon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SermonDisplayScreen(sermon: sermon),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.article_outlined,
                  color: Color(0xFF718096),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sermon['title'] ?? 'Untitled Sermon',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2D3748),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (sermon['bible_verse'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        sermon['bible_verse']['reference'] ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.auto_stories_outlined,
              color: Color(0xFF718096),
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No sermons yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first personalized sermon',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SermonFormScreen()),
        );
      },
      backgroundColor: const Color(0xFF2D3748),
      elevation: 2,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  void _navigateToForm(BuildContext context, String preset) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SermonFormScreen(presetFeeling: preset),
      ),
    );
  }
}