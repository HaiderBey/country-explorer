
import 'package:bolden/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatefulWidget {
  final Country country;

  const DetailScreen({
    super.key,
    required this.country,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    final country = widget.country;

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: SingleChildScrollView(
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
              country.population.toString(),
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
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
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
          children: items.map((item) => Chip(label: Text(item))).toList(),
        ),
      ],
    );
  }
}