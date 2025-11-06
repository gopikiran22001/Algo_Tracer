import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class BinarySearchChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const BinarySearchChallenge({super.key, required this.algorithm});

  @override
  State<BinarySearchChallenge> createState() => _BinarySearchChallengeState();
}

class _BinarySearchChallengeState extends State<BinarySearchChallenge> {
  final List<int> _array = [2, 5, 8, 12, 16, 23, 38, 45, 56, 67, 78];
  final int _target = 23;
  int _left = 0;
  late int _right;
  int? _mid;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _right = _array.length - 1;
  }

  void _selectIndex(int index) {
    if (_completed) return;

    final correctMid = (_left + _right) ~/ 2;
    
    if (index == correctMid) {
      setState(() {
        _mid = index;
        _hint = null;
      });
      
      if (_array[index] == _target) {
        _onSuccess();
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            if (_array[index] < _target) {
              _left = index + 1;
            } else {
              _right = index - 1;
            }
            _mid = null;
          });
        });
      }
    } else {
      setState(() {
        _score = (_score - 10).clamp(0, 100);
        _hint = 'Choose the middle element between indices $_left and $_right';
      });
    }
  }

  void _onSuccess() {
    setState(() => _completed = true);
    _confettiController.play();
    context.read<UserProvider>().completeAlgorithm(widget.algorithm.id, _score);
    
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessOverlay(
            score: _score,
            xpEarned: widget.algorithm.xpReward,
            onContinue: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Find: $_target',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Text(
                              'Score: $_score',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap the middle element of the search range',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_array.length, (i) {
                          final isInRange = i >= _left && i <= _right;
                          final isMid = i == _mid;
                          final isTarget = _array[i] == _target && _completed;

                          return GestureDetector(
                            onTap: isInRange && !_completed ? () => _selectIndex(i) : null,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 60,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isTarget
                                    ? theme.colorScheme.primary
                                    : isMid
                                        ? theme.colorScheme.secondary
                                        : isInRange
                                            ? theme.colorScheme.surface
                                            : Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isInRange
                                      ? theme.colorScheme.primary
                                      : Colors.grey[800]!,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${_array[i]}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isTarget || isMid
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '[$i]',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isTarget || isMid
                                          ? Colors.black54
                                          : Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                if (_hint != null)
                  Card(
                    color: Colors.orange[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.orange),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_hint!)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How Binary Search Works:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '1. Find middle element\n'
                          '2. If middle == target, found!\n'
                          '3. If middle < target, search right half\n'
                          '4. If middle > target, search left half',
                          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary, Colors.white],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}
