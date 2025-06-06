import 'package:flutter/material.dart';
import 'package:microworld_td/game/gameplay.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/systems/tower_upgrade.dart';

class TowerPanelUpgradeComponent extends StatefulWidget 
{
  final GamePlay game;
  
  const TowerPanelUpgradeComponent({super.key, required this.game});

  @override
  State<TowerPanelUpgradeComponent> createState() => TowerPanelUpgradeComponentState();
}

class TowerPanelUpgradeComponentState extends State<TowerPanelUpgradeComponent> 
{
  bool isvisible = false;
  BaseTower? selectedTower;

  void showForTower(BaseTower tower) 
  {   
    setState((){
      isvisible = true;
      selectedTower = tower;
    });
  }

  void hide() 
  {
    setState(() {
      isvisible = false;
      selectedTower = null;
    });
  }
  @override
  Widget build(BuildContext context) 
  {
    
    return Visibility
    (
      visible: isvisible,
      child: Transform.translate
      (
          offset: const Offset(0, 750),
          child: Container
          (
          width: 1280,
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.brown[800],
            border: Border.all(color: Colors.brown.shade900, width: 4),
          ),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section: Tower image + targeting buttons
            if (isvisible)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                selectedTower!.sprit_icon_path,
                width: 96,
                height: 96,
                fit: BoxFit.fill,
              ),
            ),
            // CENTRO: Tutto il resto
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedTower?.towerName ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Ant Count: ${selectedTower?.antKilled ?? 0}"),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 3,
                  children: [
                    targetButton("FIRST"),
                    targetButton("CLOSE"),
                    targetButton("STRONG"),
                  ],
                ),
              ],
            ),
            // Right section: Upgrade paths
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  levelUp("100"),
                  upgradePath("Path 2", "XP TO UNLOCK","contorno_erba"),
                  upgradePath("Path 3", "XP TO UNLOCK","contorno_erba"),
                ],
              ),
            ),
             // Middle section: Sell button
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () {},
                  child: const Text("SELL FOR \n    \$172"),
                ),
              ],
            ),
            const SizedBox(width: 16),
          ],
        ),
        ),
      ),
    );
  }

  Widget targetButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown[600],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }

  Widget levelUp(String requirement) 
  {
   return Padding(
     padding: const EdgeInsets.only(left: 16),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Text(
           "Level up $requirement",
            style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 16,
           ),
          ),
         TextButton(
           onPressed: () 
           {
             
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: Colors.green,
             foregroundColor: Colors.white,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12), // Bordi smussati
             ),
             minimumSize: const Size(64, 64), // Quadrato
             padding: EdgeInsets.zero, // Per evitare padding interno
           ),
           child: Container(
           padding: const EdgeInsets.all(4),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: const [
               Icon(Icons.add),
               SizedBox(height: 4),
               Text(
                 'UP',
                 style: TextStyle(fontSize: 12),
               ),
             ],
           ),
           ),
         ),
       ],
     ),
   );
  }

  Widget upgradePath(upgrade_name, String requirement, String icon_path) 
  {
    return GestureDetector(
    onTap: () 
    {
      print("lezzo");
      //TowerUpgradeSystem.abilityUpgrade(selectedTower!, 100);
    },
    child: Row(
    children: [
          Text(
            upgrade_name,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8), // Spazio tra testo e immagine
          Image.asset(
            'assets/images/UI/$icon_path.png',
            width: 96,
            height: 96,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

}