import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    register() async {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
              controller: emailC,
              decoration: const InputDecoration(hintText: "Email")),
          TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password")),
          ElevatedButton(onPressed: register, child: const Text("Sign Up"))
        ]),
      ),
    );
  }
}
