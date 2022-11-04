import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_people_api/people_data.dart';

class PeopleAPIHelper {
  PeopleAPIHelper._();
  static final PeopleAPIHelper peopleAPIHelper = PeopleAPIHelper._();

  Future<People?> fectdata({required String API}) async {
    http.Response res = await http.get(Uri.parse("$API"));

    if (res.statusCode == 200) {
      Map<String, dynamic> jsondata = jsonDecode(res.body);
      People people = People.fromMap(data: jsondata);
      return people;
    }
  }
}
