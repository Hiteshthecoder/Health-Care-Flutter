import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helpers/Global.dart';
import '../../../shared/controllers/AppController.dart';
import '../model/onBoardingModel.dart';

class OnboardingController extends AppController {
  static OnboardingController get to => Get.find();
  final TextEditingController numberInput = TextEditingController();

  var onPageIndex = 0.obs;

  bool get isLastPage => onPageIndex.value == onBoardingPages.length - 1;
  var pageController = PageController();

  @override
  void onInit() async {
    if (await storage.read('onboarded') != null) {
      Get.offAllNamed('/dashboard');
      return;
    }
    super.onInit();
  }

  void forward() {
    if (isLastPage) {
      storage.write('onboarded', 'true');
      //go to Login
      Get.offAllNamed('/dashboard');
    } else {
      pageController.nextPage(duration: 30.milliseconds, curve: Curves.bounceOut);
    }
  }

  void skip() {
    storage.write('onboarded', 'true');
    Get.offAllNamed('/dashboard');
  }

  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
      imageAsset: 'assets/images/reports.png',
      heading: 'Organize medical reports',
      name: "It's the only app you'll need to keep track of all your doctor appointments and reports.",
    ),
    OnBoardingModel(
      imageAsset: 'assets/images/share.png',
      heading: 'Securely share reports',
      name: "Share your QR code with your doctor to share your medical reports and summary.",
    ),
    OnBoardingModel(
      imageAsset: 'assets/images/remander.png',
      heading: 'Reminders for follow-up',
      name: "Track your doctor's appointments easily so you don't miss them.",
    ),
  ];
}
