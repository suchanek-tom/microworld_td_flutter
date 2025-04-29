import 'package:flutter/material.dart';

class HomePage extends StatelessWidget
{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) 
  {
   return MaterialApp(
    home: Scaffold
    (
      appBar: AppBar(
        title: Text("NanoStreamTD"),
        actions: [
          ElevatedButton(onPressed:(){Navigator.pushNamed(context, '/login');} , 
          child: const Text("login")),
          Text("oppure registrati"),
        ],
        backgroundColor: Color.fromARGB(255, 195, 176, 145),
      ),
      body: Column
      (
        children: 
        [
           ElevatedButton(onPressed:() {Navigator.pushNamed(context, '/game');}, 
           child: const Text("Start the Attack")),  
           Expanded(child: Image.asset("assets/img/formica.jpg",fit: BoxFit.fitWidth))
        ],
      ),
      ),
   );  
  }
}