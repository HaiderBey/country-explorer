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
    return switch (json){
      {
      'name': String name,
      'capital': String capital,
      'region': String region,
      'subregion': String subregion,
      'borders': List<dynamic> borders,
      'population': int population,
      'timezones': List<dynamic> timezones,
      'alpha2Code': String alpha2Code,
      'alpha3Code': String alpha3Code,
      'callingCodes': List<dynamic> callingCodes,
      'demonym': String demonym,
      'flag': String flag,
      'currencies': List<dynamic> currencies,
      'languages': List<dynamic> languages,
      } => Country(
        name: name,
        capital: capital,
        region: region,
        subregion: subregion,
        borders: borders.cast<String>(), //Converted from List<dynamic> to List<String>
        population: population,
        timezones: timezones.cast<String>(), 
        codes: [alpha2Code, alpha3Code],
        callingCodes: callingCodes.cast<String>(),
        demonym: demonym,
        flag: flag,
        //Currencies and languages are contained in objects, therefore they need mapping before converstion to string
        currencies: currencies.map((c) => Currency.fromJson(c)).toList(),
        languages: languages.map((l) => l['name'] as String).toList(), // I only took the name field under languages
      ),
      _ => throw const FormatException('Failed to load country.')
    };
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