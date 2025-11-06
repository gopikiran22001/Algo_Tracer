import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUser = context.watch<UserProvider>().user!;

    final mockLeaderboard = [
      {'username': 'AlgoMaster', 'xp': 2500, 'level': 6},
      {'username': 'CodeNinja', 'xp': 2100, 'level': 5},
      {'username': currentUser.username, 'xp': currentUser.xp, 'level': currentUser.level},
      {'username': 'DevPro', 'xp': 1200, 'level': 3},
      {'username': 'ByteWizard', 'xp': 900, 'level': 2},
    ]..sort((a, b) => (b['xp'] as int).compareTo(a['xp'] as int));

    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 40)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Global Ranking',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Compete with others',
                        style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockLeaderboard.length,
                itemBuilder: (context, index) {
                  final entry = mockLeaderboard[index];
                  final isCurrentUser = entry['username'] == currentUser.username;
                  final rank = index + 1;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: isCurrentUser
                        ? theme.colorScheme.primary.withOpacity(0.1)
                        : theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: rank <= 3
                                  ? (rank == 1
                                      ? Colors.amber
                                      : rank == 2
                                          ? Colors.grey[400]
                                          : Colors.brown[300])
                                  : theme.colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                rank <= 3 ? ['🥇', '🥈', '🥉'][rank - 1] : '#$rank',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: rank <= 3 ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry['username'] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isCurrentUser
                                        ? theme.colorScheme.primary
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Level ${entry['level']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${entry['xp']} XP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
