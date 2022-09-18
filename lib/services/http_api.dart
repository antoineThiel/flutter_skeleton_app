import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpApi {
  final defaultUrl = "https://pokeapi.co/api/v2";


  //With custom options
  // Dio client = Dio(BaseOptions(
  //   baseUrl: 'https://pokeapi.co/api/v2',
  //   connectTimeout: 5000,
  //   receiveTimeout: 3000,
  // ));

  //Default Options
  Dio client = Dio();

  //Get Request
  void getCharmanderDetails() async {
    Response response;
    response = await client.get("$defaultUrl/pokemon/charmander");
    debugPrint(response.data.toString());
  }

  //Post Request -- Not Working with pokemon api
  void setCharmanderDetails() async {
    Response response;
    response = await client
        .post("$defaultUrl/charmander", data: {'id': 1, 'name': 'charmander'});
    debugPrint(response.data.toString());
  }
}
