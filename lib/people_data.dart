class People {
  String? gender;
  String? title;
  String? first;
  String? last;
  String? city;
  String? state;
  String? country;
  String? email;
  String? date;
  int? age;
  String? phone;
  String? photo;

  People(
      {required this.title,
      required this.age,
      required this.city,
      required this.country,
      required this.date,
      required this.email,
      required this.first,
      required this.gender,
      required this.last,
      required this.phone,
      required this.photo,
      required this.state});

  factory People.fromMap({required Map<String, dynamic> data}) {
    return People(
        title: data['results'][0]['name']['title'],
        age: data['results'][0]['dob']['age'],
        city: data['results'][0]['location']['city'],
        country: data['results'][0]['location']['country'],
        date: data['results'][0]['dob']['date'],
        email: data['results'][0]['email'],
        first: data['results'][0]['name']['first'],
        gender: data['results'][0]['gender'],
        last: data['results'][0]['name']['last'],
        phone: data['results'][0]['phone'],
        photo: data['results'][0]['picture']['large'],
        state: data['results'][0]['location']['state']);
  }
}
