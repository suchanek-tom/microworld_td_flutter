import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/login_registration/login.dart';
import 'package:microworld_td/menu/login_registration/registration.dart';
import 'package:microworld_td/menu/main_menu/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:microworld_td/menu/select_menu/select_levels_page.dart';
void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBNn2RTa2tJCYB2Ma8KQE80onOF7eyRdTI', 
      appId: '1:601812983:android:e9e8e8d4c9f53730f4c8f2', 
      messagingSenderId: '601812983', 
      projectId:'nanostreamtd-d2c1a')
  ); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    MicroworldGame microworld = MicroworldGame(); 
    
    return MaterialApp(
      initialRoute: '/home',
      routes: {
      '/home': (context) => HomePage(),
      '/select_level': (context) => const SelectLevelPage(),
      '/login': (context) => LoginPage(),
      '/registration': (context) => Registration(),
      '/game':(context)=> GameWidget(game: kDebugMode ? MicroworldGame() : microworld),
    },
    );
  }
}
