import 'package:bolden/providers/country_provider.dart';
import 'package:bolden/screens/favorites_screen.dart';
import 'package:bolden/mini_game/game_screen.dart';
import 'package:bolden/screens/home_screen.dart';
import 'package:bolden/screens/map_screen.dart';
import 'package:bolden/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MapScreen(),
    FavoritesScreen(),
    GameScreen(),
    SettingsScreen(),
  ];

  PreferredSizeWidget _getAppBar(BuildContext context, CountryProvider provider) {
    String title;
    List<Widget> actions = [];

    switch (_selectedIndex) {
      case 0:
        title = 'Bolden';
        actions.add(
          PopupMenuButton<SortCriteria>(
            icon: const Icon(Icons.sort),
            onSelected: (SortCriteria result) {
              provider.setSortCriteria(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortCriteria>>[
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.nameAsc,
                child: Text('Name (A-Z)'),
              ),
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.nameDesc,
                child: Text('Name (Z-A)'),
              ),
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.populationDesc,
                child: Text('Population (High to Low)'),
              ),
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.populationAsc,
                child: Text('Population (Low to High)'),
              ),
            ],
          ),
        );
        break;
      case 1:
        title = 'Explore Countries';
        break;
      case 2:
        title = 'Favorite Countries';
        break;
      case 3:
        title = 'Country Quiz';
        break;
      case 4:
        title = 'Settings';
        break;
      default:
        title = 'Bolden';
    }

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  void _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

@override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: _getAppBar(context, provider),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.public),
                label: 'Countries',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.casino),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? Color(0xFF3AB4F2)
              : Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white70
              : Colors.grey,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}