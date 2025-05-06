import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microworld_td/routes.dart';

class LoginPage extends StatefulWidget
{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  final FirebaseAuth _auth = FirebaseAuth.instance; //Firebase authentication handler
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        Navigator.of(context).pushNamed(RoutesManager.home);
      } else {
        setState(() {
          errorMessage = "Login failed. Please try again.";
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        setState(() {
          errorMessage = "The email address is not valid.";
        });
      } else if (e.code == 'user-disabled') {
        setState(() {
          errorMessage = "The user has been disabled.";
        });
      } else if (e.code == 'user-not-found') {
        setState(() {
          errorMessage = "No user found with this email.";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorMessage = "Incorrect password.";
        });
      } else if (e.code == 'invalid-credential') {
        setState(() {
          errorMessage = "The supplied auth credential is incorrect, malformed or has expired.";
        });
      } else {
        setState(() {
          errorMessage = "Login failed. Please try again.";
        });
      }
    } catch (e) {
      print("Login error: $e");
      setState(() {
        errorMessage = "Login failed. Check email and password.";
      });
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
              onPressed: _login,
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RoutesManager.registration);
              },
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
