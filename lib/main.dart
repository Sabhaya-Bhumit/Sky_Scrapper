import 'package:flutter/material.dart';
import 'package:random_people_api/helper/peopleHelperAPI.dart';
import 'package:random_people_api/people_data.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    ),
  );
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

TextStyle style = TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis);

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Rendom People API"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              height: _height * 0.8,
              width: _width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue),
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error is :${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      People? data = snapshot.data;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "  Name : ${data!.title}.${data!.first} ${data.last}\n",
                                          style: style),
                                      Text(
                                          "  DOB : ${data!.date!.split("T")[0]}",
                                          style: style),
                                      Text("\n  Age :  ${data!.age}\n",
                                          style: style),
                                    ],
                                  )),
                              Expanded(
                                  child: Image.network(
                                "${data!.photo}",
                                fit: BoxFit.cover,
                              )),
                              SizedBox(width: 10),
                            ],
                          ),
                          Text("  Gender :  ${data!.gender}", style: style),
                          Text("\n  Email ID :  ${data!.email}", style: style),
                          SelectableText("\n  Phone Number:  ${data!.phone}",
                              style: style),
                          Text("\n  City:  ${data!.city}", style: style),
                          Text("\n  State:  ${data!.state}", style: style),
                          Text("\n  Country:  ${data!.country}", style: style),
                        ],
                      );
                    }
                    return CircularProgressIndicator(
                      color: Colors.red,
                    );
                  },
                  future: PeopleAPIHelper.peopleAPIHelper
                      .fectdata(API: "https://randomuser.me/api/")),
            ),
          ),
          SizedBox(
              width: _width * 0.5,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      PeopleAPIHelper.peopleAPIHelper
                          .fectdata(API: "https://randomuser.me/api/");
                    });
                  },
                  child: Text("Next")))
        ],
      ),
    );
  }
}
