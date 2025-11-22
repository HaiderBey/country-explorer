import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bolden',
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
      ),
      body: const Center (
        child: Text(
          'The world in a grid!',
          textAlign: TextAlign.center
        ),
      ),
      // Bottom Navigation to be added later
    );
  }
}