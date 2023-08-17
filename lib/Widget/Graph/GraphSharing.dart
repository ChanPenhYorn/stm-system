import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GraphSharing {
  static void graphSharing(Widget graph) async {
    final directory = (await getApplicationDocumentsDirectory());
    File file = await File('${directory.path}/graph_shared.png');
    ScreenshotController screenshotController = ScreenshotController();

    var captureFile = await screenshotController.capture();
    // var captureFile = await screenshotController.captureAsUiImage();
    var imageSave = await file.writeAsBytes(captureFile!.toList());
    if (imageSave.path.isNotEmpty) {
      Share.shareXFiles([XFile(imageSave.path)], text: "Graph Sharing");
    }
  }
}
