import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/algorithm_model.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthService _authService = AuthService();

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> loadUser() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    if (success) {
      await loadUser();
    }
    return success;
  }

  Future<bool> signup(String email, String password, String username) async {
    final success = await _authService.signup(email, password, username);
    if (success) {
      await loadUser();
    }
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  void completeAlgorithm(String algorithmId, int score) {
    if (_user == null) return;
    
    final progress = _user!.progress[algorithmId] ?? AlgorithmProgress();
    final newProgress = AlgorithmProgress(
      completed: true,
      attempts: progress.attempts + 1,
      bestScore: score > progress.bestScore ? score : progress.bestScore,
      lastAttempt: DateTime.now(),
    );
    
    final algorithm = AlgorithmModel.getAllAlgorithms().firstWhere((a) => a.id == algorithmId);
    final newXp = _user!.xp + algorithm.xpReward;
    final newLevel = (newXp / 500).floor() + 1;
    
    final updatedProgress = Map<String, AlgorithmProgress>.from(_user!.progress);
    updatedProgress[algorithmId] = newProgress;
    
    _user = _user!.copyWith(
      xp: newXp,
      level: newLevel,
      progress: updatedProgress,
      streak: _user!.streak + 1,
    );
    
    _authService.updateUser(_user!);
    notifyListeners();
  }

  void addBadge(String badge) {
    if (_user == null || _user!.badges.contains(badge)) return;
    _user = _user!.copyWith(badges: [..._user!.badges, badge]);
    _authService.updateUser(_user!);
    notifyListeners();
  }
}
