import 'package:covid_tracker/Screens/world_stats.dart';
import 'package:flutter/material.dart';

class detailedInfo extends StatefulWidget {
  String image, name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test,
      todayDeaths,
      todayCases;
  detailedInfo(
      {Key? key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.todayDeaths,
      required this.todayCases})
      : super(key: key);

  @override
  State<detailedInfo> createState() => _detailedInfoState();
}

class _detailedInfoState extends State<detailedInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      reusableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString()),
                      reusableRow(
                          title: 'Total Deaths',
                          value: widget.totalDeaths.toString()),
                      reusableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString()),
                      reusableRow(
                        title: 'Active',
                        value: widget.active.toString(),
                      ),
                      reusableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      reusableRow(
                          title: 'Today Cases',
                          value: widget.todayCases.toString()),
                      reusableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                      reusableRow(
                          title: 'Today Deaths',
                          value: widget.todayDeaths.toString()),
                      reusableRow(
                          title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
