import 'dart:convert';

import 'package:covid_19/CovidData.dart';
import 'package:http/http.dart' as http;

class CovidAPIHleper {
  CovidAPIHleper._();
  static final CovidAPIHleper covidAPIHleper = CovidAPIHleper._();

  Future<List<Covid_Countries>?> fachDataCountries() async {
    String uri = "https://disease.sh/v3/covid-19/countries";
    http.Response res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      List decoData = jsonDecode(res.body);
      List<Covid_Countries> covid_countriess =
          decoData.map((e) => Covid_Countries.fromMap(data: e)).toList();

      return covid_countriess;
    }
    return null;
  }

  Future<List<Covid_States>?> fachDataStates() async {
    String uri = "https://disease.sh/v3/covid-19/states";
    http.Response res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      List decoData = jsonDecode(res.body);
      List<Covid_States> covid_States =
          decoData.map((e) => Covid_States.fromMap(data: e)).toList();

      return covid_States;
    }
    return null;
  }
}
