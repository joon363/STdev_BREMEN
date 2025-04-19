import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stdev_bremen/pages/scanner_components/scanner_barcode_label.dart';
import 'package:stdev_bremen/pages/scanner_components/scanner_button_widgets.dart';
import 'package:stdev_bremen/pages/camera_result_page.dart';
import 'package:stdev_bremen/pages/scanner_components/scanner_error_widget.dart';
import 'package:stdev_bremen/themes.dart';
export 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

// A screen that allows users to take a picture using a given camera.
class CameraPage extends StatefulWidget {
  const CameraPage({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              alignment: Alignment.center,
              children: [
                Expanded(child: Container(
                    color: Colors.black,
                  )),
                CameraPreview(_controller),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: defaultPadding,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: defaultPadding * 4,
                      children: [
                        ExitButton(),
                        Material(
                          elevation: 0,
                          color: Colors.white, // 배경색
                          borderRadius: BorderRadius.circular(999),
                          child: InkWell(
                            //highlightColor: primaryColor,
                            borderRadius: BorderRadius.circular(999),
                            onTap: () async {
                              // Take the Picture in a try / catch block. If anything goes wrong,
                              // catch the error.
                              try {
                                // Ensure that the camera is initialized.
                                await _initializeControllerFuture;

                                // Attempt to take a picture and get the file `image`
                                // where it was saved.
                                final image = await _controller.takePicture();

                                if (!context.mounted) return;

                                // If the picture was taken, display it on a new screen.
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(
                                      // Pass the automatically generated path to
                                      // the DisplayPictureScreen widget.
                                      imagePath: image.path,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                // If an error occurs, log the error to the console.
                                print(e);
                              }
                            },
                            child: CircleAvatar(
                              radius: 30, // 원의 반지름
                              backgroundColor: Colors.white, // 하얀 배경
                              child: Icon(Icons.camera_alt, size: 25, color: Colors.black,)
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: defaultPadding * 2,)
                  ]
                )
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
