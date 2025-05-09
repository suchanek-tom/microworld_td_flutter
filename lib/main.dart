import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:microworld_td/systems/routes.dart';
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
    return MaterialApp(
      initialRoute: RoutesManager.home,
      onGenerateRoute: RoutesManager.generateRoute,
    );
  }
}
