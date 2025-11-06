import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class PalindromeChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const PalindromeChallenge({super.key, required this.algorithm});

  @override
  State<PalindromeChallenge> createState() => _PalindromeChallengeState();
}

class _PalindromeChallengeState extends State<PalindromeChallenge> {
  final String _text = 'racecar';
  int _left = 0;
  late int _right;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _right = _text.length - 1;
  }

  void _checkMatch(bool match) {
    if (_completed) return;

    final isMatch = _text[_left] == _text[_right];
    
    if (match == isMatch) {
      if (isMatch) {
        setState(() {
          _left++;
          _right--;
          _hint = 'Correct! Characters match.';
        });
        
        if (_left >= _right) {
          _onSuccess();
        }
      } else {
        setState(() {
          _hint = 'Correct! Not a palindrome.';
        });
        _onSuccess();
      }
    } else {
      setState(() {
        _score = (_score - 15).clamp(0, 100);
        _hint = 'Wrong! ${_text[_left]} ${isMatch ? '==' : '!='} ${_text[_right]}';
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
                              'Check: "$_text"',
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
                        const Text('Compare characters from both ends'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_text.length, (i) {
                        final isLeft = i == _left;
                        final isRight = i == _right;
                        final isActive = isLeft || isRight;

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 50,
                          height: 70,
                          decoration: BoxDecoration(
                            color: isActive
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
                              _text[i],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.black : Colors.white,
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
                    color: _hint!.startsWith('Correct') ? Colors.green[900] : Colors.red[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            _hint!.startsWith('Correct') ? Icons.check_circle : Icons.error,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_hint!)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                if (!_completed)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _checkMatch(true),
                          child: const Text('Match'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _checkMatch(false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                          ),
                          child: const Text('No Match'),
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
