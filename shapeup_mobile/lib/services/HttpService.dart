import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class HttpService {
  static String token = "";
  String route = "";

  HttpService({this.route = ""});

  void setToken(String _token) 
  {
    token = _token;
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

    String baseUrl = "http://127.0.0.1:8081/api/" + route;

    if(object != null || includeList != null){
      baseUrl += "?" + queryString;
    }

    final String auth = 'Bearer' + token;
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {HttpHeaders.authorizationHeader: auth},
    );
    if(response.statusCode == 200){
      return json.decode(response.body) as List;
    }

    return null;
  }
}
