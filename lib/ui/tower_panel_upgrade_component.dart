import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
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
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Visibility(
      visible: isvisible,
      child: Transform.translate(
        offset: Offset(0, screenSize.height * 0.76),
        child: selectedTower == null ? const SizedBox() : buildUpgradePanel(),
      ),
    );
  }  

  Widget buildUpgradePanel()
 {
      return Container(
      width:  widget.game.game.size.x * 0.89, 
      height: widget.game.game.size.y * 0.24, 
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.brown[800],
        border: Border.all(color: Colors.brown.shade900, width: 4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              "assets/${selectedTower!.sprite_icon_path}",
              width: 64,  
              height: 64,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${selectedTower?.towerName ?? ''} (Lv. ${selectedTower?.towerLevel ?? '?'})",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Ant Count: ${selectedTower?.antKilled ?? 0}"),
              const SizedBox(height: 3),
              SizedBox(
                height: 23,
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
                  constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  children: Target.values.map((target) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(target.name.toLowerCase(), style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                levelUp("${selectedTower?.upgradeCost[selectedTower!.towerLevel - 1] ?? 0}"),
                upgradePath(selectedTower!.nome_abl_sx, selectedTower!.cost_abl_sx, selectedTower!.sprite_abl_sx_path, 0),
                upgradePath(selectedTower!.nome_abl_dx, selectedTower!.cost_abl_dx, selectedTower!.sprite_abl_dx_path, 1),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(width: 90, height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onPressed: () 
                {
                  BaseTower.sellTower(selectedTower!);
                  setState(() {
                    isvisible = false;
                  });
                },
                child: Text(
                  "SELL FOR \n    \$ ${selectedTower!.sellCost}",
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ],
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
        Text.rich(
         TextSpan(
          text: 'Level up ',
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black, 
          ),
          children: [
            TextSpan(
              text: "\$$requirement",
              style: const TextStyle(
              color: Colors.green, 
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          TextButton(
           onPressed: () 
           {
            setState(() 
            {
            int cost =  selectedTower!.upgradeCost[selectedTower!.towerLevel-1];
            if(selectedTower!.towerLevel != 5){
              if(GameState.coins >= cost){
                GameState.coins -= cost;
                TowerUpgradeSystem.levelUp(selectedTower!);
              }else{
                print("you have:${GameState.coins} but you need: $cost");
              }
            }
            else{
              print("max level reached");
            }});
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: Colors.green,
             foregroundColor: Colors.white,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12), 
             ),
             minimumSize: const Size(50, 50), 
             padding: EdgeInsets.zero, 
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

  Widget upgradePath(String upgrade_name, int requirement, String icon_path, int side) 
  {
    return GestureDetector(
    onTap: (){
      if(GameState.coins > requirement)
      { 
        TowerUpgradeSystem.abilityUpgrade(selectedTower!,side,requirement);  
      }
      else{
         print("you have:${GameState.coins} but you need: $requirement");
      }      
    },
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          upgrade_name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 6), 
        Text(
          "\$${requirement.toString()}",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    ),

    const SizedBox(width: 4), 

    Image.asset(
      'assets/$icon_path',
      width: 64,
      height: 64,
      fit: BoxFit.cover,
         ),
        ],
      ),
    );
  }
}


