import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GeoPastureApp());
}

class GeoPastureApp extends StatelessWidget {
  const GeoPastureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoPasture',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'GeoPasture',
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
