import 'package:flutter_test/flutter_test.dart';
import 'package:microworld_td/game/components/bullet/types/standard_bullet.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:mocktail/mocktail.dart';

class MockParent extends PositionComponent {
  final List<Component> added = [];

  @override
  Future<void> add(Component component) async {
    added.add(component);
    await super.add(component); // imposta il parent correttamente
  }
}
class MockEnemyHealth extends Mock implements BaseEnemy {}

class MockEnemy extends Mock implements BaseEnemy {
  @override
  bool isRemoved = false;
  
  @override
  int health = 100;

  @override
  void takeDamage(int damage, BaseTower tower) {
    taking_hit_from = tower;
    health -= damage;
  }
}

class TestTower extends BaseTower {

  bool isremoved = false;

  TestTower()
      : super(
          towerName: 'Test',
          fireRate: 1,
          range: 100,
          damage: 10,
          sprite_path: '',
          sprite_size: Vector2.all(64),
          cost: 100,
          sellCost: 50,
          sprite_icon_path: '',
          antKilled: 0,
          upgradeCost: [],
          towerLevel: 1,
          cost_abl_dx: 0,
          cost_abl_sx: 0,
          nome_abl_dx: '',
          nome_abl_sx: '',
          sprite_abl_dx_path: '',
          sprite_abl_sx_path: '',
        );

  @override
  void attackTarget(BaseEnemy target) {
     parent?.add(StandardBullet(tower: this, target: target, damage: damage));
     target.takeDamage(damage, this);
  }

  @override
  void removeFromParent({bool recursive = false}) {
     isremoved = true;
  }

  @override
  void implementUpgrade(int side, BaseTower tower) {
    // Mock implementation
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('type target strong ', () async 
  {
    //Act
    final tower = TestTower();
    tower.typeTarget = Target.strong;
    //il return è la vita
    final enemy1 = MockEnemyHealth();
    when(() => enemy1.health).thenReturn(10);
  
    final enemy2 = MockEnemyHealth();
    when(() => enemy2.health).thenReturn(50); 

    final enemy3 = MockEnemyHealth();
    when(() => enemy3.health).thenReturn(30);

    //assert
    final result = tower.selectTarget([enemy1, enemy2, enemy3]);
    //Arange

    expect(enemy2.health,result.health);
  });

  test('sellTower aumenta i coins e rimuove la torre', () async {
    // Arrange
    GameState.coins = 100;
    final tower = TestTower();
    
    // Act
    BaseTower.sellTower(tower);
    await Future.microtask(() {}); 
   
    // Assert
    expect(GameState.coins, 150); // +50
    expect(tower.isremoved, true); // removeFromParent è stato chiamato
  });

  test('should add a StandardBullet to parent with correct target and damage', () async {
      final testTower = TestTower();
      final mockParent = MockParent();
      final mockEnemy = MockEnemy(); 

      mockEnemy.position = Vector2(50, 100); //pos generica
      testTower.position = Vector2.all(0);
      int savehp = mockEnemy.health;  
     
      // Assegna il parent finto alla torre
      mockParent.add(testTower);
       
      testTower.attackTarget(mockEnemy);

      expect(mockParent.added.any((c) => c is StandardBullet), true);

      final bullet = mockParent.added.whereType<StandardBullet>().first;
      expect(bullet.target, equals(mockEnemy));
      expect(mockEnemy.health + testTower.damage,savehp);
    });
}
