class UserModel {
  final String id;
  final String email;
  final String username;
  final int level;
  final int xp;
  final int streak;
  final List<String> badges;
  final Map<String, AlgorithmProgress> progress;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.level = 1,
    this.xp = 0,
    this.streak = 0,
    this.badges = const [],
    this.progress = const {},
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'username': username,
    'level': level,
    'xp': xp,
    'streak': streak,
    'badges': badges,
    'progress': progress.map((k, v) => MapEntry(k, v.toJson())),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    username: json['username'],
    level: json['level'] ?? 1,
    xp: json['xp'] ?? 0,
    streak: json['streak'] ?? 0,
    badges: List<String>.from(json['badges'] ?? []),
    progress: (json['progress'] as Map<String, dynamic>?)?.map(
      (k, v) => MapEntry(k, AlgorithmProgress.fromJson(v)),
    ) ?? {},
  );

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    int? level,
    int? xp,
    int? streak,
    List<String>? badges,
    Map<String, AlgorithmProgress>? progress,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    username: username ?? this.username,
    level: level ?? this.level,
    xp: xp ?? this.xp,
    streak: streak ?? this.streak,
    badges: badges ?? this.badges,
    progress: progress ?? this.progress,
  );
}

class AlgorithmProgress {
  final bool completed;
  final int attempts;
  final int bestScore;
  final DateTime? lastAttempt;

  AlgorithmProgress({
    this.completed = false,
    this.attempts = 0,
    this.bestScore = 0,
    this.lastAttempt,
  });

  Map<String, dynamic> toJson() => {
    'completed': completed,
    'attempts': attempts,
    'bestScore': bestScore,
    'lastAttempt': lastAttempt?.toIso8601String(),
  };

  factory AlgorithmProgress.fromJson(Map<String, dynamic> json) => AlgorithmProgress(
    completed: json['completed'] ?? false,
    attempts: json['attempts'] ?? 0,
    bestScore: json['bestScore'] ?? 0,
    lastAttempt: json['lastAttempt'] != null ? DateTime.parse(json['lastAttempt']) : null,
  );
}
