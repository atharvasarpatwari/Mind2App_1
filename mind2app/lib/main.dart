import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const Mind2App());
}

class Mind2App extends StatelessWidget {
  const Mind2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind2App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: false,
      ),
      home: const WelcomeScreen(),
    );
  }
}
