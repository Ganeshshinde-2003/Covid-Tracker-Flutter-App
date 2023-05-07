import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DeatilScreen extends StatefulWidget {
  String name, image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  DeatilScreen({Key? key, required this.name, required this.image, required this.totalCases, required this.totalDeaths, required this.totalRecovered,required this.active,required this.critical,required this.todayRecovered,required this.test,}) : super(key: key);

  @override
  State<DeatilScreen> createState() => _DeatilScreenState();
}

class _DeatilScreenState extends State<DeatilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      ReusableRow(value: "Cases", title: widget.totalCases.toString()),
                      ReusableRow(value: "Recovered", title: widget.totalRecovered.toString()),
                      ReusableRow(value: "Deaths", title: widget.totalDeaths.toString()),
                      ReusableRow(value: "Critical", title: widget.critical.toString()),
                      ReusableRow(value: "Today Recovered", title: widget.todayRecovered.toString()),
                      ReusableRow(value: "Active", title: widget.active.toString()),
                      ReusableRow(value: "Test", title: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),

              )
            ],
          )
        ],
      ),
    );
  }
}
