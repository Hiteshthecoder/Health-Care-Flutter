
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'FollowupService.dart';


class AppFollowupService implements FollowupService{
  Future<ApiResponse> getFollowupData() async {

    return await Request.get('/patient/my-followup',authenticate: true);
  }

}