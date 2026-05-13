import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageGenerated extends StatefulWidget {
  const LoginPageGenerated({super.key});

  @override
  State<LoginPageGenerated> createState() => _LoginPageGeneratedState();
}

class _LoginPageGeneratedState extends State<LoginPageGenerated> {
  final emailC = TextEditingController();
  final mobileC = TextEditingController();
  final passwordC = TextEditingController();

  bool loggedIn = false;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString('mind2app_user');
    if (raw != null) {
      setState(() {
        user = jsonDecode(raw);
        loggedIn = true;
      });
    }
  }

  Future<void> _login() async {
    if (emailC.text.isEmpty ||
        mobileC.text.isEmpty ||
        passwordC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    final sp = await SharedPreferences.getInstance();
    final userData = {
      "email": emailC.text.trim(),
      "mobile": mobileC.text.trim(),
    };

    await sp.setString('mind2app_user', jsonEncode(userData));

    setState(() {
      loggedIn = true;
      user = userData;
    });
  }

  Future<void> _logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('mind2app_user');
    setState(() {
      loggedIn = false;
      user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: loggedIn ? _profileView() : _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: emailC,
          decoration: const InputDecoration(labelText: "Email"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: mobileC,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: "Mobile Number"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordC,
          obscureText: true,
          decoration: const InputDecoration(labelText: "Password"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: const Text("Login / Sign Up"),
        ),
      ],
    );
  }

  Widget _profileView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.account_circle, size: 80),
        const SizedBox(height: 10),
        Text("Email: ${user!['email']}"),
        Text("Mobile: ${user!['mobile']}"),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _logout,
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
