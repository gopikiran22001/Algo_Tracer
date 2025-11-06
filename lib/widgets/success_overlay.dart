import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SuccessOverlay extends StatelessWidget {
  final int score;
  final int xpEarned;
  final VoidCallback onContinue;

  const SuccessOverlay({
    super.key,
    required this.score,
    required this.xpEarned,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🎉',
              style: const TextStyle(fontSize: 80),
            ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),
            Text(
              'Challenge Complete!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatBadge(
                  icon: '⭐',
                  label: 'Score',
                  value: '$score',
                  color: theme.colorScheme.primary,
                ),
                _StatBadge(
                  icon: '✨',
                  label: 'XP Earned',
                  value: '+$xpEarned',
                  color: theme.colorScheme.secondary,
                ),
              ],
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 300.ms),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                child: const Text('Continue'),
              ),
            ).animate().fadeIn(delay: 500.ms),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        ),
      ],
    );
  }
}
