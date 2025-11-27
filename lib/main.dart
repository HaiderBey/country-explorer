import 'package:bolden/providers/country_provider.dart';
import 'package:bolden/screens/main_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CountryProvider()),
      ],
      child: const Bolden(),
    ),
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const MainNavigator(),
    );
  }
}