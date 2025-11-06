import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/algorithm_model.dart';
import '../widgets/algorithm_card.dart';
import '../widgets/stats_header.dart';
import 'profile_screen.dart';
import 'leaderboard_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final algorithms = AlgorithmModel.getAllAlgorithms();
    final categories = AlgorithmCategory.values;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algo Tracer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StatsHeader(user: user),
              const SizedBox(height: 24),
              ...categories.map((category) {
                final categoryAlgos = algorithms.where((a) => a.category == category).toList();
                if (categoryAlgos.isEmpty) return const SizedBox.shrink();
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AlgorithmModel.getCategoryName(category),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...categoryAlgos.map((algo) => AlgorithmCard(
                        algorithm: algo,
                        progress: user.progress[algo.id],
                      )),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
