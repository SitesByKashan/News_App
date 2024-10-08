import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_app/modelApi/catagorymodel.dart';
import 'package:new_app/modelApi/querymodel.dart';

String key = "API-KEY";

String category = "";
String quary = "";
String urlC =
    "https://newsapi.org/v2/top-headlines/sources?category=$category&apiKey=$key";
String urlQ = "https://newsapi.org/v2/top-headlines?q=$quary&apiKey=$key";
String urlT =
    "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$key";

String Terror = "";
String Qerror = "";
String Cerror = "";

Future<TopnewsBBCModel?> topnews() async {
  var uri = Uri.parse(urlT);
  TopnewsBBCModel? output;

  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      output = TopnewsBBCModel.fromJson(body);
    } else {
      throw Exception("Failed to Load");
    }
  } catch (e) {
    Terror = e.toString();
    print(e);
  }

  return output;
}

Future<QueryNewsModel?> querynews(String queryy) async {
  var uri =
      Uri.parse("https://newsapi.org/v2/top-headlines?q=$queryy&apiKey=$key");
  QueryNewsModel? output;

  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      output = QueryNewsModel.fromJson(body);
    } else {
      throw Exception("Failed to Load");
    }
  } catch (e) {
    Terror = e.toString();
    print(e);
  }

  return output;
}

Future<CategoryNewsModel?> catagorynews(String catagoryy) async {
  var uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines/sources?category=$catagoryy&apiKey=$key");
  CategoryNewsModel? output; // Changed to nullable type

  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      output = CategoryNewsModel.fromJson(body);
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  } catch (e) {
    print("Exception occurred: $e");
  }

  return output; // Will return null if there was an error
}
