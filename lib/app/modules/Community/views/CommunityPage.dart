import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/CommunityPostModel.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/CommunityController.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CommunityController(),
        builder: (CommunityController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Community",
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
                              //         title: 'Community',
                              //         description:
                              //             "Here you can create your post, like on post & comment on post. After creating your post, your post will under approval, Once your post will approve then you can see your post & delete your post. On comment section you can see your posted comment & also delete your comment",
                              //       ),
                              //     );
                              //   },
                              //   child: SvgPicture.asset(
                              //     'assets/icons/contact.svg',
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
                      titleSpacing: 0,
                      body: RefreshIndicator(
                        onRefresh: () => controller.getPostData(immediate: true),
                        child: Column(
                          children: [
                            Expanded(
                              child: Obx(
                                () => SingleChildScrollView(
                                  controller: controller.scrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Get.toNamed('/createcommunity'),
                                          child: Container(
                                            padding: EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1.0,
                                                color: kcLightGray,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                                  ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage('${auth.user.avatar}'),
                                                  radius: 15,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: Text(
                                                    "Write your thoughts...",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 18, color: kcDarkAlt),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: spacer2,
                                        ),
                                        Obx(
                                          () => controller.postData.length <= 0
                                              ? Center(
                                                  child: NoDataWidget(
                                                    message: "No Post Yet!",
                                                    icon: SvgPicture.asset(
                                                      'assets/images/calendar-clock.svg',
                                                      width: spacer8,
                                                      color: kcDarkAlt,
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    ...List.generate(
                                                      controller.postData.length,
                                                      (index) {
                                                        CommunityPostModel community = controller.postData[index];
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(13),
                                                                width: screen.width,
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(Radius.circular(8.0) //                 <--- border radius here
                                                                          ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.grey.withOpacity(0.5),
                                                                      blurRadius: 2.0,
                                                                    ),
                                                                  ],
                                                                  color: kcWhite,
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundImage: NetworkImage('${community.user?.avatar}'),
                                                                          radius: 20,
                                                                        ),
                                                                        SizedBox(
                                                                          width: spacer3,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "${community.user?.name}",
                                                                              style: TextStyl.body?.copyWith(
                                                                                  fontWeight: FontWeight.bold, color: kcBlack.withOpacity(0.7)),
                                                                            ),
                                                                            Text(
                                                                              "${Jiffy(community.createdAt).format("dd MMM, yyyy  h:mm")}",
                                                                              style: TextStyl.body?.copyWith(
                                                                                  fontWeight: FontWeight.w500, fontSize: 13, color: kcDarkAlt),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Spacer(),
                                                                        Obx(() => community.user?.id.toString() == '${auth.user.id}'
                                                                            ? Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    showModalBottomSheet(
                                                                                        context: context,
                                                                                        shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                        builder: (builder) {
                                                                                          {
                                                                                            return Container(
                                                                                              height: MediaQuery.of(context).size.height * 0.15,
                                                                                              child: Container(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(
                                                                                                      horizontal: spacer5, vertical: spacer3),
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Center(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.symmetric(
                                                                                                              horizontal: 10.0, vertical: spacer5),
                                                                                                          child: Container(
                                                                                                            height: 2.0,
                                                                                                            width: screen.width * 0.10,
                                                                                                            color: kcBlack.withOpacity(0.5),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          SvgPicture.asset(
                                                                                                            'assets/icons/trash.svg',
                                                                                                            color: kcBlack.withOpacity(0.6),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            width: spacer4,
                                                                                                          ),
                                                                                                          GestureDetector(
                                                                                                            onTap: () => controller.deletePost(
                                                                                                                id: community.id!),
                                                                                                            child: Column(
                                                                                                              crossAxisAlignment:
                                                                                                                  CrossAxisAlignment.start,
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
                                                                                                    ],
                                                                                                  ),
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
                                                                    Divider(),
                                                                    Text(
                                                                      "${community.description}",
                                                                      style: TextStyl.body?.copyWith(fontSize: 18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: spacer,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            Get.toNamed(
                                                                              '/respectscommunity',
                                                                              parameters: {"like_Id": community.id.toString()},
                                                                            );
                                                                          },
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                "${community.likeCount}",
                                                                                style: TextStyl.bodySm
                                                                                    ?.copyWith(color: kcDarkAlt, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              SizedBox(
                                                                                width: spacer1,
                                                                              ),
                                                                              community.likeCount == 0
                                                                                  ? Text(
                                                                                      'Respect',
                                                                                      style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                                                                                    )
                                                                                  : Text(
                                                                                      'Respects',
                                                                                      style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                                                                                    )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: spacer1,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            Get.toNamed('/commentsCommunity',
                                                                                parameters: {"post_id": community.id.toString()});
                                                                          },
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                "${community.commentCount}",
                                                                                style: TextStyl.bodySm
                                                                                    ?.copyWith(color: kcDarkAlt, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              SizedBox(
                                                                                width: spacer1,
                                                                              ),
                                                                              community.commentCount == 0
                                                                                  ? Text(
                                                                                      'Comment',
                                                                                      style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                                                                                    )
                                                                                  : Text(
                                                                                      'Comments',
                                                                                      style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                                                                                    )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    Divider(),
                                                                    //comment post
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(5.0),
                                                                      child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          GestureDetector(
                                                                            child: community.isLike!
                                                                                ? SvgPicture.asset(
                                                                                    'assets/icons/thumbs-up.svg',
                                                                                    color: kcPrimary,
                                                                                    width: 23,
                                                                                  )
                                                                                : SvgPicture.asset(
                                                                                    'assets/icons/social-network.svg',
                                                                                    color: kcPrimary,
                                                                                    width: 23,
                                                                                  ),
                                                                            //create like
                                                                            onTap: () => controller.createRespect(
                                                                                id: int.parse(community.id.toString()), index: index),
                                                                          ),
                                                                          SizedBox(
                                                                            width: spacer1,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 3),
                                                                            child: Text(
                                                                              'Respect',
                                                                              style: TextStyl.bodySm?.copyWith(
                                                                                  color: kcDarkAlt, fontWeight: FontWeight.w700, fontSize: 15),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: spacer,
                                                                          ),
                                                                          SvgPicture.asset(
                                                                            'assets/icons/comment.svg',
                                                                            color: kcPrimary,
                                                                            width: 23,
                                                                          ),
                                                                          SizedBox(
                                                                            width: spacer1,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              Get.toNamed('/commentsCommunity',
                                                                                  parameters: {"post_id": community.id.toString()});
                                                                            },
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 3),
                                                                              child: Text(
                                                                                'Comment',
                                                                                style: TextStyl.bodySm?.copyWith(
                                                                                    color: kcDarkAlt, fontWeight: FontWeight.w700, fontSize: 15),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => controller.loadingMore
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: kcWhite,
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      alignment: Alignment.center,
                                      child: LoadingIcon(),
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
        });
  }
}
