import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stdev_bremen/pages/scanner_components/scanner_barcode_label.dart';
import 'package:stdev_bremen/pages/scanner_components/scanner_button_widgets.dart';
import 'package:stdev_bremen/pages/scanner_components/scanner_error_widget.dart';
import 'package:stdev_bremen/themes.dart';
export 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}