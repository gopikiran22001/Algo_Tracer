import 'package:flutter/material.dart';
import '../models/algorithm_model.dart';
import '../challenges/binary_search_challenge.dart';
import '../challenges/bst_insertion_challenge.dart';
import '../challenges/dp_table_challenge.dart';

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
