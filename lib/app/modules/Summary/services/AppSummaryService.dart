
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'SummaryService.dart';


class AppSummaryService implements SummaryService{
  Future<ApiResponse> getSummaryData() async {
    return await Request.get('/story/my-summary',authenticate: true);
  }

}