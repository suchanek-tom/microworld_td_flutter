import 'package:flutter/material.dart';

class HomePage extends StatelessWidget
{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) 
  {
   return MaterialApp(
    home: Scaffold(
      //debugShowCheckedModeBanner: false,
      appBar: AppBar(
        title: Text("NanoStreamTD"),
        backgroundColor: Color.fromARGB(255, 195, 176, 145),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed:(){
          Navigator.pushNamed(context, '/login'); 
        },
         child: const Text("login")),
      ),
    ),
   );
  }
}