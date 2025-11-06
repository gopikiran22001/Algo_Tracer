import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final completedCount = user.progress.values.where((p) => p.completed).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('👤', style: TextStyle(fontSize: 50)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.username,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _ProfileStat(
                        icon: '🏆',
                        label: 'Level',
                        value: '${user.level}',
                        color: theme.colorScheme.primary,
                      ),
                      const Divider(height: 32),
                      _ProfileStat(
                        icon: '⭐',
                        label: 'Total XP',
                        value: '${user.xp}',
                        color: theme.colorScheme.secondary,
                      ),
                      const Divider(height: 32),
                      _ProfileStat(
                        icon: '⚡',
                        label: 'Current Streak',
                        value: '${user.streak} days',
                        color: theme.colorScheme.primary,
                      ),
                      const Divider(height: 32),
                      _ProfileStat(
                        icon: '✅',
                        label: 'Completed',
                        value: '$completedCount algorithms',
                        color: theme.colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (user.badges.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Badges',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: user.badges.map((badge) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(badge),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await userProvider.logout();
                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const _ProfileStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 32)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
