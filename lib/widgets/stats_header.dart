import 'package:flutter/material.dart';
import '../models/user_model.dart';

class StatsHeader extends StatelessWidget {
  final UserModel user;

  const StatsHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedCount = user.progress.values.where((p) => p.completed).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${user.username}!',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level ${user.level}',
                    style: TextStyle(fontSize: 16, color: theme.colorScheme.primary),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '🏆',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: '⚡',
                label: 'Streak',
                value: '${user.streak}',
                color: theme.colorScheme.primary,
              ),
              _StatItem(
                icon: '✅',
                label: 'Completed',
                value: '$completedCount',
                color: theme.colorScheme.secondary,
              ),
              _StatItem(
                icon: '⭐',
                label: 'XP',
                value: '${user.xp}',
                color: theme.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (user.xp % 500) / 500,
              minHeight: 8,
              backgroundColor: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${user.xp % 500} / 500 XP to Level ${user.level + 1}',
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        ),
      ],
    );
  }
}
