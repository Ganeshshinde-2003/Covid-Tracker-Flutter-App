import 'package:covid_tracker/View/countires_list.dart';
import 'package:covid_tracker/model/WorldStatesModel.dart';
import 'package:covid_tracker/services/states_servies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>with TickerProviderStateMixin  {

  late final AnimationController _controller = AnimationController(vsync: this,
      duration: const Duration(seconds: 3)
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorsList = <Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height* .01,),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel>snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      )
                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":double.parse(snapshot.data!.cases!.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                          "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartRadius: MediaQuery.of(context).size.width/ 3.2,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        chartType: ChartType.ring,
                        colorList: colorsList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(value: snapshot.data!.cases.toString(), title: "Total"),
                              ReusableRow(value: snapshot.data!.deaths.toString(), title: "Deaths"),
                              ReusableRow(value: snapshot.data!.recovered.toString(), title: "Recovered"),
                              ReusableRow(value: snapshot.data!.active.toString(), title: "Active"),
                              ReusableRow(value: snapshot.data!.critical.toString(), title: "Critical"),
                              ReusableRow(value: snapshot.data!.todayDeaths.toString(), title: "Today Deaths"),
                              ReusableRow(value: snapshot.data!.todayCases.toString(), title: "Today Recovered"),
                              ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesListScreen()));
                          },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text("Track Countries!!!"),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.value, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}















