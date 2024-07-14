import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'ReportService.dart';

class AppReportService implements ReportService {
  Future<ApiResponse> getReportData() async {
    return await Request.get('/report/my-report', authenticate: true);
  }

  Future<ApiResponse> getCategories() async {
    return await Request.get('/patient/upload-document/category-list', authenticate: true);
  }

  Future<ApiResponse> organiseReport({required Map<String, dynamic> body, required int authId}) async {
    return await Request.post('/story/organize-request?$authId', body: body ,authenticate:  true);
  }

}
