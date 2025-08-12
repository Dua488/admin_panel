import 'package:flutter/material.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
// Import the auto-generated file

void main() async {
  // Ensure Flutter widgets binding is initialized.
  // This is crucial if you plan to use Firebase or other platform-specific features
  // that require native code initialization before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busmate Admin Panel',
      debugShowCheckedModeBanner: false, // Set to false to remove the debug banner
      theme: ThemeData(
        // You can define your overall app theme here.
        // Using the primary color from your design for consistency.
        primaryColor: const Color(0xFFDFF8C73), // Primary Brand Color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFEB269), // Secondary Brand Color
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F4F8), // Primary Background Color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF1F4F8), // Primary Background Color for AppBar
          elevation: 0, // No shadow for AppBar
          titleTextStyle: TextStyle(
            color: Color(0xFF000000), // Primary Text Color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Define text theme if needed
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF000000)), // Primary Text Color
          bodyMedium: TextStyle(color: Color(0xFF6B7280)), // Secondary Text Color
        ),
      ),
      home: const HomeScreen(), // Set HomeScreen as the initial screen again
    );
  }
}
