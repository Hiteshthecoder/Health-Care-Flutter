import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/models/message.dart';
import 'package:flutter_mvc/app/modules/ChatBot/controllers/ChatBotController.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => ChatBotPageState();
}

class ChatBotPageState extends State<ChatBotPage> {
  @override
  Widget build(BuildContext context) {
    double w = screen.width, h = screen.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // bottomSheet: questionWidget(w, h),

        body: GetBuilder(
            init: ChatBotController(),
            builder: (ChatBotController controller) {
              return Stack(
                children: [
                  Opacity(
                    opacity: 0.25,
                    child: Image.asset("assets/images/chatbotBg2.jpg",
                        width: w, height: h, fit: BoxFit.fill),
                  ),
                  Opacity(
                      opacity: 0.1,
                      child: Container(width: w, height: h, color: kcBlue)),
                  Container(
                      margin: EdgeInsets.only(left: w * 0.05),
                      width: w * 0.9,
                      height: h,
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...l(w, h, controller.messages),
                              (controller.requested.value == true)
                                  ? Container(
                                      width: w / 100 * 20,
                                      // decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: kcBlue),
                                      margin:
                                          EdgeInsets.only(bottom: h / 100 * 2),
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                              color: kcBlue,
                                              size: w / 100 * 15),
                                    )
                                  : questionWidget(
                                      w, h, controller.messages, controller),
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom))
                            ],
                          ),
                        )
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     ...l(w, h, state.messages),
                        //     questionWidget(w, h, state.messages, context),
                        //     Padding(padding: EdgeInsets.only(bottom: x))
                        //   ],
                        // )

                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     ...l(w, h, state.messages),
                        //     questionWidget(w, h, state.messages, context),
                        //     Padding(padding: EdgeInsets.only(bottom: x))
                        //   ],
                        // );
                        ,
                      ))
                ],
              );
            }));
  }

  List<Widget> l(double w, double h, List<message> msgs) {
    return List.generate(msgs.length, (index) {
      double br;
      if (msgs[index].msg.length < 30) {
        br = w / 100 * 5;
      } else {
        br = w / 100 * 10;
      }
      return Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: (index > 0) ? h / 100 * 2 : h / 100 * 5),
            width: w * 0.9,
            alignment: (msgs[index].type == 'User')
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
                constraints: BoxConstraints(maxWidth: w * 0.8),
                // alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: w / 100 * 3, vertical: h / 100 * 2),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(70, 0, 0, 0),
                          blurRadius: 1,
                          spreadRadius: 2)
                    ],
                    color: (msgs[index].type == 'User') ? kcBlue : kcWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(br),
                        topRight: Radius.circular(br),
                        bottomLeft: (msgs[index].type == 'User')
                            ? Radius.circular(br)
                            : const Radius.circular(0),
                        bottomRight: (msgs[index].type == 'AI')
                            ? Radius.circular(br)
                            : const Radius.circular(0))),
                child: Text('${msgs[index].msg}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: w / 100 * 4,
                      color: (msgs[index].type == 'User') ? kcWhite : kcBlack,
                      // fw: FontWeight.bold
                    ))),
          ),
          Container(
              width: w * 0.9,
              alignment: (msgs[index].type == "User")
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(msgs[index].created_at,
                  style: TextStyle(
                      color: kcBlack, fontSize: screen.width / 100 * 3)))
        ],
      );
    });
  }

  Widget questionWidget(
      double w, double h, List<message> l, ChatBotController controller) {
    return Container(
      margin: EdgeInsets.only(top: h / 100 * 3, bottom: h / 100 * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: w * 0.7,
            height: h * 0.08,
            alignment: Alignment.center,
            color: kcWhite,
            child: AutoSizeTextField(
                controller: controller.t,
                cursorColor: kcBlue,
                // selectionControls: ,
                style: TextStyle(fontSize: w / 100 * 4, color: kcBlack),
                decoration: InputDecoration(
                    fillColor: kcWhite,
                    hoverColor: kcWhite,
                    focusColor: kcWhite,
                    hintText: "Ask Anything...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w / 100 * 10),
                        borderSide: BorderSide.none))),
          ),
          FloatingActionButton(
              backgroundColor: kcBlue,
              hoverColor: kcBlack,
              splashColor: kcBlue,
              onPressed: () {
                controller.chatPost(controller.t.text);
                // context.read<chatbotCubit>().sendMessage(l, t.text);
                controller.t.clear();
              },
              child:
                  Icon(Icons.send_rounded, color: kcWhite, size: w / 100 * 6))
        ],
      ),
    );
  }
}
