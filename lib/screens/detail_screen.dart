
import 'package:bolden/models/country.dart';
import 'package:bolden/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String countryCode;

  const DetailScreen({
    super.key,
    required this.countryCode,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Country> _countryFuture;
  
  @override
  void initState() {
    super.initState();

    //I am using setState because I'm re-using the same Detail Screen widget instance instead of pushing a new one
    _fetchData(); 
  }
  
  void _fetchData() {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    setState(() {
      _countryFuture = provider.fetchCountryDetails(widget.countryCode);
    });
  }

  @override
  void didUpdateWidget(DetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryCode != oldWidget.countryCode) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Details'),
      ),
      body: FutureBuilder<Country>(
        future: _countryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final errorCountry = Country.error();
            debugPrint('Detail Screen Fetch Error: ${snapshot.error}');
            return _buildDetailedContent(context, errorCountry);
          }
      
          if (snapshot.hasData){
            final country = snapshot.data!;
            
            return _buildDetailedContent(context, country);
          }

          return const Center(
            child: Text('An unknown error occurred.')
          );
        },
      ),
    );
  }

  Widget _buildDetailedContent(BuildContext context, Country country) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Flag
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SvgPicture.network(
                country.flag,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 20),
          //Country Details 
          Text(
            country.name,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '(${country.demonym})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(179),
            ),
          ),
          const Divider(),

          _buildInfoRow(
            context,
            'Capital',
            country.capital,
            Icons.location_city
          ),
          _buildInfoRow(
            context,
            'Population',
            country.population.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
              (Match m) => '${m[1]},'
            ),
            Icons.people
          ),
          _buildInfoRow(
            context,
            'Region / Subregion',
            '${country.region} / ${country.subregion}',
            Icons.public
          ),
          _buildInfoRow(
            context,
            'Timezones',
            country.timezones.join(', '),
            Icons.access_time
          ),

          const SizedBox(height: 20),

          //Currency + language
          Text(
            'Details',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 10),

          _buildDetailList(
            context,
            'Currencies',
            country.currencies.map((c) => '${c.name} (${c.code})').toList()
          ),
          _buildDetailList(
            context,
            'Languages',
            country.languages
          ),

          const SizedBox(height: 20),
          
          //Borders
          _buildDetailList(
            context,
            'Borders',
            country.borders.isEmpty ? ['None'] : country.borders
          ),

          //Placeholder for Map Integration (I plan to add it later :) )
          const SizedBox(height: 40),
          const Text("أنا خريطة!")
        ],
      ),
    );
  }



  Widget _buildInfoRow(BuildContext context, String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailList(BuildContext context, String title, List<String> items) {
    bool isBorderList = title == 'Borders';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Text(
            '$title:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: items.map((item) {
            if (isBorderList && item != 'None') {
              return ActionChip(
                label: Text(item),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(countryCode: item),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(25),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              );
            } else {
              return Chip(label: Text(item));
            }
          }).toList(),
        ),
      ],
    );
  }
}