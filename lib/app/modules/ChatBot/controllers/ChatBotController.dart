import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/ApiResponse.dart';
import 'package:flutter_mvc/app/models/message.dart';
import 'package:flutter_mvc/app/modules/ChatBot/services/ChatBotService.dart';
import 'package:flutter_mvc/app/shared/controllers/AppController.dart';
import 'package:get/get.dart';

class ChatBotController extends AppController {
  var messages = <message>[].obs;
  ChatBotController(){
    chatHistory();
  }
  var requested = false.obs;
  ChatBotService c = ChatBotService();
  TextEditingController t = TextEditingController();
  void chatHistory() async {
    requested.value = true;
    ApiResponse result = await c.chatHistory();
    messages = RxList<message>(result.data);
    requested.value = false;
  }

  void chatPost(String msg) async{
    requested.value = true;
    ApiResponse result = await c.chatPost(msg);
    messages = RxList<message>(result.data);
    requested.value = false;
  }
}
