import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/algorithm_model.dart';
import '../models/user_model.dart';
import '../screens/challenge_screen.dart';

class AlgorithmCard extends StatelessWidget {
  final AlgorithmModel algorithm;
  final AlgorithmProgress? progress;

  const AlgorithmCard({
    super.key,
    required this.algorithm,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = progress?.completed ?? false;
    final attempts = progress?.attempts ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChallengeScreen(algorithm: algorithm),
          ),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? theme.colorScheme.primary.withOpacity(0.2)
                      : theme.colorScheme.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    algorithm.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            algorithm.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (isCompleted)
                          Icon(
                            Icons.check_circle,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      algorithm.description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _DifficultyIndicator(difficulty: algorithm.difficulty),
                        const SizedBox(width: 12),
                        Text(
                          '${algorithm.xpReward} XP',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (attempts > 0) ...[
                          const SizedBox(width: 12),
                          Text(
                            '$attempts ${attempts == 1 ? 'attempt' : 'attempts'}',
                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }
}

class _DifficultyIndicator extends StatelessWidget {
  final int difficulty;

  const _DifficultyIndicator({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (i) => Container(
          width: 6,
          height: 12,
          margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            color: i < difficulty
                ? (difficulty == 1
                    ? Colors.green
                    : difficulty == 2
                        ? Colors.orange
                        : Colors.red)
                : Colors.grey[700],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
