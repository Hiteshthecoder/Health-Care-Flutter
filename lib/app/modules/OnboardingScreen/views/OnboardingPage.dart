import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/Widgets.dart';
import '../controllers/OnboardingController.dart';

class OnboardingPage extends StatelessWidget {
  final _controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OnboardingController(),
      builder: (OnboardingController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : SafeArea(
                    child: Scaffold(
                        body: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            child: PageView.builder(
                                controller: _controller.pageController,
                                onPageChanged: _controller.onPageIndex,
                                itemCount: _controller.onBoardingPages.length,
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 150,
                                        ),
                                        Image.asset(
                                          _controller.onBoardingPages[index].imageAsset,
                                          height: 170,
                                          width: 170,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          _controller.onBoardingPages[index].heading,
                                          style: TextStyl.subtitle?.copyWith(color: kcBlack, fontSize: 25, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25),
                                          child: Text(
                                            _controller.onBoardingPages[index].name,
                                            style: TextStyl.bodySm?.copyWith(
                                              color: kcBlack.withOpacity(0.85),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 250,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                  _controller.onBoardingPages.length,
                                  (index) => Obx(() {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.all(10),
                                          height: 10,
                                          width: 10,
                                          decoration:
                                              BoxDecoration(color: _controller.onPageIndex.value == index ? Colors.black : kcdblue, borderRadius: BorderRadius.circular(10)),
                                        );
                                      })),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () => controller.skip(),
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          'Skip',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: _controller.forward,
                                  child: Obx(
                                    () {
                                      return Container(
                                        // width: 70,
                                        // decoration: BoxDecoration(
                                        //   border: Border.all(
                                        //       width: 3.0,
                                        //     color: kcMLightBlue,
                                        //   ),
                                        //   borderRadius: BorderRadius.all(
                                        //       Radius.circular(15) //                 <--- border radius here
                                        //   ),
                                        // ),

                                        child: Center(
                                          child: _controller.isLastPage
                                              ? Text('Done', style: TextStyle(fontSize: 18))
                                              : Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: 28,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                  );
      },
    );
  }
}
