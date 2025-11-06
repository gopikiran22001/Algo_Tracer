import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class TwoSumChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const TwoSumChallenge({super.key, required this.algorithm});

  @override
  State<TwoSumChallenge> createState() => _TwoSumChallengeState();
}

class _TwoSumChallengeState extends State<TwoSumChallenge> {
  final List<int> _array = [2, 7, 11, 15];
  final int _target = 9;
  final Map<int, int> _map = {};
  int? _selected1;
  int? _selected2;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  void _selectIndex(int index) {
    if (_completed) return;

    if (_selected1 == null) {
      setState(() => _selected1 = index);
    } else if (_selected2 == null && index != _selected1) {
      setState(() => _selected2 = index);
      _checkAnswer();
    }
  }

  void _checkAnswer() {
    if (_array[_selected1!] + _array[_selected2!] == _target) {
      _onSuccess();
    } else {
      setState(() {
        _score = (_score - 10).clamp(0, 100);
        _hint = 'Wrong! ${_array[_selected1!]} + ${_array[_selected2!]} ≠ $_target. Try again.';
        _selected1 = null;
        _selected2 = null;
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
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Target: $_target',
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
                        const Text('Select two numbers that add up to the target'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(_array.length, (i) {
                        final isSelected = i == _selected1 || i == _selected2;
                        return GestureDetector(
                          onTap: !_completed ? () => _selectIndex(i) : null,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${_array[i]}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                if (_hint != null)
                  Card(
                    color: Colors.red[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.white),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_hint!)),
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
