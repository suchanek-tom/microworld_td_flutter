import 'package:flutter/material.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select level"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 195, 176, 145),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildLevelBox(context, level: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelBox(BuildContext context, {required int level}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/game');
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            '$level',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
