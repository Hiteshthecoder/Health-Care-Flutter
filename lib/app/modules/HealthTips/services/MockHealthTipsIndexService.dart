import '../../../models/ApiResponse.dart';
import 'HealthTipsIndexService.dart';

class MockHealthTipsIndexService implements HealthTipsIndexService {
  @override
  Future<ApiResponse> getHealthTipsData({int? page}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
  @override
  Future<ApiResponse> getHealthTipsShow({required int healthTipId}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
}