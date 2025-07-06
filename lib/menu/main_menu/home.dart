import 'package:flutter/material.dart';
import 'package:microworld_td/systems/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFEFEFEF), 
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Micro World TD',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 40),
                _buildMenuButton(
                  context,
                  label: 'Start game',
                  color: Colors.orange,
                  onPressed: () => Navigator.of(context).pushNamed(RoutesManager.levelpage),
                ),
                const SizedBox(height: 20),
                _buildMenuButton(
                  context,
                  label: 'Login',
                  color: Colors.blue,
                  onPressed: () => Navigator.of(context).pushNamed(RoutesManager.login),
                ),
                const SizedBox(height: 20),
                _buildMenuButton(
                  context,
                  label: 'Quit game',
                  color: Colors.red,
                  //? add exit(0)
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuButton(BuildContext context,
      {required String label,
      required Color color,
      required VoidCallback onPressed}) {
    return SizedBox(
  width: 300, // imposta la larghezza desiderata
  height: 80, // imposta l'altezza desiderata
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: EdgeInsets.zero, // annulla il padding interno
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
  ),
);
  }
}
