import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const AnsarTaxiApp());
}

class AnsarTaxiApp extends StatelessWidget {
  const AnsarTaxiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}	

