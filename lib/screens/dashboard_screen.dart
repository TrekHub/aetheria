import 'package:aetheria/providers/sermon_provider.dart';
import 'package:aetheria/screens/sermon_display_screen.dart';
import 'package:aetheria/screens/sermon_form_screen.dart';
import 'package:aetheria/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with gradient
          SliverAppBar.large(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome to',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.8)),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          'Aetheria',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          'Sermons for the soul',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.white.withOpacity(0.9)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily Inspiration Card
                  _buildDailyInspirationCard(context),

                  const SizedBox(height: AppTheme.spacingL),

                  // Quick Actions
                  _buildQuickActions(context),

                  const SizedBox(height: AppTheme.spacingL),

                  // Recent Sermons
                  Consumer<SermonProvider>(
                    builder: (context, sermonProvider, child) {
                      return _buildRecentSermons(context, sermonProvider);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: AppTheme.primaryButtonDecoration,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SermonFormScreen()),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.auto_fix_high, color: Colors.white),
          label: const Text(
            'Create Sermon',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyInspirationCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.glassMorphism,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingS),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.wb_sunny_outlined,
                  color: AppTheme.primaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                'Daily Inspiration',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            '"But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint."',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— Isaiah 40:31',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.psychology_outlined,
                title: 'Find Peace',
                subtitle: 'When feeling anxious',
                color: AppTheme.successGreen,
                onTap: () =>
                    _navigateToForm(context, 'feeling anxious and need peace'),
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.favorite_outline,
                title: 'Show Gratitude',
                subtitle: 'Count your blessings',
                color: AppTheme.warningOrange,
                onTap: () => _navigateToForm(context, 'grateful and thankful'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingM),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.healing_outlined,
                title: 'Seek Healing',
                subtitle: 'When feeling hurt',
                color: AppTheme.accentPurple,
                onTap: () => _navigateToForm(context, 'hurt and need healing'),
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.lightbulb_outline,
                title: 'Find Hope',
                subtitle: 'In difficult times',
                color: AppTheme.primaryBlue,
                onTap: () =>
                    _navigateToForm(context, 'hopeless and need encouragement'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingS),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
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
            Text(
              'Recent Sermons',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (sermonProvider.savedSermons.length > 3)
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all sermons
                },
                child: const Text('See All'),
              ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingM),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sermonProvider.savedSermons.length.clamp(0, 3),
          itemBuilder: (context, index) {
            final sermon = sermonProvider.savedSermons[index];
            return _buildSermonCard(context, sermon, index);
          },
        ),
      ],
    );
  }

  Widget _buildSermonCard(
    BuildContext context,
    Map<String, dynamic> sermon,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SermonDisplayScreen(sermon: sermon),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          decoration: AppTheme.glassMorphism,
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sermon['title'] ?? 'Untitled Sermon',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    if (sermon['bible_verse'] != null)
                      Text(
                        sermon['bible_verse']['reference'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppTheme.textLight,
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
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            decoration: BoxDecoration(
              color: AppTheme.lightBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
            ),
            child: const Icon(
              Icons.auto_stories_outlined,
              size: 48,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          Text(
            'No Sermons Yet',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Start by sharing how you\'re feeling, and let AI create a personalized sermon just for you.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingL),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SermonFormScreen()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Your First Sermon'),
          ),
        ],
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
