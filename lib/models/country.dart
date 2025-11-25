class Country {
  final String name;
  final String capital;
  final String region;
  final String subregion;
  final List<String> timezones;
  final List<String> codes; // TUN / TN..
  final List<String> callingCodes; // It's a list in API
  final String demonym; // ex: Tunisian
  final String flag;
  final List<Currency> currencies; // ex Switzerland
  final List<String> languages;
  final List<String> borders;
  final int population;

  Country({
    required this.name, 
    required this.capital, 
    required this.region, 
    required this.subregion, 
    required this.timezones, 
    required this.codes, 
    required this.callingCodes, 
    required this.demonym, 
    required this.flag, 
    required this.currencies, 
    required this.languages, 
    required this.borders, 
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json){

    final name = json['name'] as String? ?? 'Unknown Country';
    final capital = json['capital'] as String? ?? 'N/A';
    final region = json['region'] as String? ?? 'Unknown Region';
    final subregion = json['subregion'] as String? ?? 'N/A';
    final demonym = json['demonym'] as String? ?? 'N/A';
    final flag = json['flag'] as String? ?? ''; 
    final population = json['population'] as int? ?? 0;
    
    final timezonesList = json['timezones'] as List<dynamic>? ?? [];
    final bordersList = json['borders'] as List<dynamic>? ?? [];
    final callingCodesList = json['callingCodes'] as List<dynamic>? ?? [];
    final currenciesList = json['currencies'] as List<dynamic>? ?? [];
    final languagesList = json['languages'] as List<dynamic>? ?? [];

    final alpha2Code = json['alpha2Code'] as String? ?? '';
    final alpha3Code = json['alpha3Code'] as String? ?? '';

    return Country(
          name: name,
          capital: capital,
          region: region,
          subregion: subregion,
          borders: bordersList.cast<String>(), 
          population: population,
          timezones: timezonesList.cast<String>(), 
          codes: [alpha2Code, alpha3Code],
          callingCodes: callingCodesList.cast<String>(),
          demonym: demonym,
          flag: flag,
          currencies: currenciesList.map((c) => Currency.fromJson(c as Map<String, dynamic>)).toList(),
          languages: languagesList.map((l) => (l as Map<String, dynamic>)['name'] as String? ?? 'N/A').toList(), 
    );
  }

  factory Country.error() {
    return Country(
      name: 'Holy 404 Empire',
      capital: '127.0.0.1 (Localhost)',
      region: 'The Void',
      subregion: 'The Back-end Abyss',
      timezones: ['UTC-NaN'],
      codes: ['404', 'ERR'],
      callingCodes: ['190'],
      demonym: 'The Frustrated',
      flag: 'https://placehold.co/600x400/CCCCCC/000000?text=404+Flag+Not+Found',
      population: 1,
      borders: ['Null', 'Undefined', 'StackOverflow'],
      currencies: [
        Currency(code: 'ELC', name: 'Electricity', symbol: '⚡')
      ],
      languages: ['Binary']
    );
  }

}

class Currency {
  final String code;
  final String name;
  final String symbol;

  Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });
  
  factory Currency.fromJson(Map <String, dynamic> json){
    return switch (json){
      {
        'code': String code,
        'name': String name,
        'symbol': String symbol,
      } => Currency(
        code: code,
        name: name,
        symbol: symbol,
      ),
      _ => throw const FormatException("Failed to load currency information.")
    };
  }
}