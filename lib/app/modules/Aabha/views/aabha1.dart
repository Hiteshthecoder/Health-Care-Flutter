import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:ui_x/ui_x.dart';

class aabha1 extends StatefulWidget {
  const aabha1({super.key});

  @override
  State<aabha1> createState() => _aabha1State();
}

class _aabha1State extends State<aabha1> {
  @override
  Widget build(BuildContext context) {
    double w = screen.width, h = screen.height;
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFF),
        body: Container(
            width: w,
            height: h,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                    margin: EdgeInsets.only(top: h / 100 * 5),
                    child: Image.asset("assets/newImages/aabha_card.png",
                        width: w * 0.8, height: h * 0.2, fit: BoxFit.contain),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: h / 100 * 0.8),
                      child: Text("Create Your ABHA (Health ID)",
                          style: TextStyle(
                              fontSize: w / 100 * 4,
                              fontWeight: FontWeight.w600))),
                  Container(
                    margin: EdgeInsets.only(top: h / 100 * 1.5),
                    child: Stack(children: [
                      Container(width: w * 0.9, height: h * 0.2),
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: w * 0.9,
                                height: h * 0.16,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kcGray, width: 1),
                                    borderRadius:
                                        BorderRadius.circular(w / 100 * 3)),
                                padding: EdgeInsets.only(
                                    // right: w / 100 * 2,
                                    // left: w / 100 * 2,
                                    // bottom: h / 100 * 1,
                                    top: h / 100 * 2.5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: w * 0.9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w / 100 * 5),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/newImages/aadhaar_logo.png",
                                                    width: w / 100 * 8,
                                                    // height: h / 100 * 8,
                                                    fit: BoxFit.contain),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: w / 100 * 2),
                                                    child: Text(
                                                      "Using Aadhaar Number",
                                                      style: TextStyle(
                                                          fontSize:
                                                              w / 100 * 3.2,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h / 100 * 0.8,
                                                  horizontal: w / 100 * 5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF6666FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          w / 100 * 2)),
                                              child: Text("Create",
                                                  style: TextStyle(
                                                      color: kcWhite,
                                                      fontSize: w / 100 * 3.5,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            )
                                          ]),
                                    ),
                                    Container(
                                        width: w,
                                        padding: EdgeInsets.symmetric(
                                            vertical: h / 100 * 1),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    w / 100 * 3),
                                                bottomRight: Radius.circular(
                                                    w / 100 * 3))),
                                        child: Row(children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: w / 100 * 3),
                                            child: Text("You get",
                                                style: TextStyle(
                                                  color: kcBlack,
                                                  fontSize: w / 100 * 3,
                                                )),
                                          ),
                                          Container(
                                              // width: w / 100 * 10,
                                              padding:
                                                  EdgeInsets.all(w / 100 * 0.8),
                                              margin: EdgeInsets.only(
                                                  left: w / 100 * 2),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF3DAE07),
                                                  shape: BoxShape.circle),
                                              child: Icon(Icons.done,
                                                  size: w / 100 * 3,
                                                  color: kcWhite)),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: w / 100 * 1.2),
                                            child: Text("ABHA Number",
                                                style: TextStyle(
                                                  color: kcBlack,
                                                  fontSize: w / 100 * 3,
                                                )),
                                          ),
                                          Container(
                                              // width: w / 100 * 10,
                                              padding:
                                                  EdgeInsets.all(w / 100 * 0.8),
                                              margin: EdgeInsets.only(
                                                  left: w / 100 * 2),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF3DAE07),
                                                  shape: BoxShape.circle),
                                              child: Icon(Icons.done,
                                                  size: w / 100 * 3,
                                                  color: kcWhite)),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: w / 100 * 1.2),
                                            child: Text("ABHA Address",
                                                style: TextStyle(
                                                  color: kcBlack,
                                                  fontSize: w / 100 * 3,
                                                )),
                                          )
                                        ])),
                                  ],
                                ))),
                      ),
                      Positioned(
                          // top: h / 100 * 1,
                          left: w / 100 * 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: h / 100 * 1, horizontal: w / 100 * 3),
                            decoration: BoxDecoration(
                                color: Color(0xFF7ABD5E),
                                borderRadius:
                                    BorderRadius.circular(w / 100 * 2)),
                            child: Text("Recommended",
                                style: TextStyle(
                                    color: kcWhite,
                                    fontSize: w / 100 * 3,
                                    fontWeight: FontWeight.w600)),
                          ))
                    ]),
                  ),
                  Container(
                      width: w * 0.9,
                      height: h * 0.16,
                      decoration: BoxDecoration(
                          border: Border.all(color: kcGray, width: 1),
                          borderRadius: BorderRadius.circular(w / 100 * 3)),
                      padding: EdgeInsets.only(
                          // right: w / 100 * 2,
                          // left: w / 100 * 2,
                          // bottom: h / 100 * 1,
                          top: h / 100 * 2.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: w * 0.9,
                            padding:
                                EdgeInsets.symmetric(horizontal: w / 100 * 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                          "assets/newImages/aabha_phone.png",
                                          width: w / 100 * 8,
                                          // height: h / 100 * 8,
                                          fit: BoxFit.contain),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: w / 100 * 4),
                                          child: Text(
                                            "Using Phone",
                                            style: TextStyle(
                                                fontSize: w / 100 * 3.2,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: h / 100 * 0.8,
                                        horizontal: w / 100 * 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF6666FF),
                                        borderRadius:
                                            BorderRadius.circular(w / 100 * 2)),
                                    child: Text("Create",
                                        style: TextStyle(
                                            color: kcWhite,
                                            fontSize: w / 100 * 3.5,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ]),
                          ),
                          Container(
                              width: w,
                              padding:
                                  EdgeInsets.symmetric(vertical: h / 100 * 1),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF4F4F4),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(w / 100 * 3),
                                      bottomRight:
                                          Radius.circular(w / 100 * 3))),
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(left: w / 100 * 3),
                                  child: Text("You get",
                                      style: TextStyle(
                                        color: kcBlack,
                                        fontSize: w / 100 * 3,
                                      )),
                                ),
                                Container(
                                    // width: w / 100 * 10,
                                    padding: EdgeInsets.all(w / 100 * 0.8),
                                    margin: EdgeInsets.only(left: w / 100 * 2),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3DAE07),
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.done,
                                        size: w / 100 * 3, color: kcWhite)),
                                Container(
                                  margin: EdgeInsets.only(left: w / 100 * 1.2),
                                  child: Text("ABHA Address",
                                      style: TextStyle(
                                        color: kcBlack,
                                        fontSize: w / 100 * 3,
                                      )),
                                )
                              ])),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: h / 100 * 2),
                      child: Text.rich(TextSpan(
                          text: "Already have ABHA Address?",
                          style: TextStyle(fontSize: w / 100 * 3),
                          children: [
                            TextSpan(
                                text: " Login Now",
                                style: TextStyle(
                                    fontSize: w / 100 * 3,
                                    color: Color(0xFF6666FF)))
                          ]))),
                  // Container(
                  //     margin: EdgeInsets.only(top: h / 100 * 2.5, bottom: 0),
                  //     child: Divider(color: kcGray)),
                  Container(
                      margin: EdgeInsets.only(top: h / 100 * 2.5),
                      decoration: BoxDecoration(
                          color: kcWhite,
                          border:
                              Border(top: BorderSide(color: kcGray, width: 1))),
                      width: w,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: h / 100 * 2.5),
                              child: Text(
                                "What is ABHA?",
                                style: TextStyle(
                                    fontSize: w / 100 * 4,
                                    fontWeight: FontWeight.w600),
                              )),
                          Container(
                              width: w * 0.9,
                              margin: EdgeInsets.only(top: h / 100 * 1),
                              child: Text(
                                "ABHA ( Ayushman Bharat Health Account) is your digital health account. You will receive a special ABHA number and address after creating ABHA, which you may use to save and access your medical information",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: w / 100 * 3.3),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: h / 100 * 2),
                              width: w * 0.1,
                              child: Divider(color: kcGray, thickness: 1)),
                          Container(
                              margin: EdgeInsets.only(top: h / 100 * 2),
                              child: Text("You can use ABHA ID to",
                                  style: TextStyle(fontSize: w / 100 * 4))),
                          Container(
                              margin: EdgeInsets.only(top: h / 100 * 1),
                              width: w * 0.9,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: w * 0.25,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsets.all(w / 100 * 4),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFD7D7FF),
                                                    shape: BoxShape.circle),
                                                child: Image.asset(
                                                    "assets/newImages/book_shelf.png",
                                                    width: w / 100 * 8,
                                                    height: h / 100 * 4,
                                                    fit: BoxFit.fill)),
                                            Text(
                                                "Store Medical records digitally",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: w / 100 * 3))
                                          ]),
                                    ),
                                    SizedBox(
                                      width: w * 0.25,
                                      child: Column(children: [
                                        Container(
                                            padding:
                                                EdgeInsets.all(w / 100 * 4),
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD7D7FF),
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                                "assets/newImages/profile.png",
                                                width: w / 100 * 8,
                                                height: h / 100 * 4,
                                                fit: BoxFit.fill)),
                                        Text("Book Hospital Appointments",
                                            style: TextStyle(
                                                fontSize: w / 100 * 3))
                                      ]),
                                    ),
                                    SizedBox(
                                      width: w * 0.25,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsets.all(w / 100 * 4),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFD7D7FF),
                                                    shape: BoxShape.circle),
                                                child: Image.asset(
                                                    "assets/newImages/share.png",
                                                    width: w / 100 * 8,
                                                    height: h / 100 * 4,
                                                    fit: BoxFit.fill)),
                                            Text("Share Health data securely",
                                                style: TextStyle(
                                                    fontSize: w / 100 * 3))
                                          ]),
                                    )
                                  ])),
                          SizedBox(width: w, height: h * 0.2)
                        ],
                      )),
                ]))));
  }
}
