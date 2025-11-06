import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class BubbleSortChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const BubbleSortChallenge({super.key, required this.algorithm});

  @override
  State<BubbleSortChallenge> createState() => _BubbleSortChallengeState();
}

class _BubbleSortChallengeState extends State<BubbleSortChallenge> {
  final List<int> _array = [5, 2, 8, 1, 9];
  int _i = 0;
  int _j = 0;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  void _swap(int index) {
    if (_completed || index != _j) return;

    if (_array[_j] > _array[_j + 1]) {
      setState(() {
        final temp = _array[_j];
        _array[_j] = _array[_j + 1];
        _array[_j + 1] = temp;
        _hint = 'Correct! Swapped ${_array[_j + 1]} and ${_array[_j]}';
        _nextStep();
      });
    } else {
      setState(() {
        _score = (_score - 10).clamp(0, 100);
        _hint = 'No swap needed! ${_array[_j]} <= ${_array[_j + 1]}';
        _nextStep();
      });
    }
  }

  void _skip() {
    if (_completed) return;
    setState(() {
      _hint = 'Skipped - no swap needed';
      _nextStep();
    });
  }

  void _nextStep() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _j++;
        if (_j >= _array.length - 1 - _i) {
          _i++;
          _j = 0;
        }
        if (_i >= _array.length - 1) {
          _onSuccess();
        }
      });
    });
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
                              'Bubble Sort',
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
                        Text('Pass: $_i | Position: $_j'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_array.length, (i) {
                        final isComparing = !_completed && (i == _j || i == _j + 1);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 60,
                          height: _array[i] * 20.0,
                          decoration: BoxDecoration(
                            color: isComparing
                                ? theme.colorScheme.primary
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${_array[i]}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isComparing ? Colors.black : Colors.white,
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
                    color: _hint!.contains('Correct') ? Colors.green[900] : Colors.orange[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(_hint!),
                    ),
                  ),
                const SizedBox(height: 16),
                if (!_completed && _j < _array.length - 1)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _swap(_j),
                          child: const Text('Swap'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _skip,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                          ),
                          child: const Text('Skip'),
                        ),
                      ),
                    ],
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
