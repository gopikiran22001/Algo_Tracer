enum AlgorithmCategory { arrays, strings, hashing, dataStructures, dp, graphs }

class AlgorithmModel {
  final String id;
  final String name;
  final String description;
  final AlgorithmCategory category;
  final int difficulty;
  final int xpReward;
  final String icon;

  AlgorithmModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.xpReward,
    required this.icon,
  });

  static List<AlgorithmModel> getAllAlgorithms() => [
    AlgorithmModel(
      id: 'binary_search',
      name: 'Binary Search',
      description: 'Search in sorted array by eliminating halves',
      category: AlgorithmCategory.arrays,
      difficulty: 1,
      xpReward: 100,
      icon: '🔍',
    ),
    AlgorithmModel(
      id: 'bst_insertion',
      name: 'BST Insertion',
      description: 'Insert nodes into a Binary Search Tree',
      category: AlgorithmCategory.dataStructures,
      difficulty: 2,
      xpReward: 150,
      icon: '🌳',
    ),
    AlgorithmModel(
      id: 'dp_table',
      name: 'DP Table Fill',
      description: 'Fill dynamic programming table step by step',
      category: AlgorithmCategory.dp,
      difficulty: 3,
      xpReward: 200,
      icon: '📊',
    ),
    AlgorithmModel(
      id: 'two_sum',
      name: 'Two Sum',
      description: 'Find two numbers that add up to target',
      category: AlgorithmCategory.hashing,
      difficulty: 1,
      xpReward: 100,
      icon: '➕',
    ),
    AlgorithmModel(
      id: 'dfs',
      name: 'DFS Traversal',
      description: 'Depth-first search through a graph',
      category: AlgorithmCategory.graphs,
      difficulty: 2,
      xpReward: 150,
      icon: '🗺️',
    ),
    AlgorithmModel(
      id: 'palindrome',
      name: 'Palindrome Check',
      description: 'Check if string reads same forwards and backwards',
      category: AlgorithmCategory.strings,
      difficulty: 1,
      xpReward: 80,
      icon: '🔄',
    ),
    AlgorithmModel(
      id: 'bubble_sort',
      name: 'Bubble Sort',
      description: 'Sort array by swapping adjacent elements',
      category: AlgorithmCategory.arrays,
      difficulty: 1,
      xpReward: 100,
      icon: '🫧',
    ),
    AlgorithmModel(
      id: 'reverse_string',
      name: 'Reverse String',
      description: 'Reverse a string using two pointers',
      category: AlgorithmCategory.strings,
      difficulty: 1,
      xpReward: 80,
      icon: '↔️',
    ),
    AlgorithmModel(
      id: 'valid_parentheses',
      name: 'Valid Parentheses',
      description: 'Check if brackets are balanced using stack',
      category: AlgorithmCategory.dataStructures,
      difficulty: 2,
      xpReward: 120,
      icon: '()',
    ),
    AlgorithmModel(
      id: 'bfs',
      name: 'BFS Traversal',
      description: 'Breadth-first search through a graph',
      category: AlgorithmCategory.graphs,
      difficulty: 2,
      xpReward: 150,
      icon: '🌊',
    ),
  ];

  static String getCategoryName(AlgorithmCategory category) {
    switch (category) {
      case AlgorithmCategory.arrays: return 'Arrays';
      case AlgorithmCategory.strings: return 'Strings';
      case AlgorithmCategory.hashing: return 'Hashing';
      case AlgorithmCategory.dataStructures: return 'Data Structures';
      case AlgorithmCategory.dp: return 'Dynamic Programming';
      case AlgorithmCategory.graphs: return 'Graphs';
    }
  }
}
