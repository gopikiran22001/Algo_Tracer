import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class ReverseStringChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const ReverseStringChallenge({super.key, required this.algorithm});

  @override
  State<ReverseStringChallenge> createState() => _ReverseStringChallengeState();
}

class _ReverseStringChallengeState extends State<ReverseStringChallenge> {
  final List<String> _chars = ['h', 'e', 'l', 'l', 'o'];
  int _left = 0;
  late int _right;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _right = _chars.length - 1;
  }

  void _swapPointers() {
    if (_completed) return;

    setState(() {
      final temp = _chars[_left];
      _chars[_left] = _chars[_right];
      _chars[_right] = temp;
      _left++;
      _right--;
      _hint = 'Correct! Swapped characters';
    });

    if (_left >= _right) {
      _onSuccess();
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reverse String',
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
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_chars.length, (i) {
                        final isPointer = i == _left || i == _right;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: isPointer
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
                              _chars[i],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isPointer ? Colors.black : Colors.white,
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
                    color: Colors.green[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(_hint!),
                    ),
                  ),
                const SizedBox(height: 16),
                if (!_completed)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _swapPointers,
                      child: const Text('Swap Pointers'),
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
