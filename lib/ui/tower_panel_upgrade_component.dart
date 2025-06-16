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
          offset: const Offset(0, 295),
          child: selectedTower == null ? const SizedBox(): buildUpgradePanel()
      ),
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
             fontSize: 12,
           ),
          ),
         TextButton(
           onPressed: () 
           {
            //call for levelup
             TowerUpgradeSystem.levelUp(selectedTower!, selectedTower!.upgradeCost);
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: Colors.green,
             foregroundColor: Colors.white,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12), // Bordi smussati
             ),
             minimumSize: const Size(54, 54), // Quadrato
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

  Widget upgradePath(upgrade_name, String requirement, String icon_path, int side) 
  {
    //quando side è 0 ci si riferisce al bottone a sinistra, quando è 1 al bottone destro
    return GestureDetector(
    onTap: () 
    {
      //call for ability upgrade
      TowerUpgradeSystem.abilityUpgrade(selectedTower!, 100,side);
    },
    child: Row(
    children: [
          Text(
            upgrade_name,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 8), // Spazio tra testo e immagine
          Image.asset(
            'assets/images/UI/$icon_path.png',
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }


 Widget buildUpgradePanel()
 {
    return Container(
          width: 760,
          height: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.brown[800],
            border: Border.all(color: Colors.brown.shade900, width: 4),
          ),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section: Tower image + targeting buttons
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                selectedTower!.sprit_icon_path,
                width: 64,
                height: 64,
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
                const SizedBox(height: 3),
                SizedBox(
                height: 23,  // altezza sufficiente per non fare overflow
                child: ToggleButtons(
                  isSelected: Target.values.map((target) => selectedTower?.typeTarget == target).toList(),
                  onPressed: (int index) {
                    setState(() {
                      selectedTower?.typeTarget = Target.values.elementAt(index);
                    });
                  },
                  color: Colors.white,
                  selectedColor: Colors.black,
                  fillColor: Colors.brown[300],
                  borderRadius: BorderRadius.circular(8),
                  constraints: const BoxConstraints(minWidth: 0, minHeight: 0), // disabilitiamo i vincoli interni
                  children: Target.values.map((target) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // padding manuale ridotto
                      child: Text(
                        target.name.toLowerCase(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              ],
            ),
            // Right section: Upgrade paths
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  levelUp("${selectedTower?.upgradeCost  ?? 0}"),
                  upgradePath("Path 2", "XP TO UNLOCK","contorno_erba",0),
                  upgradePath("Path 3", "XP TO UNLOCK","contorno_erba",1),
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
                  child: const Text( "SELL FOR \n    \$172",style: 
                    TextStyle(fontSize: 10  ) ,
                    ),
                ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      );
 }
}