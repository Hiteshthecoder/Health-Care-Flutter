import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_mvc/app/shared/views/widgets/Widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../controllers/CreateCommunityController.dart';

class CreateCommunity extends StatelessWidget {
  const CreateCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CreateCommunityController(),
        builder: (CreateCommunityController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingIconWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Create Community",
                      leading: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back),
                          onTap: ()
                          {
                            controller.buttonEnabled ?
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                builder: (builder) {
                                  {
                                    return Container(
                                      height: MediaQuery.of(context).size.height * 0.20,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: spacer5, vertical: spacer2),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: spacer4),
                                                  child: Container(
                                                    height: 2.0,
                                                    width: screen.width * 0.10,
                                                    color: kcBlack.withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Are you sure to leave?",
                                                style: TextStyle(color: kcDarkAlt, fontSize: 18,fontWeight: FontWeight.w600),
                                              ),
                                              Divider(

                                              ),
                                              SizedBox(
                                                height: spacer5,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/trash.svg',
                                                    color: kcDanger.withOpacity(0.7),
                                                    width: 17, height: 17,
                                                  ),
                                                  SizedBox(
                                                    width: spacer2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                      Get.back();
                                                      controller.textInput.clear();
                                                    },
                                                    child: Text(
                                                      'Discard Post',
                                                      style: TextStyle(color: kcDanger, fontSize: 16),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: spacer15,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/icons/edit.svg',
                                                    color: kcBlack.withOpacity(0.6),
                                                    width: 17, height: 17,
                                                  ),
                                                  SizedBox(
                                                    width: spacer2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      'Continue Editing',
                                                      style: TextStyle(color: kcBlack, fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                })
                            :
                                Get.back();
                          },

                        ),
                      ),
                      actions: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Container(
                                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                                child: controller.buttonEnabled
                                    ? Button.danger(
                                        key: UniqueKey(),
                                        label: 'Post',
                                  onTap: (btn) async {
                                    btn.setBusy(true).setDisabled(true);
                                    await  controller.createPost();
                                    btn.setBusy(false).setDisabled(false);
                                  },
                                      )
                                    : Button.light(
                                        key: UniqueKey(),
                                        label: 'Post',
                                      )),

                          ),
                        ),
                      ],
                      titleSpacing: 0,
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage("${auth.user.avatar}"),
                                    radius: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 13),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: spacer2,
                                        ),
                                        Text(
                                          "${auth.user.name}",
                                          style: TextStyl.title?.copyWith(fontSize: 15, fontWeight: FontWeight.bold, color: kcBlack.withOpacity(0.7)),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2),
                                              child: SvgPicture.asset(
                                                'assets/icons/world.svg',
                                                width: 12,
                                                color: kcDarkAlt,
                                              ),
                                            ),
                                            SizedBox(
                                              width: spacer1,
                                            ),
                                            Text(
                                              "Sharing Publicly, Visible Post Approval ",
                                              style: TextStyl.title?.copyWith(fontSize: 12, color: kcDarkAlt, fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: spacer1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: spacer,
                              ),
                              FormInput.multiline(
                                controller: controller.textInput,
                                autoFocus: true,
                                action: TextInputAction.newline,
                                rows: 10,
                                maxLength: 1000,
                                placeholder: 'Write your thoughts...',
                              ),
                              SizedBox(
                                height: spacer,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
        });
  }
}
