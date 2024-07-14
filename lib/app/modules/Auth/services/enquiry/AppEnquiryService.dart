import '../../../../helpers/Request.dart';
import '../../../../models/ApiResponse.dart';
import 'EnquiryService.dart';

class AppEnquiryService implements EnquiryService {
  @override
  Future<ApiResponse> enquiryForm({required Map<String, dynamic> body}) async {
    return await Request.post('/user-enquiry', body: body,);
  }
}
