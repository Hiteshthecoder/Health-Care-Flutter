
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'JourneyService.dart';


class AppJourneyService implements JourneyService{
  Future<ApiResponse> getJourneyData() async {
    return await Request.get('/story/my-journey',authenticate: true);
  }

}