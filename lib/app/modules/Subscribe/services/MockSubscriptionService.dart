import '../../../models/ApiResponse.dart';
import 'SubscriptionService.dart';

class MockSubscriptionService implements SubscriptionService {
  @override
  Future<ApiResponse> getSubscriptionPlan() {
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> checkoutStatus({required Map<String, dynamic> body}){
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> mySubscription() {
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> unlinkSubscription({required int id}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> selfUnlink({required int authid, required int subscribeId}){
    // TODO: implement getData
    throw UnimplementedError();
  }
}