import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFCameraController extends GetxController {
  RxBool _isLoading = RxBool(false);
  RxBool _imageCaptured = RxBool(false);

  bool get isLoading => _isLoading.value;
  bool get imageCaptured => _imageCaptured.value;

  late CameraController? cameraController;
  late List<CameraDescription> cameras;

  @override
  void onInit() async {
    super.onInit();
   await requestCameraPermission();
    _isLoading(true);
    cameras = await availableCameras();
    var defaultCamera = cameras[0];

    cameraController = CameraController(defaultCamera, ResolutionPreset.max);
    cameraController!.initialize().then((_) {
      _isLoading(false);
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }



  Future<bool> requestCameraPermission() async {
    if (await Permission.camera.isGranted) {
      return true;
    } else {
      PermissionStatus permissionStatus = await Permission.camera.request();
      if (permissionStatus == PermissionStatus.granted) {
        return true;
      } else if (permissionStatus == PermissionStatus.denied ||
          permissionStatus == PermissionStatus.denied) {
        if (await openAppSettings()) {
          // The user opened the app settings to enable permissions.
          // You can handle this case as needed.
        }
        return false;
      }
    }
    return false;
  }


  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  void pickFile() async {
    final image = await cameraController!.takePicture();
    Get.back(result: image.path);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = cameraController;
    if (oldController != null) {
      cameraController = null;
      await oldController.dispose();
    }

    final CameraController cController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );

    cameraController = cController;

    try {
      await cameraController!.initialize();
      update();
    } on CameraException catch (e) {
      printError(info: e.description.toString());
    }
  }
}
