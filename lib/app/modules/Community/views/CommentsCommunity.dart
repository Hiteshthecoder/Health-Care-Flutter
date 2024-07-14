import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/models/CommentsModel.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/CommentsCommunityController.dart';

class CommentsCommunity extends StatelessWidget {
  const CommentsCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CommentsCommunityController(),
        builder: (CommentsCommunityController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Comments",
                      titleSpacing: 0,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: spacer4,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.dialog(
                              //       HelperWidget(
                              //         title: 'Title here',
                              //         description:
                              //             "A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients.",
                              //       ),
                              //     );
                              //   },
                              //   child: SvgPicture.asset(
                              //     'assets/icons/contact.svg',
                              //     color: kcWhite,
                              //     height: 20,
                              //     width: 20,
                              //   ),
                              // ),
                              SizedBox(
                                width: spacer1,
                              ),
                            ],
                          ),
                        ),
                      ],
                      body: RefreshIndicator(
                        onRefresh: () => controller.getPostCommentData(),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Obx(
                                  () => controller.commentData.length <= 0
                                      ? Center(
                                          child: NoDataWidget(
                                            message: "No Comment found!",
                                            icon: SvgPicture.asset(
                                              'assets/icons/comment.svg',
                                              width: spacer8,
                                              color: kcDarkAlt,
                                            ),
                                          ),
                                        )
                                      : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                        child: Column(
                                            children: [
                                              ...List.generate(
                                                controller.commentData.length,
                                                (index) {
                                                  CommentsModel comments = controller.commentData[index];

                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage('${comments.user?.avatar}'),
                                                            radius: 15,
                                                          ),
                                                          SizedBox(
                                                            width: spacer3,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${comments.user?.name}",
                                                                style: TextStyl.body?.copyWith(
                                                                    fontSize: 15, fontWeight: FontWeight.bold, color: kcBlack.withOpacity(0.7)),
                                                              ),
                                                              Text(
                                                                '${Jiffy(comments.createdAt).format("yyyy-MM-dd , hh:mm")}',
                                                                style: TextStyl.body
                                                                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 10, color: kcDarkAlt),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Obx(() => comments.user?.id.toString() == '${auth.user.id}'
                                                              ? Padding(
                                                                  padding: const EdgeInsets.all(10.0),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      showModalBottomSheet(
                                                                          context: context,
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                          builder: (builder) {
                                                                            {
                                                                              return Container(
                                                                                height: MediaQuery.of(context).size.height * 0.12,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                      horizontal: spacer5, vertical: 20),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                        child: SvgPicture.asset(
                                                                                          'assets/icons/trash.svg',
                                                                                          color: kcBlack.withOpacity(0.6),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: spacer4,
                                                                                      ),
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          controller.deleteComment(
                                                                                            id: int.parse(comments.id.toString()));},
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              'Delete',
                                                                                              style: TextStyl.body,
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                            Text(
                                                                                              "This action cannot be reversed",
                                                                                              style: TextStyle(
                                                                                                  color: kcBlack.withOpacity(0.5)),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                          });
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                      'assets/icons/menu-dots-vertical.svg',
                                                                      width: 15,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Text(''))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: spacer1,
                                                      ),
                                                      SizedBox(
                                                        width: screen.width,
                                                        child: Text(
                                                          "${comments.comment}",
                                                          style: TextStyl.bodySm?.copyWith(
                                                              fontSize: 18, fontWeight: FontWeight.w500, color: kcBlack.withOpacity(0.7)),
                                                          overflow: TextOverflow.ellipsis,
                                                          textDirection: TextDirection.ltr,
                                                          maxLines: 100,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: spacer,
                                                      ),
                                                      Divider(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                      ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: kcWhite,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FormInput.multiline(
                                        controller: controller.thoughtsInput,
                                        placeholder: "Type comment here",
                                        autoFocus: true,
                                        rows: 1,
                                      ),
                                    ),
                              controller.buttonEnabled
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.createComment();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child:  Icon(
                                                  Icons.send,
                                                  size: 30,
                                                  color: kcPrimary,
                                                )
                                               ),
                                    )  : Container(
                                        padding: EdgeInsets.all(10),
                                        child:  Icon(
                                          Icons.send,
                                          size: 30,
                                          color: kcLightGray,
                                        )
                                    )

                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
        });
  }
}
