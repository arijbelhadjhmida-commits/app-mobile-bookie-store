import 'package:flutter/material.dart';
import 'package:bookie_store/screens.dart/login_screen.dart';

void main() {
  runApp(const BookieStore());
}

class BookieStore extends StatelessWidget {
  const BookieStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookie Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const LoginScreen(),
    );
  }
}
