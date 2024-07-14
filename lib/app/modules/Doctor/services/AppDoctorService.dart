import '../../../helpers/Global.dart';
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'DoctorService.dart';

class AppDoctorService implements DoctorService {
  Future<ApiResponse> getDoctorData({int? page, String? state, String? city, String? district, String? pincode}) async {
    String? _filter;

    if (state != '-1') {
      _filter = _filter != null ? "&state=$state" : "?state=$state";
    }
    if (city != '-1') {
      _filter = _filter != null ? "$_filter&city=$city" : "?city=$city";
    }
    if (district != '') {
      _filter = _filter != null ? "$_filter&district=$district" : "?district=$district";
    }
    if (pincode != '') {
      _filter = _filter != null ? "$_filter&pincode=$pincode" : "?pincode=$pincode";
    }
    String _page = page != null ? 'page=$page&limit=12' : '';
    if (_filter != null) {
      return await Request.get('/patient/doctor-list$_filter&$_page', authenticate: true);
    } else {
      return await Request.get('/patient/doctor-list$_page', authenticate: true);
    }
  }

  Future<ApiResponse> getState() async {
    return await Request.get('/get-states', authenticate: true);
  }

  Future<ApiResponse> getCity({required stateID}) async {
    return await Request.get('/get-cities?state_id=$stateID', authenticate: true);
  }

  Future<ApiResponse> getDoctorShowDetails({required int id}) async {
    return await Request.get('/doctor/view/$id', authenticate: true);
  }
}
