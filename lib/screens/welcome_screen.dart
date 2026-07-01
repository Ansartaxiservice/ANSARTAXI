import 'login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🚖",
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 20),
              const Text(
                "ANSAR TAXI",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your Ride, Our Priority",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );
},
                child: const Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
