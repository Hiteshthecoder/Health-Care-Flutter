
import 'package:get/get.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/ChartModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/ChartService.dart';
import '../views/widgets/BloodPicture.dart';
import '../views/widgets/LiverFunction.dart';


class ChartController extends AppController {
  static ChartController get to => Get.find();



  /// Observables
  var _tasks = RxList<Map<String, dynamic>>([]);

  var _chartData = ChartModel().obs;
 //  var _chartData = <ChartModel>[].obs;

  var _tabIndex = RxInt(0);
  var _tabChangeTable = 0.obs;

  /// Getters
  List<Map<String, dynamic>> get tasks => _tasks;

  int get tabIndex => _tabIndex.value;
 int get tabChangeTable => _tabChangeTable.value;

  ChartModel get chartData => _chartData.value;
  //List<ChartModel> get chartData => _chartData;

  final ChartService _chartService = ChartService.instance;



  @override
  void onInit() {
    super.onInit();
    getChartData();
  }

  Future<void> getChartData() async {
    try {
      setBusy(true);
      /// Call api to login user
      ApiResponse response = await _chartService.getChartData();

      //log.w(response.status);

      if (response.hasError()) {
       // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      if(response.hasData())
       if(response.data != null) _chartData(ChartModel.fromJson(response.data));

      //_chartData.assignAll(List<ChartModel>.from(response.data.map((x)=> ChartModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }


  void onTabChanged(int index ) {
      _tabIndex(index);
      onTabChangedTable(index);

    }

    void onTabChangedTable(int index) {
      _tabChangeTable(index);


    }

  }


