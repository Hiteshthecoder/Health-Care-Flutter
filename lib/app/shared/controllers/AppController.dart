import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/TextStyl.dart';

class AppController extends GetxController {
  ScrollController scrollController =
      new ScrollController(keepScrollOffset: false);

  /// Observables
  RxBool setSticky = false.obs;
  bool _isBusy = false;
  bool _isConnected = true;

  /// Getters
  bool get isSticky => this.setSticky.value;

  bool get isBusy => this._isBusy;

  bool get isConnected => this._isConnected;

  /// StreamSubscription for ConnectivityResult
  /// ```dart
  /// StreamSubscription<ConnectivityResult>
  /// ```
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    this.checkConnection();
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
      } else {
        _isConnected = true;
        onReconnect();
      }
      update();
    });
    scrollController.addListener(() {
      onScroll();
    });
  }

  void onScroll() {
    if (scrollController.positions.last.pixels >= 72) {
      setSticky(true);
    } else {
      setSticky(false);
    }
  }

  /// Executes when user re-connect to any network.
  /// ```
  /// [Cellular Data | WiFi]
  /// ```
  void onReconnect() {
    /// TODO: Implement onReconnect Method
  }

  /// Checks User connection state.
  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
    update();
  }

  /// Set the busy state
  void setBusy(bool val) {
    _isBusy = val;
    update();
  }

  void showBusy() {
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/loading-circular.gif",
                height: 45,
              ),
              const SizedBox(height: 16),
              Text(
                'Please wait...',
                style: TextStyl.body,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideBusy() {
    if (Get.isDialogOpen!) Get.back();
  }

  static void quit() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  void onClose() {
    scrollController.dispose();
    connectivitySubscription?.cancel();
    super.onClose();
  }
}
