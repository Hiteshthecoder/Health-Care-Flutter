import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/shared/views/widgets/LoadingWidget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/Config.dart';
import '../../../models/MyFamilyMemberModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../Subscribe/controllers/SubscribeController.dart';
import '../controllers/MenuController.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Get.size;
    final SubscribeController subscribeController =
        Get.put(SubscribeController());
    return GetBuilder(
        init: MenueController(),
        builder: (MenueController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      backgroundColor: kcWhite,
                      title: 'Menu',
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: spacer4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    HelperWidget(
                                      description:
                                          "Manage all your profile settings, family members, subscription here.",
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/contact.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              SizedBox(
                                width: spacer1,
                              ),
                            ],
                          ),
                        ),
                      ],
                      body: RefreshIndicator(
                        onRefresh: () async {
                          controller.getMemberData();
                          await auth.getUser();
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => controller.isMemberLoggedIn
                                    ? InkWell(
                                        onTap: () {
                                          controller.reLoginOldUser();
                                          auth.getUser();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kcWarning.withOpacity(0.15),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "You are logged in as Member. ",
                                                style: TextStyl.bodySm,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Re-login",
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: kcPrimary),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "as parent",
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Obx(
                                () => Container(
                                  height: screen.height * 0.18,
                                  width: screen.width,
                                  color: kcPrimary,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 25),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/editProfile');
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    '${auth.user.avatar}'),
                                                radius: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${auth.user.name}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: kcWhite,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  if (auth.user.isVerified !=
                                                      '0')
                                                    SvgPicture.asset(
                                                      'assets/icons/user_verify.svg',
                                                      color: kcWhite,
                                                      width: 13,
                                                    ),
                                                ],
                                              ),
                                              Text(
                                                "${auth.user.phone}",
                                                style: TextStyle(
                                                    color: kcWhite
                                                        .withOpacity(0.75),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 36),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(
                                                  () => Row(
                                                    children: [
                                                      if (!controller
                                                          .isMemberLoggedIn)
                                                        ...List.generate(
                                                            controller
                                                                .memberData
                                                                .length,
                                                            (index) {
                                                          MyFamilyMemberModel
                                                              memberList =
                                                              controller
                                                                      .memberData[
                                                                  index];
                                                          return Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              SizedBox(
                                                                width: spacer2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller.loginMemberUser(
                                                                      id: int.parse(memberList
                                                                          .userId
                                                                          .toString()));
                                                                  auth.getUser();
                                                                },
                                                                child: SizedBox(
                                                                  width: 45,
                                                                  child: Column(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundImage:
                                                                            NetworkImage('${memberList.user?.avatar}'),
                                                                        radius:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            spacer1,
                                                                      ),
                                                                      Text(
                                                                        '${memberList.user?.name}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                kcWhite,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                      SizedBox(
                                                        width: spacer2,
                                                      ),

                                                      //hide button when login with member
                                                      //if (!controller.isMemberLoggedIn || auth.user.id == subscribeController.subscribe.userId  )
                                                      // if (!controller.isMemberLoggedIn || auth.user.id == subscribeController.subscribe.userId || subscribeController.subscribe.subscriptionStatus == "Trial")
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (auth.user.id !=
                                                              controller
                                                                  .subscribeController
                                                                  .subscribe
                                                                  .userId)
                                                            Toastr.show(
                                                                message:
                                                                    "You can't perform this action as you are using shared package. Kindly unlink and purchase self subscription.");
                                                          //  Self Package User Loggin
                                                          // else if (controller.subscribeController.subscribe.subscriptionStatus == "Trial")
                                                          //   Toastr.show(
                                                          //       message:
                                                          //           "You are using trail package, You can't perform this action. For enabling you have to subscribe a package.");
                                                          else if (controller
                                                                  .subscribeController
                                                                  .subscribe
                                                                  .subscriptionStatus ==
                                                              "Expired")
                                                            Toastr.show(
                                                                message:
                                                                    "You package is expired, You can't perform this action. For enabling you have to subscribe a package.");
                                                          else if (int.parse(
                                                                  controller
                                                                      .memberData
                                                                      .length
                                                                      .toString()) >=
                                                              5)
                                                            Toastr.show(
                                                                message:
                                                                    "You can only share your package with 5 family members.");
                                                          else
                                                            Get.toNamed(
                                                                '/addMember');
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: spacer10,
                                                              height: spacer10,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  width: 1.0,
                                                                  color:
                                                                      kcWhite,
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20.0)),
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: kcWhite,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: spacer1,
                                                            ),
                                                            Text(
                                                              "Family Member",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color:
                                                                      kcWhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: spacer,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Obx(() => controller.isMemberLoggedIn &&
                                      !auth.user.isMember!
                                  ? Container(
                                      width: screen.width,
                                      //margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      color: kcGray.withOpacity(0.5),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "Enable Member to Login From Their Device",
                                              style: TextStyl.bodySm,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed("/activateMember");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: kcPrimary),
                                              child: Text(
                                                "Manage",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(color: kcWhite),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              //   child: Text("ABOUT",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: kcBlack.withOpacity(0.5)),),
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0.10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcOffWhite,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                'assets/icons/account.svg',
                                                color: kcBlack,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Basic Details ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Manage Your Account Details",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      kcBlack.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/editProfile');
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: kcBlack.withOpacity(0.05),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 0.75,
                                        margin: EdgeInsets.all(5),
                                        color: kcWhite,
                                        child: Container(
                                          width: screen.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${auth.user.name}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                Divider(),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Phone No.",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: kcBlack
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "${auth.user.phone}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 20,
                                                      color: kcBlack
                                                          .withOpacity(0.5),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0.10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcOffWhite,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                'assets/icons/profilesetup.svg',
                                                color: kcBlack,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Manage Sharing",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Manage Your Experience Details",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      kcBlack.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kcBlack.withOpacity(0.05),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 0.75,
                                      margin: EdgeInsets.all(5),
                                      color: kcWhite,
                                      child: Container(
                                        width: screen.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Shared Package Loggin
                                                  if (auth.user.id !=
                                                      controller
                                                          .subscribeController
                                                          .subscribe
                                                          .userId)
                                                    Toastr.show(
                                                        message:
                                                            "You can't perform this action as you are using shared package. Kindly unlink and purchase self subscription.");
                                                  // //  Self Package User Loggin
                                                  // // else if (controller.subscribeController.subscribe.subscriptionStatus == "Trial" ||
                                                  // //     controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                                  // //   Toastr.show(
                                                  // //       message:
                                                  // //           "You are using trail package, You cann't perform this action. For enabling you have to subscribe a package.");
                                                  // else if ( controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                                  //   Toastr.show(
                                                  //       message:
                                                  //           "You package is expired, You can't perform this action. For enabling you have to subscribe a package.");
                                                  else
                                                    Get.toNamed('/myfamily');
                                                  //   if (!controller.isMemberLoggedIn) Get.toNamed('/myfamily');
                                                },
                                                child: Container(
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "My Family Member",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 20,
                                                        color: kcBlack
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Divider(),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (auth.user.id !=
                                                      controller
                                                          .subscribeController
                                                          .subscribe
                                                          .userId)
                                                    Toastr.show(
                                                        message:
                                                            "You can't perform this action as you are using shared package. Kindly unlink and purchase self subscription.");
                                                  //  Self Package User Loggin
                                                  // else if (controller.subscribeController.subscribe.subscriptionStatus == "Trial" ||
                                                  //     controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                                  //   Toastr.show(
                                                  //       message:
                                                  //           "You are using trail package, You can't perform this action. For enabling you have to subscribe a package.");
                                                  else if (controller
                                                          .subscribeController
                                                          .subscribe
                                                          .subscriptionStatus ==
                                                      "Expired")
                                                    Toastr.show(
                                                        message:
                                                            "You package is expired, You can't perform this action. For enabling you have to subscribe a package.");
                                                  else if (int.parse(controller
                                                          .memberData.length
                                                          .toString()) >=
                                                      5)
                                                    Toastr.show(
                                                        message:
                                                            "You can only share your package with 5 family members.");
                                                  else
                                                    Get.toNamed('/addMember');
                                                },
                                                //if (!controller.isMemberLoggedIn) Get.toNamed('/addMember');

                                                child: Container(
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Add New Member",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 20,
                                                        color: kcBlack
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0.10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcOffWhite,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/bell.svg',
                                              color: kcBlack,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "My Plan",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Subscribe your plan",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      kcBlack.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        auth.getUser();
                                        subscribeController
                                            .getSubscriptionPlan();
                                        Get.toNamed("/subscribe");
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: kcBlack.withOpacity(0.05),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 0.75,
                                        margin: EdgeInsets.all(5),
                                        color: kcWhite,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Subsciption Details",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 20,
                                                    color: kcBlack
                                                        .withOpacity(0.5),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0.10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcOffWhite,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                'assets/icons/support.svg',
                                                color: kcBlack,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Get Support",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "We're here to help you",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      kcBlack.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kcBlack.withOpacity(0.05),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 0.75,
                                      margin: EdgeInsets.all(5),
                                      color: kcWhite,
                                      child: Container(
                                        width: screen.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  try {
                                                    launch(
                                                        "mailto:admin@healthdetails.in?subject=Issue HealthDetails Patient HDUID${auth.user.id} &body=Hello, \n I am facing issue while using Patient App \n \nRegards\n${auth.user.name}");
                                                  } catch (e, s) {
                                                    print(s);
                                                  }
                                                },
                                                child: Container(
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Get Support via Email",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 20,
                                                        color: kcBlack
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              if (!auth.user.subscription!
                                                      .isTrial() &&
                                                  !auth.user.subscription!
                                                      .isExpired())
                                                Divider(),
                                              if (!auth.user.subscription!
                                                      .isTrial() &&
                                                  !auth.user.subscription!
                                                      .isExpired())
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              if (!auth.user.subscription!
                                                      .isTrial() &&
                                                  !auth.user.subscription!
                                                      .isExpired())
                                                GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'tel:${Config.supportPhoneNumber}');
                                                  },
                                                  child: Container(
                                                    color: kcWhite,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Get Support via Call",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          size: 20,
                                                          color: kcBlack
                                                              .withOpacity(0.5),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0.10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcOffWhite,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                'assets/icons/shield-check.svg',
                                                color: kcBlack,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Legal",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Terms & Policy",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      kcBlack.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kcBlack.withOpacity(0.05),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 0.75,
                                      margin: EdgeInsets.all(5),
                                      color: kcWhite,
                                      child: Container(
                                        width: screen.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  launch(Config
                                                      .termsAndConditionUrl);
                                                },
                                                child: Container(
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Terms & Conditions",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 20,
                                                        color: kcBlack
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Divider(),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  launch(
                                                      Config.privacyPolicyUrl);
                                                },
                                                child: Container(
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Privacy Policy",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 20,
                                                        color: kcBlack
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  controller
                                                                      .deleteAccount();
                                                                },
                                                                child: Text(
                                                                    "Yes")),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    Text("No"))
                                                          ],
                                                          content: Text(
                                                              "Are you sure you want to delete your account?"),
                                                        );
                                                      }));
                                                },
                                                child: Container(
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Delete Account",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 20,
                                                        color: kcBlack
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: spacer5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "HDUID${auth.user.id} |",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: kcBlack.withOpacity(0.4),
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "App Version - 4.9 ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: kcBlack.withOpacity(0.4),
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: spacer5,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 170,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  kcDanger.withOpacity(0.75),
                                            ),
                                            onPressed: () {
                                              auth.logout();
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "LOGOUT",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/icons/logout.svg',
                                                  color: kcWhite,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ],
                                            ))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
        });
  }
}
