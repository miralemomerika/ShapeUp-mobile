import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class HttpService {
  static String token = "";
  static String role = "";
  static String name = "";
  String route = "";

  HttpService({this.route = ""});

  void setVars(String _token, String _role, String _name) 
  {
    token = _token;
    role = _role;
    name = _name;
  }

  static Future<List<dynamic>?> Get(String route, dynamic object, {List<String>? includeList = null}) async
  {
    String queryString = Uri(queryParameters : object).query;
    if(includeList != null && includeList.length > 0)
    {
      includeList.asMap().forEach((key, value) {
        if(key == 0 && object == null)
        {
          queryString = "IncludeList=${value}";
        }
        else {
          queryString += "&IncludeList=${value}";
        }
      });
    }

    String baseUrl = "http://10.0.2.2:8010/api/" + route;

    if(object != null || includeList != null){
      baseUrl += "?" + queryString;
    }

    final String auth = 'Bearer ' + token;
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {HttpHeaders.authorizationHeader: auth},
    );
    if(response.statusCode == 200){
      return json.decode(response.body) as List;
    }

    return null;
  }

  static Future<dynamic>? GetObj(String route, dynamic object) async
  {
    String queryString = Uri(queryParameters : object).query;
    
    String baseUrl = "http://10.0.2.2:8010/api/" + route;

    if(object != null){
      baseUrl += "?" + queryString;
    }

    final String auth = 'Bearer ' + token;
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {HttpHeaders.authorizationHeader: auth},
    );
    if(response.statusCode == 200){
      return json.decode(response.body);
    }

    return null;
  }

  static Future<dynamic> Post(String route, String body) async {
    String baseUrl = "http://10.0.2.2:8010/api/" + route;
    final String auth = 'Bearer ' + token;
    var response = null;
    if(token.isNotEmpty){
      response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': auth
        },
        body: body,
      );
    }
    else {
      response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: body,
      );
    }

    if(response.statusCode == 200 && response.body.isEmpty){
      return "200";
    }
    if(response.statusCode != 200){
      return "500";
    }
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    return null;
  }

  static Future<dynamic> PostObj(String route, dynamic body) async {
    String baseUrl = "http://10.0.2.2:8010/api/" + route;
    final String auth = 'Bearer ' + token;
    var response = null;
    if(token.isNotEmpty){
      response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': auth
        },
        body: jsonEncode(body),
      );
    }
    else {
      response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(body),
      );
    }

    if(response.statusCode == 200 && response.body.isEmpty){
      return "200";
    }
    if(response.statusCode != 200){
      return "500";
    }
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    return null;
  }

  static void Logout() {
    HttpService.token = "";
  }
}
