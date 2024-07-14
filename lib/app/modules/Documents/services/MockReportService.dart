import '../../../models/ApiResponse.dart';
import 'ReportService.dart';

class MockReportService implements ReportService {
  @override
  Future<ApiResponse> getReportData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> getCategories() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> organiseReport({required Map<String, dynamic> body,required int authId}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
}
