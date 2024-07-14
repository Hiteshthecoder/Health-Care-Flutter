import 'package:flutter_mvc/app/helpers/Global.dart';

import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'DiagnosticService.dart';

class AppDiagnosticService implements DiagnosticService {
  Future<ApiResponse> getDiagnosticData({int? page, String? state, String? city, String? district, String? pincode}) async {
    String? _filter;

    if(state != '-1'){
      _filter = _filter != null ? "&state=$state" : "?state=$state";
    }
    if(city != '-1'){
      _filter = _filter != null ? "$_filter&city=$city" : "?city=$city";
    }
    if(district != ''){
      _filter = _filter != null ? "$_filter&district=$district" : "?district=$district";
    }
    if(pincode != ''){
      _filter = _filter != null ? "$_filter&pincode=$pincode" : "?pincode=$pincode";
    }
    String _page = page != null ? 'page=$page&limit=10' : '';
    log.i(_filter);
    if(_filter != null){
      return await Request.get('/patient/diagnostic-centers$_filter&$_page', authenticate: true);
    } else {
      return await Request.get('/patient/diagnostic-centers?$_page', authenticate: true);
    }


  }

  Future<ApiResponse> getState() async {
    return await Request.get('/get-states', authenticate: true);
  }

  Future<ApiResponse> getCity({required stateID}) async {
    return await Request.get('/get-cities?state_id=$stateID', authenticate: true);
  }
}
