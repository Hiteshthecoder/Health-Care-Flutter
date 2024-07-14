
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'ChartService.dart';


class AppChartService implements ChartService{
  Future<ApiResponse> getChartData() async {
    return await Request.get('/story/my-chart',authenticate: true);
  }

}