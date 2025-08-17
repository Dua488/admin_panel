import 'package:flutter/material.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase differently for web & mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDWDFN7UaQK1oHBTdV-p0evwxYahLhqEn0',
        appId: '1:64129881421:web:6771b68198644b27cd9304',
        messagingSenderId: '64129881421',
        projectId: 'busmate-54bb3',
        authDomain: 'busmate-54bb3.firebaseapp.com',
        databaseURL: 'https://busmate-54bb3-default-rtdb.firebaseio.com',
        storageBucket: 'busmate-54bb3.firebasestorage.app',
        measurementId: 'G-KGVQMB2K4D',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busmate Admin Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFDFF8C73),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFEB269),
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F4F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF1F4F8),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF000000),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF000000)),
          bodyMedium: TextStyle(color: Color(0xFF6B7280)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
