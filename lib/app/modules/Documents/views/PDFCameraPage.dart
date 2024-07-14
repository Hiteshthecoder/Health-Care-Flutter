import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/layouts/MasterLayout.dart';
import '../controllers/PDFCameraController.dart';

class PDFCameraPage extends StatelessWidget {
  final PDFCameraController controller = Get.put(PDFCameraController());

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => controller.isLoading
          ? Container(
              color: kcPrimary,
              child: Center(
                child: CircularProgressIndicator(
                  color: kcWhite,
                ),
              ),
            )
          : MasterLayout(
              title: 'Capture Doc',
              body: Stack(
                fit: StackFit.loose,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: GetBuilder(
                          builder: (PDFCameraController c) {
                            // fetch screen size
                            final size = MediaQuery.of(context).size;

                            // calculate scale depending on screen and camera ratios
                            // this is actually size.aspectRatio / (1 / camera.aspectRatio)
                            // because camera preview size is received as landscape
                            // but we're calculating for portrait orientation
                            var scale = size.aspectRatio * c.cameraController!.value.aspectRatio;

                            // to prevent scaling down, invert the value
                            if (scale < 1) scale = 1 / scale;
                            return Transform.scale(
                              scale: scale,
                              child: Center(
                                child: CameraPreview(c.cameraController!),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Button.block(
                          key: UniqueKey(),
                          onTap: (_) => controller.pickFile(),
                          label: "Capture",
                          flat: true,
                        //  variant: ButtonVariant.SUCCESS,
                        ),
                      ),
                    ],
                  ),

                  controller.cameras.length <= 0
                      ? SizedBox.shrink()
                      : Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: kcBlack.withOpacity(0.32),
                              borderRadius: BorderRadius.circular(75),
                            ),
                            child: Column(
                              children: [
                                for (var cameraDescription in controller.cameras)
                                  IconButton(
                                    onPressed: () => controller.onNewCameraSelected(cameraDescription),
                                    icon: Icon(
                                      _getCameraLensIcon(cameraDescription.lensDirection),
                                      color: kcWhite,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () => controller.pickFile(),
              //   backgroundColor: Colors.black38,
              //   elevation: 0,
              //   child: Icon(Icons.camera),
              // ),
              // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }
}
