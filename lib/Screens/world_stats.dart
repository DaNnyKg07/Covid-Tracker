import 'package:covid_tracker/Screens/countryDetails.dart';
import 'package:covid_tracker/model/world_stats.dart';
import 'package:covid_tracker/services/apiCalling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class worldStats extends StatefulWidget {
  const worldStats({Key? key}) : super(key: key);

  @override
  State<worldStats> createState() => _worldStatsState();
}

class _worldStatsState extends State<worldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this)
    ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final colorList = const [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          FutureBuilder(
              future: statsServices.getWorldStats(),
              builder: (context, AsyncSnapshot<WorldStatsModel?> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                          size: 50,
                          controller: _controller,
                          color: Colors.white));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        animationDuration: const Duration(milliseconds: 1500),
                        chartType: ChartType.ring,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.height * 0.15,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 10, bottom: 10),
                            child: Column(
                              children: [
                                reusableRow(
                                    title: 'Total Cases',
                                    value: snapshot.data!.cases.toString()),
                                reusableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                reusableRow(
                                    title: 'Total Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                reusableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                reusableRow(
                                    title: 'Today Cases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                reusableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                reusableRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                reusableRow(
                                    title: 'Tests',
                                    value: snapshot.data!.tests.toString()),
                                reusableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => countryList()));
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('Track Countries')),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ],
      )),
    );
  }
}

class reusableRow extends StatelessWidget {
  String title, value;
  reusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Divider(thickness: 2.5),
        ],
      ),
    );
  }
}
