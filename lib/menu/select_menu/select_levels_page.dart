import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microworld_td/menu/main_menu/home.dart';
import 'package:microworld_td/menu/select_menu/level_progress.dart';
import 'package:microworld_td/systems/level_manager.dart';
import 'package:microworld_td/systems/routes.dart';

class SelectLevelPage extends StatefulWidget {
  const SelectLevelPage({super.key});

  @override
  State<SelectLevelPage> createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
  int unlockedLevels = 1;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final level = await LevelProgress.getUnlockedLevel();
    setState(() {
      unlockedLevels = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Back button + Login UI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   TextButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
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
                  const _LoginUI(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(3, (index) {
                      final level = index + 1;

                      final (String difficulty, Color color) = switch (level) {
                        1 => ('Easy', Colors.green),
                        2 => ('Medium', Colors.orangeAccent),
                        3 => ('Hard', Colors.red),
                        _ => ('', Colors.black),
                      };

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            difficulty,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                          const SizedBox(height: 6),
                          HoverLevelBox(
                            level: level,
                            enabled: level <= unlockedLevels,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            if (FirebaseAuth.instance.currentUser != null)
              Center(
                child: TextButton(
                  onPressed: () async {
                    await LevelProgress.reset();
                    await _loadProgress();
                  },
                  child: const Text(
                    'Reset Progress',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _LoginUI extends StatelessWidget {
  const _LoginUI();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final displayName = user.displayName ?? user.email ?? "User";

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              displayName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed(RoutesManager.home);
              },
              child: const Icon(Icons.logout, size: 18),
            ),
          ],
        ),
      );
    } else {
      return TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.login);
        },
        icon: const Icon(Icons.login, color: Colors.black),
        label: const Text(
          "Guest",
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}

class HoverLevelBox extends StatefulWidget {
  final int level;
  final bool enabled;

  const HoverLevelBox({
    super.key,
    required this.level,
    this.enabled = true,
  });

  @override
  State<HoverLevelBox> createState() => _HoverLevelBoxState();
}

class _HoverLevelBoxState extends State<HoverLevelBox> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = widget.enabled ? Colors.orange : Colors.grey;
    final Color hoverColor = widget.enabled ? Colors.orangeAccent : Colors.grey;

    return MouseRegion(
      cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.enabled) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (widget.enabled) setState(() => _hovering = false);
      },
      child: GestureDetector(
        onTap: () {
          if (widget.enabled) {
            LevelManager.current_level = widget.level;
            Navigator.of(context).pushNamed(RoutesManager.game);
          }
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
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: widget.enabled ? Colors.white : Colors.black38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
