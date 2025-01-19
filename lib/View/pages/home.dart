// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ww/View/pages/login.dart'; 

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  // Sign out method
  Future<void> signout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()), 
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-out failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text("No user is currently logged in."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Text("Welcome, ${user!.email}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signout(context), 
        child: const Icon(Icons.logout),
      ),
    );
  }
}
