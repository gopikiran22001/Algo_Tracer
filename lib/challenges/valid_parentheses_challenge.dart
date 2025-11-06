import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class ValidParenthesesChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const ValidParenthesesChallenge({super.key, required this.algorithm});

  @override
  State<ValidParenthesesChallenge> createState() => _ValidParenthesesChallengeState();
}

class _ValidParenthesesChallengeState extends State<ValidParenthesesChallenge> {
  final String _input = '({[]})';
  final List<String> _stack = [];
  int _currentIndex = 0;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  void _push() {
    if (_completed || _currentIndex >= _input.length) return;

    final char = _input[_currentIndex];
    if (char == '(' || char == '{' || char == '[') {
      setState(() {
        _stack.add(char);
        _currentIndex++;
        _hint = 'Pushed $char to stack';
      });
    } else {
      setState(() {
        _score = (_score - 10).clamp(0, 100);
        _hint = 'Wrong! $char is a closing bracket';
      });
    }

    if (_currentIndex >= _input.length && _stack.isEmpty) {
      _onSuccess();
    }
  }

  void _pop() {
    if (_completed || _currentIndex >= _input.length || _stack.isEmpty) return;

    final char = _input[_currentIndex];
    final top = _stack.last;
    final matches = (char == ')' && top == '(') ||
                    (char == '}' && top == '{') ||
                    (char == ']' && top == '[');

    if (matches) {
      setState(() {
        _stack.removeLast();
        _currentIndex++;
        _hint = 'Matched $top with $char';
      });

      if (_currentIndex >= _input.length && _stack.isEmpty) {
        _onSuccess();
      }
    } else {
      setState(() {
        _score = (_score - 10).clamp(0, 100);
        _hint = 'Wrong! $char does not match $top';
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
                              'Valid Parentheses',
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
                        Text('Input: $_input'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_input.length, (i) {
                    final isCurrent = i == _currentIndex;
                    final isPassed = i < _currentIndex;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? theme.colorScheme.primary
                            : isPassed
                                ? theme.colorScheme.secondary.withOpacity(0.3)
                                : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _input[i],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isCurrent ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                Text(
                  'Stack',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.primary, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _stack.reversed.map((char) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            char,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                if (_hint != null)
                  Card(
                    color: _hint!.contains('Wrong') ? Colors.red[900] : Colors.green[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(_hint!),
                    ),
                  ),
                const SizedBox(height: 16),
                if (!_completed && _currentIndex < _input.length)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _push,
                          child: const Text('Push'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _pop,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                          ),
                          child: const Text('Pop & Match'),
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
