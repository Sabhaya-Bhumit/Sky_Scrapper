class Covid_Countries {
  final String country;
  final String flag;
  final int population;
  final int totalCases;
  final int activeCases;
  final int totalRecovered;
  final int totalDeaths;

  Covid_Countries({
    required this.country,
    required this.flag,
    required this.population,
    required this.totalCases,
    required this.activeCases,
    required this.totalRecovered,
    required this.totalDeaths,
  });

  factory Covid_Countries.fromMap({required Map<String, dynamic> data}) {
    return Covid_Countries(
      country: data['country'],
      flag: data['countryInfo']['flag'],
      population: data['population'],
      totalCases: data['cases'],
      activeCases: data['active'],
      totalRecovered: data['recovered'],
      totalDeaths: data['deaths'],
    );
  }
}

class Covid_States {
  final String state;
  final int population;
  final int totalCases;
  final int activeCases;
  final int totalDeaths;

  Covid_States({
    required this.state,
    required this.population,
    required this.totalCases,
    required this.activeCases,
    required this.totalDeaths,
  });

  factory Covid_States.fromMap({required Map<String, dynamic> data}) {
    return Covid_States(
      state: data['state'],
      population: data['population'],
      totalCases: data['cases'],
      activeCases: data['active'],
      totalDeaths: data['deaths'],
    );
  }
}
