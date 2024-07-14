
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'HealthTipsIndexService.dart';


class AppHealthTipsIndexService implements HealthTipsIndexService{
  Future<ApiResponse> getHealthTipsData({int? page}) async {
    String _page = page != null ? 'page=$page&limit=15' : '';
    return await Request.get('/patient/health-tips/index?$_page',authenticate: true);
  }


  Future<ApiResponse> getHealthTipsShow({required int healthTipId}) async {

    //return await Request.get('/patient/health-tips/show',authenticate: true);

    return await Request.get('/patient/health-tips/show/$healthTipId',authenticate: true);
  }



}