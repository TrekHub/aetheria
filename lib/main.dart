import 'package:aetheria/firebase_options.dart';
import 'package:aetheria/providers/daily_verse_provider.dart';
import 'package:aetheria/providers/sermon_provider.dart';
import 'package:aetheria/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SermonProvider()),
        ChangeNotifierProvider(create: (context) => DailyVerseProvider()),
      ],
      child: MaterialApp(
        title: 'Aetheria',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
