import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class DFSChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const DFSChallenge({super.key, required this.algorithm});

  @override
  State<DFSChallenge> createState() => _DFSChallengeState();
}

class _DFSChallengeState extends State<DFSChallenge> {
  final Map<String, List<String>> _graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': [],
    'F': [],
  };
  final List<String> _correctOrder = ['A', 'B', 'D', 'E', 'C', 'F'];
  final List<String> _visited = [];
  int _currentIndex = 0;
  int _score = 100;
  String? _hint;
  bool _completed = false;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  void _selectNode(String node) {
    if (_completed) return;

    if (node == _correctOrder[_currentIndex]) {
      setState(() {
        _visited.add(node);
        _currentIndex++;
        _hint = 'Correct! Continue DFS traversal.';
      });

      if (_currentIndex >= _correctOrder.length) {
        _onSuccess();
      }
    } else {
      setState(() {
        _score = (_score - 15).clamp(0, 100);
        _hint = 'Wrong! DFS visits deepest unvisited node first.';
      });
    }
  }

  Widget _buildNode(String node, double width, double height, ThemeData theme) {
    final isVisited = _visited.contains(node);
    final isNext = !_completed && node == _correctOrder[_currentIndex];
    
    final positions = {
      'A': Offset(width * 0.5 - 30, height * 0.1 - 30),
      'B': Offset(width * 0.25 - 30, height * 0.35 - 30),
      'C': Offset(width * 0.75 - 30, height * 0.35 - 30),
      'D': Offset(width * 0.15 - 30, height * 0.65 - 30),
      'E': Offset(width * 0.35 - 30, height * 0.65 - 30),
      'F': Offset(width * 0.85 - 30, height * 0.65 - 30),
    };
    
    return Positioned(
      left: positions[node]!.dx,
      top: positions[node]!.dy,
      child: GestureDetector(
        onTap: !isVisited && !_completed ? () => _selectNode(node) : null,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isVisited
                ? theme.colorScheme.primary
                : isNext
                    ? theme.colorScheme.secondary
                    : theme.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              node,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isVisited || isNext ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
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
                              'DFS Traversal',
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
                        Text('Visited: ${_visited.join(' → ')}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          CustomPaint(
                            painter: _GraphPainter(_graph, _visited, theme),
                            size: Size(constraints.maxWidth, constraints.maxHeight),
                          ),
                          ..._graph.keys.map((node) => _buildNode(node, constraints.maxWidth, constraints.maxHeight, theme)),
                        ],
                      );
                    },
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

class _GraphPainter extends CustomPainter {
  final Map<String, List<String>> graph;
  final List<String> visited;
  final ThemeData theme;

  _GraphPainter(this.graph, this.visited, this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = 3;

    final positions = {
      'A': Offset(size.width * 0.5, size.height * 0.1),
      'B': Offset(size.width * 0.25, size.height * 0.35),
      'C': Offset(size.width * 0.75, size.height * 0.35),
      'D': Offset(size.width * 0.15, size.height * 0.65),
      'E': Offset(size.width * 0.35, size.height * 0.65),
      'F': Offset(size.width * 0.85, size.height * 0.65),
    };

    graph.forEach((from, toList) {
      for (var to in toList) {
        canvas.drawLine(positions[from]!, positions[to]!, paint);
      }
    });
  }

  @override
  bool shouldRepaint(_GraphPainter oldDelegate) => true;
}
