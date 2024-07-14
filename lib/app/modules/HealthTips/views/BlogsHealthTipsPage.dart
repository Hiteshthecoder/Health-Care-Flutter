import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/BlogsHealthTipsController.dart';

class BlogsHealthTipsPage extends StatelessWidget {
  const BlogsHealthTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BlogsHealthTipsController(),
        builder: (BlogsHealthTipsController controller) {
          if (!controller.isConnected) {
            return NotConnectedErrorPage();
          } else {
            return controller.isBusy
                ? LoadingWidget(message: "Please wait...")
                : MasterLayout(
                    title: "Read",
                    actions: [],
                    titleSpacing: 0,
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(13),
                                      width: screen.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0) //                 <--- border radius here
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
                                              // Container(
                                              //   width: 18,
                                              //   height: 18,
                                              //   child: controller.blogsDetail.category?.icon != null ? Image.network(
                                              //     '${controller.blogsDetail.category?.icon}',
                                              //     width: screen.width * 0.08,
                                              //   ) : Text('')
                                              // ),
                                              // Image.network('${controller.blogsDetail.user?.avatar}',width: screen.width*0.08,),

                                              // SizedBox(
                                              //   width: spacer3,
                                              // ),
                                              Text(
                                                "${controller.blogsDetail.category?.name}",
                                                style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcBlack.withOpacity(0.7)),
                                              ),
                                              Spacer(),
                                              Text(
                                                '${Jiffy(controller.blogsDetail.createdAt).format('MMMM do yy, h:mm')}',
                                                style: TextStyl.body?.copyWith(fontWeight: FontWeight.w500, fontSize: 13, color: kcDarkAlt),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: spacer4,
                                          ),
                                          ClipRRect(
                                              // borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                            '${controller.blogsDetail.descriptionBanner}',
                                            width: screen.width,
                                            height: screen.height * 0.25,
                                          )),
                                          SizedBox(
                                            height: spacer4,
                                          ),
                                          Text(
                                            "${controller.blogsDetail.title}",
                                            style: TextStyl.subtitle?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: kcBlack.withOpacity(0.7),
                                            ),
                                          ),
                                          SizedBox(
                                            height: spacer1,
                                          ),
                                          Text(
                                            "${(controller.blogsDetail.description)?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '')}",
                                            style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcDarkAlt),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
          }
        });
  }
}
