import 'package:flutter/material.dart';
import 'appname_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FF),
      body: Center(
        child: SizedBox(
          width: 900,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text("Welcome to Mind2App", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Where your imagination turns into an app", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppNameScreen())),
              child: const Padding(padding: EdgeInsets.all(12), child: Text("Start building", style: TextStyle(fontSize: 16))),
            )
          ]),
        ),
      ),
    );
  }
}
