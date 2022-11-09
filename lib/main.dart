import 'package:currencies_api/helper/currenciesAPIHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    home(),
  );
}

List? all_cuntcies;
Map? data;
TextEditingController amount_controller = TextEditingController(text: "1");
dynamic initalValue = "USD";
int iosinitalValue = 0;
dynamic intvalue = "INR";
int iosintvalue = 0;

TextStyle style = TextStyle(fontSize: 20);

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool ios = false;
  @override
  Widget build(BuildContext context) {
    return (ios == true)
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  leading: Builder(
                    builder: (context) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Icon(Icons.list));
                    },
                  ),
                  middle: Text("Currencies API"),
                  trailing: CupertinoSwitch(
                      value: ios,
                      onChanged: (val) {
                        setState(() {
                          ios = val;
                        });
                      }),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: CurrenciAPIHelper.currenciAPIHelper.fectdat(
                            API:
                                "https://api.fastforex.io/fetch-all?api_key=3cc51ff263-08e3d3a87b-rkrecw"),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Error is ${snapshot.error}"));
                          } else if (snapshot.hasData) {
                            all_cuntcies = snapshot.data;
                            // Currencies? data = snapshot.data;
                            // value = data;

                            return Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\n\nCurrency\nConverter",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue),
                                  ),
                                  SizedBox(height: 50),
                                  Text(
                                    "From : ",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.black, width: 3)),
                                    child: CupertinoPicker(
                                      children: all_cuntcies!
                                          .map((e) => Text("${e.key}"))
                                          .toList(),
                                      onSelectedItemChanged: (val) {
                                        setState(() {
                                          iosinitalValue = val;
                                          initalValue =
                                              all_cuntcies![iosinitalValue].key;
                                        });
                                      },
                                      itemExtent: 35,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "To : ",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.black, width: 3)),
                                    child: CupertinoPicker(
                                      children: all_cuntcies!
                                          .map((e) => Text("${e.key}"))
                                          .toList(),
                                      onSelectedItemChanged: (val) {
                                        setState(() {
                                          iosintvalue = val;
                                          intvalue =
                                              all_cuntcies![iosintvalue].key;
                                        });
                                      },
                                      itemExtent: 35,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Text(
                                        "Amount : ",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      Expanded(
                                        child: CupertinoTextField(
                                          controller: amount_controller,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.lightBlue),
                                          onSubmitted: (val) {
                                            setState(() {
                                              if (val.isEmpty) {
                                                amount_controller.text = "1";
                                              } else {
                                                amount_controller.text = val!;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Text(
                                        "Result : ",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      FutureBuilder(
                                        future: CurrenciAPIHelper
                                            .currenciAPIHelper
                                            .fectdata(
                                                parm: num.parse(
                                                    amount_controller.text),
                                                from: initalValue,
                                                to: intvalue),
                                        builder: (context, snapshot) {
                                          print(snapshot.data);

                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text("${snapshot.error}"),
                                            );
                                          } else if (snapshot.hasData) {
                                            num? data = snapshot.data;
                                            return Text(
                                              "$data",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.green),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                )),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("Currencies API"),
                centerTitle: true,
                actions: [
                  Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                      value: ios,
                      onChanged: (val) {
                        setState(() {
                          ios = val;
                        });
                      }),
                ],
              ),
              body: Column(
                children: [
                  FutureBuilder(
                    future: CurrenciAPIHelper.currenciAPIHelper.fectdat(
                        API:
                            "https://api.fastforex.io/fetch-all?api_key=3cc51ff263-08e3d3a87b-rkrecw"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text("Error is ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        all_cuntcies = snapshot.data;
                        // Currencies? data = snapshot.data;
                        // value = data;

                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Currency\nConverter",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              ),
                              SizedBox(height: 50),
                              Text(
                                "From : ",
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black, width: 3)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<dynamic>(
                                    value: initalValue,
                                    items: all_cuntcies!
                                        .map((e) => DropdownMenuItem(
                                              child: Text("  ${e.key}"),
                                              value: "${e.key}",
                                            ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        initalValue = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "To : ",
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black, width: 3)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<dynamic>(
                                    value: intvalue,
                                    items: all_cuntcies!
                                        .map((e) => DropdownMenuItem(
                                              child: Text("   ${e.key}"),
                                              value: "${e.key}",
                                            ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        intvalue = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Text(
                                    "Amount : ",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: amount_controller,
                                      onFieldSubmitted: (val) {
                                        setState(() {
                                          if (val.isEmpty) {
                                            amount_controller.text = "1";
                                          } else {
                                            amount_controller.text = val!;
                                          }
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder().copyWith(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        hintText: "Enter you ",
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Text(
                                    "Result : ",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  FutureBuilder(
                                    future: CurrenciAPIHelper.currenciAPIHelper
                                        .fectdata(
                                            parm: num.parse(
                                                amount_controller.text),
                                            from: initalValue,
                                            to: intvalue),
                                    builder: (context, snapshot) {
                                      print(snapshot.data);

                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text("${snapshot.error}"),
                                        );
                                      } else if (snapshot.hasData) {
                                        num? data = snapshot.data;
                                        return Text(
                                          "$data",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: Colors.green),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ));
  }
}
