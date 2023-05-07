import 'package:covid_tracker/services/states_servies.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'details_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  StatesServices statesServices = StatesServices();
  TextEditingController searchCountries = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchCountries,
                onChanged: (value){
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with Country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10, width: 80, color: Colors.white,),
                                      subtitle: Container(height: 10, width: 80, color: Colors.white,),
                                      leading: Container(height: 50, width: 50, color: Colors.white,),
                                    )
                                  ],
                                ),
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]["country"];
                          if(searchCountries.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeatilScreen(
                                      name: snapshot.data![index]["country"].toString(),
                                      image: snapshot.data![index]["countryInfo"]["flag"],
                                      totalCases: snapshot.data![index]["cases"],
                                      totalRecovered: snapshot.data![index]["recovered"],
                                      totalDeaths: snapshot.data![index]["deaths"],
                                      active: snapshot.data![index]["active"],
                                      test: snapshot.data![index]["tests"],
                                      todayRecovered: snapshot.data![index]["todayRecovered"],
                                      critical: snapshot.data![index]["critical"],
                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]["country"].toString()),
                                    subtitle: Text(snapshot.data![index]["cases"].toString()),
                                    leading: Image(
                                        height:50,
                                        width:50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]["flag"]
                                        )),
                                  ),
                                )
                              ],
                            );
                          }else if ( name.toLowerCase().contains(searchCountries.text.toLowerCase()) ) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DeatilScreen(
                                        name: snapshot.data![index]["country"].toString(),
                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        totalCases: snapshot.data![index]["cases"],
                                        totalRecovered: snapshot.data![index]["recovered"],
                                        totalDeaths: snapshot.data![index]["deaths"],
                                        active: snapshot.data![index]["active"],
                                        test: snapshot.data![index]["tests"],
                                        todayRecovered: snapshot.data![index]["todayRecovered"],
                                        critical: snapshot.data![index]["critical"],
                                      )));
                                  } ,
                                  child: ListTile(
                                    title: Text(snapshot.data![index]["country"].toString()),
                                    subtitle: Text(snapshot.data![index]["cases"].toString()),
                                    leading: Image(
                                        height:50,
                                        width:50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]["flag"]
                                        )),
                                  ),
                                )
                              ],
                            );
                          }else{
                            return Container();
                          }

                        });
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
