import 'dart:convert';

import 'package:covid_tracker/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

import '../model/WorldStatesModel.dart';

class StatesServices {

  Future<WorldStatesModel> fetchWorldStatesRecords () async {

   final response = await http.get(Uri.parse(AppUrl.worldStateApi));

   if(response.statusCode == 200){
     var data = jsonDecode(response.body);
     return WorldStatesModel.fromJson(data);

   }else{
     throw Exception("error");
    }

  }
  Future<List<dynamic>> countriesListApi () async {
    final response = await http.get(Uri.parse(AppUrl.countriesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;

    }else{
      throw Exception("error");
    }

  }
}