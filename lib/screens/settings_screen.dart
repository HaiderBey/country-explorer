import 'package:bolden/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Check if the current theme is Dark mode
        final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // Theme Switching Tile
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.brightness_6_outlined),
                        SizedBox(width: 16),
                        Text(
                          'Dark Mode',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: (bool value) {
                        themeProvider.toggleTheme(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Placeholder for other settings
            const Center(
              child: Text(
                'Other settings options will go here.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}