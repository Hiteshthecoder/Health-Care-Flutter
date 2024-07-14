import 'package:flutter_mvc/app/models/ApiResponse.dart';


import '../../../helpers/Request.dart';
import 'WorldService.dart';

class AppWorldService implements WorldService {


  ///State
  Future<ApiResponse> getStates() async {

    return await Request.get('/get-states',authenticate: true);
  }

///City
  Future<ApiResponse> getCity({required int stateId}) async {

    return await Request.get('/get-cities?state_id=$stateId',authenticate: true);
  }



}
