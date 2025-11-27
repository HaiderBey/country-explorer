import 'package:bolden/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget{
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context){
    final provider = Provider.of<CountryProvider>(context, listen: false);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDarkMode 
      ? Theme.of(context).cardColor 
      : Colors.grey.shade100;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final hintColor = isDarkMode ? Colors.white54 : Colors.grey.shade600;  
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: provider.setSearchQuery,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: 'Search by country, capital or region...',
          hintStyle: TextStyle(color: hintColor),
          prefixIcon: Icon(Icons.search, color: hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          filled: true, 
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }
}