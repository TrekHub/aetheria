import 'package:aetheria/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aetheria',
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.skyBlue,
          title: Text("Aetheria", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
