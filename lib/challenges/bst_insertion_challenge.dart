import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/algorithm_model.dart';
import '../providers/user_provider.dart';
import '../widgets/success_overlay.dart';

class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;
  Offset? position;

  TreeNode(this.value);
}

class BSTInsertionChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;

  const BSTInsertionChallenge({super.key, required this.algorithm});

  @override
  State<BSTInsertionChallenge> createState() => _BSTInsertionChallengeState();
}

class _BSTInsertionChallengeState extends State<BSTInsertionChallenge> {
  TreeNode? _root;
  final List<int> _toInsert = [50, 30, 70, 20, 40];
  int _currentIndex = 0;
  TreeNode? _currentNode;
  int _score = 100;
  String? _hint;
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _insertNext();
  }

  void _insertNext() {
    if (_currentIndex >= _toInsert.length) return;
    
    final value = _toInsert[_currentIndex];
    if (_root == null) {
      setState(() {
        _root = TreeNode(value);
        _currentIndex++;
        _hint = null;
      });
      if (_currentIndex < _toInsert.length) {
        Future.delayed(const Duration(milliseconds: 500), _insertNext);
      } else {
        _onSuccess();
      }
    } else {
      setState(() {
        _currentNode = _root;
        _hint = 'Where should $value go? Compare with ${_currentNode!.value}';
      });
    }
  }

  void _makeChoice(bool goLeft) {
    if (_currentNode == null) return;

    final value = _toInsert[_currentIndex];
    final shouldGoLeft = value < _currentNode!.value;

    if (goLeft == shouldGoLeft) {
      if (goLeft) {
        if (_currentNode!.left == null) {
          setState(() {
            _currentNode!.left = TreeNode(value);
            _currentIndex++;
            _currentNode = null;
            _hint = null;
          });
          if (_currentIndex < _toInsert.length) {
            Future.delayed(const Duration(milliseconds: 500), _insertNext);
          } else {
            _onSuccess();
          }
        } else {
          setState(() {
            _currentNode = _currentNode!.left;
            _hint = 'Continue: Where should $value go? Compare with ${_currentNode!.value}';
          });
        }
      } else {
        if (_currentNode!.right == null) {
          setState(() {
            _currentNode!.right = TreeNode(value);
            _currentIndex++;
            _currentNode = null;
            _hint = null;
          });
          if (_currentIndex < _toInsert.length) {
            Future.delayed(const Duration(milliseconds: 500), _insertNext);
          } else {
            _onSuccess();
          }
        } else {
          setState(() {
            _currentNode = _currentNode!.right;
            _hint = 'Continue: Where should $value go? Compare with ${_currentNode!.value}';
          });
        }
      }
    } else {
      setState(() {
        _score = (_score - 15).clamp(0, 100);
        _hint = 'Wrong! $value is ${value < _currentNode!.value ? 'less' : 'greater'} than ${_currentNode!.value}';
      });
    }
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
    final isInserting = _currentNode != null;

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
                              'Insert: ${_currentIndex < _toInsert.length ? _toInsert[_currentIndex] : 'Done!'}',
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
                        Text(
                          'Progress: $_currentIndex / ${_toInsert.length}',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _root == null
                      ? const Center(child: CircularProgressIndicator())
                      : CustomPaint(
                          painter: _TreePainter(_root!, _currentNode, theme),
                          child: Container(),
                        ),
                ),
                if (_hint != null)
                  Card(
                    color: _hint!.startsWith('Wrong') ? Colors.red[900] : Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            _hint!.startsWith('Wrong') ? Icons.error : Icons.lightbulb,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_hint!)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                if (isInserting)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _makeChoice(true),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Go Left'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _makeChoice(false),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Go Right'),
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

class _TreePainter extends CustomPainter {
  final TreeNode root;
  final TreeNode? currentNode;
  final ThemeData theme;

  _TreePainter(this.root, this.currentNode, this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    _calculatePositions(root, size.width / 2, 40, size.width / 4);
    _drawTree(canvas, root);
  }

  void _calculatePositions(TreeNode? node, double x, double y, double offset) {
    if (node == null) return;
    node.position = Offset(x, y);
    if (node.left != null) {
      _calculatePositions(node.left, x - offset, y + 80, offset / 2);
    }
    if (node.right != null) {
      _calculatePositions(node.right, x + offset, y + 80, offset / 2);
    }
  }

  void _drawTree(Canvas canvas, TreeNode? node) {
    if (node == null || node.position == null) return;

    if (node.left != null && node.left!.position != null) {
      canvas.drawLine(
        node.position!,
        node.left!.position!,
        Paint()
          ..color = Colors.grey[700]!
          ..strokeWidth = 2,
      );
      _drawTree(canvas, node.left);
    }

    if (node.right != null && node.right!.position != null) {
      canvas.drawLine(
        node.position!,
        node.right!.position!,
        Paint()
          ..color = Colors.grey[700]!
          ..strokeWidth = 2,
      );
      _drawTree(canvas, node.right);
    }

    final isCurrentNode = node == currentNode;
    canvas.drawCircle(
      node.position!,
      25,
      Paint()
        ..color = isCurrentNode
            ? theme.colorScheme.secondary
            : theme.colorScheme.primary,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${node.value}',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      node.position! - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(_TreePainter oldDelegate) => true;
}
