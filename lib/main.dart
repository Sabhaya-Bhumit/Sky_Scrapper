import 'package:covid_19/sreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => home(),
        'sreen': (context) => sreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

List Covid = [
  "World",
  "countries",
  "states",
];

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Covid-19"), centerTitle: true),
      body: Column(
        children: Covid.map((e) => InkWell(
            onTap: () {
              setState(() {
                int i = Covid.indexOf(e);
                Navigator.of(context).pushNamed('sreen', arguments: i);
              });
            },
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.lightBlue,
                  child: Text("$e"),
                ),
              ],
            ))).toList(),
      ),
    );
  }
}
