import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class DPTableChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const DPTableChallenge({super.key, required this.algorithm});

  @override
  State<DPTableChallenge> createState() => _DPTableChallengeState();
}

class _DPTableChallengeState extends State<DPTableChallenge> {
  final int _rows = 4;
  final int _cols = 5;
  late List<List<int?>> _table;
  final List<List<int>> _solution = [
    [0, 1, 1, 1, 1],
    [1, 1, 2, 2, 2],
    [1, 2, 2, 3, 3],
    [1, 2, 3, 3, 4],
  ];
  int _score = 100;
  String? _hint;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  final _controllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    _table = List.generate(_rows, (i) => List.generate(_cols, (j) {
      if (i == 0 || j == 0) return i == 0 && j == 0 ? 0 : (i == 0 ? j : i);
      return null;
    }));
    
    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _cols; j++) {
        _controllers.add(TextEditingController());
      }
    }
  }

  void _checkCell(int row, int col, String value) {
    if (_table[row][col] != null) return;

    final intValue = int.tryParse(value);
    if (intValue == null) return;

    if (intValue == _solution[row][col]) {
      setState(() {
        _table[row][col] = intValue;
        _hint = 'Correct! ✓';
      });

      if (_isComplete()) {
        _onSuccess();
      }
    } else {
      setState(() {
        _score = (_score - 10).clamp(0, 100);
        _hint = 'Wrong! Use: dp[i][j] = max(dp[i-1][j], dp[i][j-1]) + 1';
      });
    }
  }

  bool _isComplete() {
    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _cols; j++) {
        if (_table[i][j] == null) return false;
      }
    }
    return true;
  }

  void _onSuccess() {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fill DP Table',
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
                          'Recurrence: dp[i][j] = max(dp[i-1][j], dp[i][j-1]) + 1',
                          style: TextStyle(fontSize: 12),
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
                      child: Table(
                        border: TableBorder.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                        defaultColumnWidth: const FixedColumnWidth(70),
                        children: List.generate(_rows, (i) {
                          return TableRow(
                            children: List.generate(_cols, (j) {
                              final value = _table[i][j];
                              final isEditable = value == null;
                              final controller = _controllers[i * _cols + j];

                              return Container(
                                height: 70,
                                color: value != null
                                    ? theme.colorScheme.primary.withOpacity(0.2)
                                    : theme.colorScheme.surface,
                                child: Center(
                                  child: isEditable
                                      ? Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: TextField(
                                            controller: controller,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '?',
                                            ),
                                            onSubmitted: (v) => _checkCell(i, j, v),
                                          ),
                                        )
                                      : Text(
                                          '$value',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                if (_hint != null)
                  Card(
                    color: _hint!.startsWith('Wrong')
                        ? Colors.red[900]
                        : _hint!.startsWith('Correct')
                            ? Colors.green[900]
                            : Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            _hint!.startsWith('Wrong')
                                ? Icons.error
                                : _hint!.startsWith('Correct')
                                    ? Icons.check_circle
                                    : Icons.lightbulb,
                            color: Colors.white,
                          ),
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
                          'Instructions:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Fill cells from top-left to bottom-right\n'
                          '• Each cell = max of top or left cell + 1\n'
                          '• Tap cell, enter number, press Enter',
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
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
