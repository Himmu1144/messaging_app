import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mimiko/pages/chat_page.dart';
import 'package:mimiko/services/auth/auth_gate.dart';
import 'package:mimiko/services/auth/login_or_register.dart';
import 'package:mimiko/firebase_options.dart';
import 'package:mimiko/pages/settings_page.dart';
import 'package:mimiko/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
      routes: {
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
