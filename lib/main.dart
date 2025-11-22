import 'package:bolden/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Bolden());
}

class Bolden extends StatelessWidget {
  const Bolden({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolden',
      //ThemeData for Dark/Light Themes
      theme: ThemeData( 
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(

      ),
      home: const HomeScreen(),
    );
  }
}