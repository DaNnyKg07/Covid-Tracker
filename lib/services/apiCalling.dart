import 'dart:convert';

import 'package:covid_tracker/Screens/world_stats.dart';
import 'package:covid_tracker/model/world_stats.dart';
import 'package:covid_tracker/services/appUrl.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> getWorldStats() async {
    final response = await http.get(Uri.parse(worldStatsUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getCountriesList() async {
    var data;
    final response = await http.get(Uri.parse(countryListUrl));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('error');
    }
  }
}
