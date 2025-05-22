import 'package:flutter/material.dart' as flutter;
import 'package:flutter/widgets.dart';

class TowerPanelComponent extends StatelessWidget {
  const TowerPanelComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(1280, 0),
      child: Container(
        width: 120,
        decoration: const BoxDecoration(
          image: flutter.DecorationImage(
            image: flutter.AssetImage('assets/images/sprites/wood_background.jpg'),
            fit: flutter.BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const flutter.Text(
              'DIFFICULTY',
              style: flutter.TextStyle(
                color: flutter.Colors.white,
                fontWeight: flutter.FontWeight.bold,
              ),
            ),
            flutter.Row(
              mainAxisAlignment: flutter.MainAxisAlignment.center,
              children: const [
                flutter.Icon(flutter.Icons.health_and_safety, color: flutter.Colors.white),
                flutter.SizedBox(width: 10),
                flutter.Icon(flutter.Icons.attach_money, color: flutter.Colors.white),
              ],
            ),
            const flutter.SizedBox(height: 20),

            // GridView with ElevatedButtons
            flutter.GridView.builder(
              shrinkWrap: true,
              padding: const flutter.EdgeInsets.all(10),
              itemCount: 6,
              gridDelegate: const flutter.SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return flutter.ElevatedButton(
                  style: flutter.ElevatedButton.styleFrom(
                    backgroundColor: flutter.Colors.green.withOpacity(0.3),
                    padding: flutter.EdgeInsets.zero,
                    shape: flutter.RoundedRectangleBorder(
                      borderRadius: flutter.BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    print('Torre #$index selezionata!');
                    // Qui puoi collegare la tua logica di selezione torre
                  },
                  child: const flutter.Icon(
                    flutter.Icons.bug_report,
                    color: flutter.Colors.black,
                  ),
                );
              },
            ),

            const flutter.SizedBox(height: 10),
            const flutter.Text(
              'BATTLE: 9\nWAVES: 25',
              textAlign: flutter.TextAlign.center,
              style: flutter.TextStyle(color: flutter.Colors.white),
            ),
            const flutter.Spacer(),
            const flutter.Icon(flutter.Icons.fast_forward, color: flutter.Colors.red, size: 40),
            const flutter.Icon(flutter.Icons.stop, color: flutter.Colors.red, size: 40),
            const flutter.SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
