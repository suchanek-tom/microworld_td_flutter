import 'package:flutter/material.dart';

class TowerMenu extends StatelessWidget {
  final void Function(String) onSelect;
  final VoidCallback onToggleRemove;

  const TowerMenu({required this.onSelect, required this.onToggleRemove, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          towerButton('VenomSprayer', onSelect),
          towerButton('StickyWeb', onSelect),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onToggleRemove,
            child: const Text('Remove Mode'),
          ),
        ],
      ),
    );
  }

  Widget towerButton(String type, void Function(String) onSelect) {
    return ElevatedButton(
      onPressed: () => onSelect(type),
      child: Text(type),
    );
  }
}
