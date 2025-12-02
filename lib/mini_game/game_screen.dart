import 'package:bolden/mini_game/flags_game_screen.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildModeCard(
          context: context,
          title: 'Flags Challenge',
          description: 'Guess the country from the flag.',
          icon: Icons.flag_circle,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlagsGameScreen(),
              ),
            );
          },
        ),
        _buildModeCard(
          context: context,
          title: 'Capitals Challenge',
          description: 'Guess the capital of the country.',
          icon: Icons.location_city,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Capitals mode coming soon!'))
            );
          },
        ),
        _buildModeCard(
          context: context,
          title: 'Borders Challenge ',
          description: 'Guess the neighboring countries.',
          icon: Icons.explore,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Borders mode coming soon!'))
            );
          },
        ),
      ],
    );
  }

  Widget _buildModeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card (
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(178),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}