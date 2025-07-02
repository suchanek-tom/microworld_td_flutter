import 'package:flutter/material.dart' as flutter;
import 'package:microworld_td/game/app.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/login_registration/login.dart';
import 'package:microworld_td/menu/login_registration/registration.dart';
import 'package:microworld_td/menu/main_menu/home.dart';
import 'package:microworld_td/menu/select_menu/select_levels_page.dart';

class RoutesManager 
{
    static const String home = "/";
    static const String login = "/Login";
    static const String registration = "/registration";
    static const String game = "/game";
    static const String levelpage = "/levelpage";

    static flutter.Route<dynamic> generateRoute(flutter.RouteSettings settings)
    {
        switch(settings.name)
        {
    
          case home:
          {
            return flutter.MaterialPageRoute(builder: (context) => HomePage(),);
          }

          case login: 
          {
             return flutter.MaterialPageRoute(builder: (context) => LoginPage(),);
          }

          case  registration:
          {
              return flutter.MaterialPageRoute(builder: (context) => Registration(),);
          }

          case game:
          { 
            final microworldGame = MicroworldGame();

            return flutter.MaterialPageRoute(builder: (context) => GameApp(microworldGame),);
          }

          case levelpage:
          {
              return flutter.MaterialPageRoute(builder: (context) => SelectLevelPage(),);
          }

          default:
           throw FormatException("no route found");
        }
    }
}
