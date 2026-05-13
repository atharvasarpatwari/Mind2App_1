import 'package:flutter/material.dart';
import '../models/user_selection.dart';
import 'questionnaire_screen.dart';

class AppNameScreen extends StatefulWidget {
  const AppNameScreen({super.key});

  @override
  State<AppNameScreen> createState() => _AppNameScreenState();
}

class _AppNameScreenState extends State<AppNameScreen> {
  final appNameC = TextEditingController(text: "Mind2App Store");
  final descC = TextEditingController(text: "A demo store created by Mind2App");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Info")),
      body: Center(
        child: SizedBox(
          width: 900,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 8),
              const Text("App name", style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(controller: appNameC),
              const SizedBox(height: 12),
              const Text("Short description", style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(controller: descC, maxLines: 3),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    final sel = UserSelection();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => QuestionnaireScreen(selection: sel, appName: appNameC.text, description: descC.text)));
                  },
                  child: const Padding(padding: EdgeInsets.all(10), child: Text("Next")),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
