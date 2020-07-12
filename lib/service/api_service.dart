import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{
  static http.Client api = http.Client();

  static Future<dynamic>getResponse(url)async{
    var response = await http.get(url);

    if(response.statusCode ==200){
      var res = json.decode(response.body);
      return res;
    }else{
      throw Exception('failed fetch');
    }
  }
}