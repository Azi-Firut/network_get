import 'dart:developer';
import 'package:flutter/material.dart';

import 'data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<ChuckJoke> getJokeFromUrl() async {
  var url = Uri.https('api.chucknorris.io', '/jokes/random');
  var response = await http.get(url, headers: {'accept': 'application/json'});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    log("statusCode == 200");
    return ChuckJoke(
        icon_url: jsonResponse['icon_url'],
        joke: jsonResponse['value'],
        id: jsonResponse['id'],
        url: jsonResponse['url']);
  } else {
    print('Request fail ${response.statusCode}.');
    const CircularProgressIndicator();
    log("FAIL");
    return ChuckJoke(icon_url: '', joke: '', id: '', url: '');
  }
}
