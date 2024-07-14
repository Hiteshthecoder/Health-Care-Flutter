import 'package:get/get.dart';
import '../../../shared/controllers/AppController.dart';


class ListRecentStoriesController extends AppController {
  static ListRecentStoriesController get to => Get.find();



  /// Observables
  var _tasks = RxList<Map<String, dynamic>>([]);

  var _tabIndex = RxInt(0);

  /// Getters
  List<Map<String, dynamic>> get tasks => _tasks;

  int get tabIndex => _tabIndex.value;




  @override
  void onInit() {
    super.onInit();
  }

    void onTabChanged(int index) {
      _tabIndex(index);
    }
  }


