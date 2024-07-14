
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'InsightService.dart';


class AppInsightService implements InsightService{
  Future<ApiResponse> getInsightData() async {
    return await Request.get('/story/insite-chart',authenticate: true);
  }

}