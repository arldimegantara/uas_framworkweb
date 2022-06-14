import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rajinbaca/model.dart';

class Repository{
  final _baseurl = "https://62a8044d943591102b986c04.mockapi.io/api/test";

  Future getData() async{
    try{
      final response = await http.get(Uri.parse(_baseurl));

      if(response.statusCode == 200){
        Iterable it = jsonDecode(response.body);
        List<Person> person = it.map((e) => Person.fromJson(e)).toList();
        return person;
      }
    }catch(e){
      print(e.toString());
    }
  }
}