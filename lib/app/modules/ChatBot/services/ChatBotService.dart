import 'dart:convert';

import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/models/ApiResponse.dart';
import 'package:flutter_mvc/app/models/message.dart';
import 'package:flutter_mvc/config/Config.dart';
import 'package:http/http.dart' as http;

class ChatBotService {
  var headers = {
    // 'Content-Type': 'application/form-data',
    "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMTVkYjQ1ODllODUwZTE3ZGJiMDhjNWY0OTU4NTU4MzAwMjAwY2E4NDY5NTNjZDM3MDk1ZDk2ZjY4MTI2ODhhNzM4OWQ1N2Y1NTI2NGZiN2QiLCJpYXQiOjE3MTg3OTM0OTkuNzA5NTU2LCJuYmYiOjE3MTg3OTM0OTkuNzA5NTYxLCJleHAiOjE3NTAzMjk0OTkuNjgxNzg3LCJzdWIiOiI1NTMiLCJzY29wZXMiOltdfQ.RT3CM9jay65SmO-L-OQtTCcbLcG5RV9VZrpgU1MFVZaiPELGTv-K7yF_T5gnFJKH2kmrY_RPN6EPEkSBkwmGF6pJZCtd4L8oojRwk1Y-FT3Qf2D8G3qepVUu5bcc_l_nG549_KrGtMRim_weXyXda_t6fL0ZGQnpjrcdkS8-fplIx1ARujcfxyNLM4qh5rbhee8Wr5EbtZV8oW_iLcyl9E5S8__OEBXDWa-0USeHGCMEITVod4SIx52nVeCmWyjFJOmmOlGUccV10_FOW7b0QW5mbiV4dZBK8xIt5KtpzFKA_Nkg3koqgoc0TVEvhCLzNGN1sHaM-SaFfdFaL-Bp6Qv231kz6oeTz2xfMW3D0N1zWVdg-MzaTxQTqlhT4rUv2YTnk8evHyv7YAXv1W82V27h-_D8KsrUf9c84t6VjVUXsCQHFe3YuN79QpTH3o2c-ql5xRtj6coEA80JrwMxIBX0w4VS9DloWzyucNgrkExtcmqYjjFIicC9FNFaAN-qDMogCKW6wT0mz9hQ4NlSnETn46-dezZroTU3ffr1upyFNRcoZrksRY8ou3KG2hs0IjTBPWUwtI0ORWuhJl6iXh28JhYuk0WKYt2jcdbf8o3pXv-SNtlYLBsTRKnnWpmU2LRqbdtd3jkZ1N8zoTV1HgF9_iVjfv7_aXY1qpieN1U"
  };
  int user_id = 553; //storage.changes['user']['id']; // storage->old_user
  Future<ApiResponse> chatHistory() async {
    var response = await http.get(
        Uri.parse("${Config.apiBaseUrl}/patient/chat_history"),
        headers: headers);
    Map<String, dynamic> result = jsonDecode(response.body);
    // print(result);
    List<message> l = List.generate(result['data'].length, ((index) {
      return message.fromJson(result['data'][index]);
    }));
    l = l.where((element) => element.user_id == user_id).toList();
    return ApiResponse(status: "0", message: "", validationError: "", data: l);
  }

  Future<ApiResponse> chatPost(String msg) async {
    var response = await http.post(
        Uri.parse("${Config.apiBaseUrl}/patient/chat_post"),
        headers: headers,
        body: {"query": msg});
    Map<String, dynamic> result = jsonDecode(response.body);
    // print(result);
    List<message> l = List.generate(result['data'].length, ((index) {
      return message.fromJson(result['data'][index]);
    }));
    l = l.where((element) => element.user_id == user_id).toList();
    // print(l);
    return ApiResponse(status: "0", message: "", validationError: "", data: l);
  }
}
