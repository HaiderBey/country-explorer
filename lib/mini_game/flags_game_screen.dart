import 'dart:math';
import 'package:bolden/models/country.dart';
import 'package:bolden/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FlagsGameScreen extends StatefulWidget {
  const FlagsGameScreen({super.key});

  @override
  State<FlagsGameScreen> createState () => _FlagsGameScreenState();
}

class _FlagsGameScreenState extends State<FlagsGameScreen> {
  Country? _currentQuestionCountry;
  final Random _random = Random();
  final TextEditingController _guessController = TextEditingController();

  String? _feedbackMessage;
  Color? _feedbackColor;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNewQuestion();
    });
  }

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }

  void _loadNewQuestion() {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    final List<Country> countries = provider.countries;

    if (countries.isEmpty || provider.status != Status.loaded) {
      setState(() {
        _currentQuestionCountry = null;
      });
      return;
    } 

    _guessController.clear();
    _feedbackMessage = null;
    _feedbackColor = null;

    final int randomIndex = _random.nextInt(countries.length);
    final Country selectedCountry = countries[randomIndex];

    setState(() {
      _currentQuestionCountry = selectedCountry;
    });
  }

  void _handleAnswer() {
    if (_currentQuestionCountry == null) return;

    final String correctName = _currentQuestionCountry!.name.toLowerCase().trim();
    final String userInput = _guessController.text.toLowerCase().trim();

    if (userInput.isEmpty) {
      setState(() {
        _feedbackMessage = 'Please enter a country name.';
        _feedbackColor = Colors.orange;
      });
      return;
    }

    if (userInput == correctName) {
      setState(() {
        _feedbackMessage = 'Correct! Loading next country';
        _feedbackColor = Colors.green;
      });

      Future.delayed(const Duration(seconds: 1), () {
        _loadNewQuestion();
      });
    } else {
     setState(() {
       _feedbackMessage = 'Incorrect. The answer was: ${_currentQuestionCountry!.name}.';
       _feedbackColor = Colors.red;
     }); 

     Future.delayed(const Duration(seconds: 1), () {
      _loadNewQuestion();
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context);
    
    if (provider.status == Status.loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Flags Challenge')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentQuestionCountry == null || provider.countries.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flags Challenge')),
        body: Center(child: Text(
          provider.status == Status.error
            ? 'Error loading countries: ${provider.errorMessage}'
            : 'No Countries loaded to start the game.',
          textAlign: TextAlign.center,
        )),
      );
    }

    final Country country = _currentQuestionCountry!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flags Challenge'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Guess the country from the flag!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SvgPicture.network(
                  country.flag,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => const Center(child: CircularProgressIndicator()),
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 30),

            if (_feedbackMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  _feedbackMessage!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _feedbackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            
            TextField(
              controller: _guessController,
              decoration: InputDecoration(
                hintText: 'Type the country name here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _guessController.clear,
                ),
              ),
              onSubmitted: (_) => _handleAnswer(),
            ),

            const SizedBox(height:20),

            ElevatedButton.icon(
              onPressed: _handleAnswer,
              icon: const Icon(Icons.send),
              label: const Text(
                'Enter',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}