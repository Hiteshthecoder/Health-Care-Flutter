import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/MyFamilyMemberModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../../Subscribe/controllers/SubscribeController.dart';
import '../controllers/MyFamilyController.dart';
final SubscribeController subscribeController = Get.put(SubscribeController());
class MyFamilyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MyFamilyController(),
        builder: (MyFamilyController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'My Family Member',
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
                                    Dialog(
                                      child: Container(
                                        width: 500,
                                        margin: EdgeInsets.only(left: 0.0, right: 0.0),
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                    "My Family Member",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: spacer2,
                                                  ),
                                                  Text(
                                                      "Here, you can add your family members, unlink your family member & login with your family member ")
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              right: 0.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: CircleAvatar(
                                                    radius: 14.0,
                                                    backgroundColor: Colors.white,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    barrierDismissible: false,
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
                      titleSpacing: 0,
                      body: RefreshIndicator(
                        onRefresh: () => controller.getMemberData(),
                        child: Obx(
                          () =>  Column(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            controller.memberData.length <= 0
                                                ? Center(
                                              child: NoDataWidget(
                                                message: "No Member found!",
                                                icon: SvgPicture.asset(
                                                  'assets/icons/profilesetup.svg',
                                                  width: spacer8,
                                                  color: kcDarkAlt,
                                                ),
                                              ),
                                            )
                                                :
                                                Column(
                                                  children: [
                                                    ...List.generate(
                                                      controller.memberData.length,
                                                          (index) {
                                                        MyFamilyMemberModel member = controller.memberData[index];
                                                        return Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage: NetworkImage('${member.user?.avatar}'),
                                                                radius: 20,
                                                              ),
                                                              SizedBox(
                                                                width: spacer3,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "${member.user?.name}",
                                                                    style:
                                                                    TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcBlack.withOpacity(0.6)),
                                                                  ),
                                                                  Text(
                                                                    "HSP${member.id}",
                                                                    style:
                                                                    TextStyl.body?.copyWith(fontWeight: FontWeight.w500, fontSize: 12, color: kcDarkAlt),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacer(),
                                                              Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                        context: context,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        builder: (builder) {
                                                                          {
                                                                            return Container(
                                                                              height: MediaQuery.of(context).size.height * 0.15,
                                                                              child: Container(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: spacer5, vertical: 2),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Center(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: spacer5),
                                                                                          child: Container(
                                                                                            height: 2.0,
                                                                                            width: screen.width * 0.10,
                                                                                            color: kcBlack.withOpacity(0.5),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      GestureDetector(

                                                                                        onTap: ()  {
                                                                                          // await subscribeController.unlinkSubscription(
                                                                                          //     id: int.parse(member.userId.toString()));
                                                                                          //
                                                                                          controller.deleteMember(id: member.userId!);

                                                                                        },
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SvgPicture.asset(
                                                                                              'assets/icons/trash.svg',
                                                                                              color: kcBlack.withOpacity(0.6),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: spacer4,
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Click to Unlink',
                                                                                                    style: TextStyl.body,
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Are you sure to unlink this user, After unlink"
                                                                                                        " user will not rollback",
                                                                                                    style: TextStyle(
                                                                                                        color: kcBlack.withOpacity(0.5), fontSize: 13),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        });
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(4),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        color: kcWhite,
                                                                        border: Border.all(color: kcPrimary)),
                                                                    child: Row(
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          'assets/icons/trash.svg',
                                                                          color: kcPrimary.withOpacity(0.6),
                                                                          height: 12,
                                                                          width: 12,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 3,
                                                                        ),
                                                                        Text(
                                                                          'Unlink',
                                                                          style: TextStyl.bodySm
                                                                              ?.copyWith(color: kcPrimary, fontSize: 12, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                        context: context,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        builder: (builder) {
                                                                          {
                                                                            return Container(
                                                                              height: MediaQuery.of(context).size.height * 0.15,
                                                                              child: Container(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: spacer5, vertical: 2),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Center(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: spacer5),
                                                                                          child: Container(
                                                                                            height: 2.0,
                                                                                            width: screen.width * 0.10,
                                                                                            color: kcBlack.withOpacity(0.5),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          //  controller.loginMember();
                                                                                          //Get.offAllNamed("/doctorProfile");
                                                                                          controller.menuController
                                                                                              .loginMemberUser(id: int.parse(member.userId.toString()));

                                                                                        },
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SvgPicture.asset(
                                                                                              'assets/icons/power.svg',
                                                                                              color: kcBlack.withOpacity(0.6),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: spacer3,
                                                                                            ),
                                                                                            Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  'Click to Login',
                                                                                                  style: TextStyle(color: kcBlack, fontSize: 18),
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                                Text(
                                                                                                  "Are you sure to login with this family member",
                                                                                                  style: TextStyle(
                                                                                                      color: kcBlack.withOpacity(0.5), fontSize: 14),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        });
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(4),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        color: kcWhite,
                                                                        border: Border.all(color: kcPrimary)),
                                                                    child: Row(
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          'assets/icons/power.svg',
                                                                          color: kcPrimary.withOpacity(0.6),
                                                                          height: 12,
                                                                          width: 12,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 3,
                                                                        ),
                                                                        Text(
                                                                          'Login',
                                                                          style: TextStyl.bodySm
                                                                              ?.copyWith(color: kcPrimary, fontSize: 12, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )

                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (auth.user.id != controller.subscribeController.subscribe.userId)
                                                Toastr.show(
                                                    message:
                                                    "You are using shared package, You cann't perform this action. For enabling you have to subscribe self package.");
                                              //  Self Package User Loggin
                                              // else if (controller.subscribeController.subscribe.subscriptionStatus == "Trial" ||
                                              //     controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                              //   Toastr.show(
                                              //       message:
                                              //           "You are using trail package, You cann't perform this action. For enabling you have to subscribe a package.");
                                              else if ( controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                                Toastr.show(
                                                    message:
                                                    "You package is expired, You can't perform this action. For enabling you have to subscribe a package.");
                                              else if (int.parse(controller.memberData.length.toString()) >= 5)
                                                Toastr.show(message: "You can only share your package with 5 family members.");
                                              else
                                                Get.toNamed('/addMember');
                                            },
                                            child: Container(
                                              height: screen.height * 0.05,
                                              decoration: BoxDecoration(
                                                  color: kcPrimary,
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                              width: screen.width,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Add New Member",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 14, color: kcWhite, fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (auth.user.id != controller.subscribeController.subscribe.userId)
                                                Toastr.show(
                                                    message:
                                                    "You are using shared package, You cann't perform this action. For enabling you have to subscribe self package.");
                                              //  Self Package User Loggin
                                              // else if (controller.subscribeController.subscribe.subscriptionStatus == "Trial" ||
                                              //     controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                              //   Toastr.show(
                                              //       message:
                                              //           "You are using trail package, You cann't perform this action. For enabling you have to subscribe a package.");
                                              else if ( controller.subscribeController.subscribe.subscriptionStatus == "Expired")
                                                Toastr.show(
                                                    message:
                                                    "You package is expired, You can't perform this action. For enabling you have to subscribe a package.");
                                              else
                                              Get.toNamed('/linkmember');},
                                            child: Container(
                                              height: screen.height * 0.05,
                                              width: screen.width,
                                              decoration: BoxDecoration(
                                                  color: kcPrimary,
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Link Family Member",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 14, color: kcWhite, fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Button.block(
                                    //   key: UniqueKey(),
                                    //   label: "Add New Member",
                                    //   flat: true,
                                    //   onTap: (btn) async {
                                    //     btn.setBusy(true).setDisabled(true);
                                    //     await Get.toNamed('/addMember');
                                    //     btn.setBusy(false).setDisabled(false);
                                    //   },
                                    // ),
                                    // GestureDetector(
                                    //
                                    //   onTap: ()  {
                                    //     Get.toNamed('/addMember');
                                    //   },
                                    //
                                    //   child: Container(
                                    //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    //     width: screen.width,
                                    //     height: screen.height * 0.07,
                                    //     decoration: BoxDecoration(
                                    //       color: kcPrimary,
                                    //     ),
                                    //     child: Text(
                                    //       "Add New Member",
                                    //       style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcWhite),
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                        ),
                      ));
        });
  }
}
