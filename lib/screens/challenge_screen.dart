import 'package:flutter/material.dart';
import '../models/algorithm_model.dart';
import '../challenges/binary_search_challenge.dart';
import '../challenges/bst_insertion_challenge.dart';
import '../challenges/dp_table_challenge.dart';
import '../challenges/two_sum_challenge.dart';
import '../challenges/palindrome_challenge.dart';
import '../challenges/dfs_challenge.dart';
import '../challenges/bubble_sort_challenge.dart';
import '../challenges/reverse_string_challenge.dart';
import '../challenges/valid_parentheses_challenge.dart';
import '../challenges/bfs_challenge.dart';

class ChallengeScreen extends StatelessWidget {
  final AlgorithmModel algorithm;

  const ChallengeScreen({super.key, required this.algorithm});

  @override
  Widget build(BuildContext context) {
    Widget challenge;
    
    switch (algorithm.id) {
      case 'binary_search':
        challenge = BinarySearchChallenge(algorithm: algorithm);
        break;
      case 'bst_insertion':
        challenge = BSTInsertionChallenge(algorithm: algorithm);
        break;
      case 'dp_table':
        challenge = DPTableChallenge(algorithm: algorithm);
        break;
      case 'two_sum':
        challenge = TwoSumChallenge(algorithm: algorithm);
        break;
      case 'palindrome':
        challenge = PalindromeChallenge(algorithm: algorithm);
        break;
      case 'dfs':
        challenge = DFSChallenge(algorithm: algorithm);
        break;
      case 'bubble_sort':
        challenge = BubbleSortChallenge(algorithm: algorithm);
        break;
      case 'reverse_string':
        challenge = ReverseStringChallenge(algorithm: algorithm);
        break;
      case 'valid_parentheses':
        challenge = ValidParenthesesChallenge(algorithm: algorithm);
        break;
      case 'bfs':
        challenge = BFSChallenge(algorithm: algorithm);
        break;
      default:
        challenge = Center(
          child: Text(
            'Challenge coming soon!',
            style: TextStyle(fontSize: 18, color: Colors.grey[400]),
          ),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(algorithm.name),
      ),
      body: challenge,
    );
  }
}
