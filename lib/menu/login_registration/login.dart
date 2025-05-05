import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microworld_td/menu/main_menu/home.dart';
import 'package:microworld_td/menu/login_registration/registration.dart';

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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
    backgroundColor: Colors.grey[200],
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Microworld_TD',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Log In',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (errorMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Log in...',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: implement Forgot Password
                  },
                  child: const Text(
                    'Forgot password',
                     style: TextStyle(color: Colors.black)
                     ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Registration()),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.lightBlue)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}
