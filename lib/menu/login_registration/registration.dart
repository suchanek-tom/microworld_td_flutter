import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microworld_td/menu/login_registration/login.dart';

class Registration extends StatefulWidget
{
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Registration> 
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";

  Future<void> _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          errorMessage = "The email address is already in use.";
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          errorMessage = "The email address is not valid.";
        });
      } else if (e.code == 'operation-not-allowed') {
        setState(() {
          errorMessage = "Email/password accounts are not enabled.";
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          errorMessage = "The password is too weak.";
        });
      } else {
        setState(() {
          errorMessage = "Registration failed. Try again.";
        });
      }
    } catch (e) {
      print("Registration error: $e");
      setState(() {
        errorMessage = "Registration failed. Try again.";
      });
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 10),
            Text(errorMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
