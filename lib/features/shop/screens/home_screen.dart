import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final authService = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              //Note: Get.offAll is for widgets only NO METHODS.
              //This way whenever you logout, the user will be kept logged out until he log in again.
              await AuthenticationRepository.instance.logout();
              //But this way whenever you logout, if the user restart the app he's logged in again automatically.
              // Get.offAll(() => const LoginScreen());
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
        title: Text("Welcome Back"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 20,
        ),
      ),
      body: Center(
        child: Text(
          "Welcome Back, ${user?.email ?? user?.displayName ?? "User"}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
