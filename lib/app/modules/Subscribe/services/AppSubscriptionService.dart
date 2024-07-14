import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'SubscriptionService.dart';

class AppSubscriptionService implements SubscriptionService {
  Future<ApiResponse> getSubscriptionPlan() async {
    return await Request.get('/subscription/get-subscription', authenticate: true);
  }

  Future<ApiResponse> checkoutStatus({required Map<String, dynamic> body}) async {
    return await Request.post('/subscription/buy-subscription', body: body, authenticate: true);
  }

  Future<ApiResponse> mySubscription() async {
    return await Request.get('/subscription/my-subscription', authenticate: true);
  }
  Future<ApiResponse> unlinkSubscription({required int id}) async {
    return await Request.get('/member/subscription-delete/$id', authenticate: true);
  }
  Future<ApiResponse> selfUnlink({required int authid, required int subscribeId}) async {
    return await Request.get('/member/self-unlink/$authid/$subscribeId', authenticate: true);
  }
}
