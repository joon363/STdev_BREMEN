import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stdev_bremen/screens/camera_result_page.dart';
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
      body: SafeArea(child: FutureBuilder<void>(
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
                          Material(
                            elevation: 0,
                            color: Colors.white, // 배경색
                            borderRadius: BorderRadius.circular(999),
                            child: InkWell(
                              //highlightColor: primaryColor,
                              borderRadius: BorderRadius.circular(999),
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                  radius: 30, // 원의 반지름
                                  backgroundColor: Colors.white, // 하얀 배경
                                  child: Icon(CupertinoIcons.xmark, size: 25, color: Colors.black,)
                              ),
                            ),
                          ),
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
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 50),
                    color: Colors.black26,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text('미션 목록\n- ‘밀면 밀려요’ 챌린지! 작용·반작용 찾아 찍기(1/2)\n- ‘미끄러울수록 덜 멈춰요!’ 마찰력 현장포착(2/2)\n- 얼음이 녹는 순간, 상태 변화 따라잡기!(1/3)',
                      style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                    ),)
                  ,
                )
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),)
    );
  }
}
