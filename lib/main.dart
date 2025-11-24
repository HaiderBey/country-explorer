import 'package:bolden/providers/country_provider.dart';
import 'package:bolden/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: const Bolden(),
    )
  );
}

class Bolden extends StatelessWidget {
  const Bolden({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolden',
      debugShowCheckedModeBanner: false,
      //ThemeData for Dark/Light Themes
      theme: ThemeData( 
      ),
      darkTheme: ThemeData.dark().copyWith(

      ),
      home: const HomeScreen(),
    );
  }
}