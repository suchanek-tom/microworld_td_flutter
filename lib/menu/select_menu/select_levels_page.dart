import 'package:flutter/material.dart';
import 'package:microworld_td/routes.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12.0),
          child: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
            label: const Text(
              'back',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              ),
          ),
        ),

            const SizedBox(height: 20),

            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      HoverLevelBox(level: 1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverLevelBox extends StatefulWidget {
  final int level;

  const HoverLevelBox({super.key, required this.level});

  @override
  State<HoverLevelBox> createState() => _HoverLevelBoxState();
}

class _HoverLevelBoxState extends State<HoverLevelBox> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Colors.orange;
    final Color hoverColor = Colors.orangeAccent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(RoutesManager.game);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _hovering ? hoverColor : baseColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${widget.level}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
