

import '../../helpers/Request.dart';
import '../../models/ApiResponse.dart';
import 'RewardsService.dart';

class AppRewardsService implements RewardsService{
  Future<ApiResponse> getRewardsData() async {

  return await Request.get('/patient/rewards',authenticate: true);
  }

}
