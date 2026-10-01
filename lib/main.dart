import 'package:flutter/material.dart';
import 'colors.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Uniqlo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: kred,
          foregroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: false,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: kred,
          secondary: kwhite,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
