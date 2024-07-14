import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:ui_x/helpers/Toastr.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/MySubscriptionModel.dart';
import '../../../models/SubscriptionModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../../Dashboard/controllers/DashboardController.dart';
import '../services/SubscriptionService.dart';

class SubscribeController extends AppController {
  static SubscribeController get instance {
    if (!Get.isRegistered<SubscribeController>()) Get.put(SubscribeController());
    return Get.find<SubscribeController>();
  }

  final DashboardController dashboardController = DashboardController.instance;

  /// Observables
  var _subscribePlan = <SubscriptionModel>[].obs;
  var _subscribe = MySubscriptionModel().obs;
  var _paymentProcessing = false.obs;
  var _purchasedSubscriptionId = 0.obs;

  /// Getters

  List<SubscriptionModel> get subscribePlan => _subscribePlan;

  bool get paymentProcessing => _paymentProcessing.value;

  MySubscriptionModel get subscribe => _subscribe.value;

  ///Variable
  final SubscriptionService _subscriptionService = SubscriptionService.instance;

  late Razorpay _razorpay;

  @override
  void onInit() {
    super.onInit();
    getSubscriptionPlan();
    mySubscription();
    auth.getUser();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _onSuccessTxn(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentProcessing(false);
    log.e(response.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _paymentProcessing(false);
    log.i(response.toString());
  }

  Future<void> getSubscriptionPlan() async {
    try {
      setBusy(true);

      ApiResponse response = await _subscriptionService.getSubscriptionPlan();

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      _subscribePlan.assignAll(List<SubscriptionModel>.from(response.data.map((x) => SubscriptionModel.fromJson(x))));

      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  void purchaseSubscription({required int subscriptionId, required double price, String description = 'Subscribe to a subscription'}) async {
    _purchasedSubscriptionId(subscriptionId);
    await makePayment(price, description);
  }

  Future<void> mySubscription() async {
    try {
      setBusy(true);
      ApiResponse response = await _subscriptionService.mySubscription();

      if (response.hasError()) {
        log.w(response.message);
        // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      _subscribe(MySubscriptionModel.fromJson(response.data));

      //
      // setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> unlinkSubscription({required int id}) async {
    try {
      setBusy(true);
      ApiResponse response = await _subscriptionService.unlinkSubscription(id: id);

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        // setBusy(false);
        return;
      } else {
        Toastr.show(message: "Unlink successful");
        setBusy(false);
        auth.getUser();
        await getSubscriptionPlan();
        await mySubscription();
        dashboardController.onTabChanged(0);
        // return Get.toNamed('/menu');

      }
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> selfUnlink({required int id, required int subscribeId}) async {
    // try {
    setBusy(true);
    ApiResponse response = await _subscriptionService.selfUnlink(authid: id, subscribeId: subscribeId);

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
    } else {
      await auth.getUser();
      await getSubscriptionPlan();
      await mySubscription();
      Toastr.show(message: "Unlink successfully");
      setBusy(false);
    }
    // } on Exception catch (e) {
    //   Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    // }
  }

  Future<void> _onSuccessTxn(paymentId) async {
    // orderId: _order.value.id, paymentId: paymentId
    Map<String, dynamic> body = {'subscription_id': _purchasedSubscriptionId.value.toString(), 'rzrpay_payment_id': paymentId};
    ApiResponse response = await _subscriptionService.checkoutStatus(body: body);
    if (response.hasError()) {
      log.e(response.message);
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }

    //final HomeController homeController = HomeController.to;
    // await homeController.getHomeData();
    await auth.getUser();
    await getSubscriptionPlan();
    await mySubscription();
    Get.toNamed('/success');
    Future.delayed(300.milliseconds, () => setBusy(false));
  }

  Future<void> makePayment(double price, String description) async {
    setBusy(true);
    var options = {
      //'key': 'rzp_test_N1xH3RiCKKmOJf',
      'key': 'rzp_live_81zOSVDrjF1BkY',
      'amount': price * 100,
      'name': '${auth.user.name}',
      'description': description,
      'prefill': {'contact': '${auth.user.phone}', 'email': '${auth.user.email}'}
    };
    _razorpay.open(options);
  }
}
