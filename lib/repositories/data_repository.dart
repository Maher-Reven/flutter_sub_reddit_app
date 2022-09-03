import 'dart:convert';
import 'dart:developer';

import 'package:flutter_assignment/models/data_model.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  Future<List<DataModel>> getData(String type) async {
    Category? result;
    try {
      final response = await http.get(
        Uri.parse('https://www.reddit.com/r/FlutterDev/$type.json'),
      );
      if (response.statusCode == 200) {
        final items = jsonDecode(response.body);
        result = Category.fromJson(items);
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }

    final List<DataModel>? dataModels =
        result?.data.children.map((Article article) => article.data).toList();

    // //sorting dataModels
    // dataModels?.sort((a, b) => a.creationTime.compareTo(b.creationTime));

    return dataModels ?? [];
  }
}
