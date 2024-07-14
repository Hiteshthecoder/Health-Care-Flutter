
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'HomeService.dart';


class AppHomeService implements HomeService{
  Future<ApiResponse> getData() async {
    return await Request.get('/patient/home',authenticate: true);
  }
  Future<ApiResponse> getHomeSlider() async {

    return await Request.get('/patient/home/slider',authenticate: true);
  }

}