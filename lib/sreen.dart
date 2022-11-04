import 'package:covid_19/CovidData.dart';
import 'package:covid_19/helper/countriesAPIHelper.dart';
import 'package:flutter/material.dart';

class sreen extends StatefulWidget {
  const sreen({Key? key}) : super(key: key);

  @override
  State<sreen> createState() => _sreenState();
}

TextStyle style = TextStyle(fontSize: 20);

class _sreenState extends State<sreen> {
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: (res == 0)
              ? Text("World")
              : (res == 1)
                  ? Text("Countris")
                  : Text("States"),
          centerTitle: true),
      body: IndexedStack(
        index: res,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.lightBlue,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("\nWorld\n\n", style: style),
                Text("activeCases : 637,112,203", style: style),
                Text("\ntotal Cases : 637,112,203", style: style),
                Text("\nPopulation : 2,09,00,00,000", style: style),
                Text("\nTotal Deaths : 6,602,572", style: style),
                Text("\nRecovered:616,514,948", style: style),
              ],
            ),
          ),
          FutureBuilder(
            future: CovidAPIHleper.covidAPIHleper.fachDataCountries(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<Covid_Countries>? data = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      height: 500,
                      color: Colors.lightBlue,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text("\nCountry : ${data[i]!.country}\n\n",
                              style: style),
                          Image.network(
                            "${data[i]!.flag}",
                            height: 100,
                          ),
                          Text("\nactiveCases : ${data[i]!.activeCases}",
                              style: style),
                          Text("\ntotal Cases : ${data[i]!.totalCases}",
                              style: style),
                          Text("\nPopulation : ${data[i]!.population}",
                              style: style),
                          Text("\nTotal Deaths : ${data[i]!.totalDeaths}",
                              style: style),
                          Text("\nTotal Recovered : ${data[i]!.totalRecovered}",
                              style: style),
                        ],
                      ),
                    );
                  },
                  itemCount: data!.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FutureBuilder(
            future: CovidAPIHleper.covidAPIHleper.fachDataStates(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<Covid_States>? data = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      height: 500,
                      color: Colors.lightBlue,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text("\nCountry : ${data[i]!.state}\n\n",
                              style: style),
                          Text("\nactiveCases : ${data[i]!.activeCases}",
                              style: style),
                          Text("\ntotal Cases : ${data[i]!.totalCases}",
                              style: style),
                          Text("\nPopulation : ${data[i]!.population}",
                              style: style),
                          Text("\nTotal Deaths : ${data[i]!.totalDeaths}",
                              style: style),
                        ],
                      ),
                    );
                  },
                  itemCount: data!.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
