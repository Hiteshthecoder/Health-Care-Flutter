import 'package:flutter_mvc/app/models/ApiResponse.dart';
import 'package:get/get.dart';

import  'AppWorldService.dart';
import  'MockWorldService.dart';

abstract class WorldService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [WorldService]

  static WorldService get instance {
    if (!Get.isRegistered<WorldService>()) Get.lazyPut<WorldService>(() => MOCK_ENABLED ? MockWorldService() : AppWorldService());

    return Get.find<WorldService>();
  }

///State
  Future<ApiResponse> getStates() ;

///city
  Future<ApiResponse> getCity({required int stateId}) ;



}
