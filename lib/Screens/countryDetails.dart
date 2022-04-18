import 'package:covid_tracker/Screens/detaliedInfo.dart';
import 'package:covid_tracker/services/apiCalling.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countryList extends StatefulWidget {
  const countryList({Key? key}) : super(key: key);

  @override
  State<countryList> createState() => _countryListState();
}

class _countryListState extends State<countryList> {
  StatsServices statsServices = StatsServices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Stats'),
      ),
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            onChanged: (value) {
              setState(() {});
            },
            controller: searchController,
            decoration: InputDecoration(
                hintText: 'Search Countries',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: statsServices.getCountriesList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                    height: 10, width: 80, color: Colors.white),
                                subtitle: Container(
                                    height: 10, width: 80, color: Colors.white),
                                leading: Container(
                                    height: 50, width: 50, color: Colors.white),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailedInfo(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                    ['country'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                test: snapshot.data![index]
                                                    ['tests'],
                                                todayCases: snapshot
                                                    .data![index]['todayCases'],
                                                todayDeaths:
                                                    snapshot.data![index]
                                                        ['todayDeaths'],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      // fit: BoxFit.fill,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailedInfo(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                    ['country'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                test: snapshot.data![index]
                                                    ['tests'],
                                                todayCases: snapshot
                                                    .data![index]['todayCases'],
                                                todayDeaths:
                                                    snapshot.data![index]
                                                        ['todayDeaths'],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      // fit: BoxFit.fill,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              }),
        )
      ]),
    );
  }
}
