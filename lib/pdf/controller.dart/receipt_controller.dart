// import 'dart:io';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
// import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/src/widgets/page.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
// import 'package:flutter/material.dart' as mat;
// import 'package:flutter/material.dart' as mat;

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptController extends GetxController {
  bool fetchingImage = false;
  bool fetchingPdf = false;
  bool sharingImage = false;
  bool sharingPdf = false;

  Future<Uint8List> _generatePDFOrImage(
      {required Page page, bool isImage = false}) async {
    Uint8List bytes;
    final doc = Document();
    doc.addPage(page as pw.Page);
    bytes = await doc.save();
    if (isImage) {
      await for (var page in Printing.raster(bytes, pages: [0], dpi: 72 * 3)) {
        await page.toPng().then((value) => bytes = value);
      }
    }
    return bytes;
  }

  Future<File> getPaymentReceiptPDF({required Page page}) async {
    final Directory? appDocDir = await getExternalStorageDirectory();
    // final Directory appDocDir = await getApplicationDocumentsDirectory();
    // Directory appDocDir = await Directory('/storage/emulated/0/myReceipt');
    // if (appDocDir.exists() == false) {
    //   appDocDir.createSync();
    // }
    final String appDocPath = appDocDir!.path;
    // final id = DateTime.fromMicrosecondsSinceEpoch(
    //         DateTime.now().microsecondsSinceEpoch)
    //     .toString();
    final id = '3bb';

    final String filePath = '$appDocPath/sales_receipt$id.pdf';
    final File file = File(filePath);
    log('file: $file');
    bool exist = await file.exists();
    if (!exist) {
      file.create();
    } else {
      file;
    }
    List<int> bytes = await _generatePDFOrImage(page: page);
    await file.writeAsBytes(bytes);
    // PdfPreview(
    //   build: (format) => _generatePDFOrImage(page: page),
    //   actions: [
    //     PdfPreviewAction(
    //       icon: mat.Icon(mat.Icons.share),
    //       onPressed: (context, format, bytes) async {
    //         await Share.shareFiles([filePath], text: 'Transaction receipt');
    //       },
    //     )
    //   ],
    // );
    return file;
  }

  Future<File> getPaymentReceiptImage({required Page page}) async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // Directory appDocDir = await Directory('/storage/emulated/0/myReceipt');
      // if (appDocDir.exists() == false) {
      //   appDocDir.createSync();
      // }
      // Directory? appDocDir = await getExternalStorageDirectory();
      Directory? appDocDir = await getExternalStorageDirectory();

      String appPath = appDocDir!.path;
      log('appPath: $appPath');
      final id = '3bb';

      // final id = DateTime.fromMicrosecondsSinceEpoch(
      //         DateTime.now().microsecondsSinceEpoch)
      // .toString();
      String path = '$appPath/sales_receipt$id.png';
      File file = new File(path);
      bool exists = await file.exists();
      if (!exists) {
        file.create();
      } else {
        file;
      }
      log('file: $file Created');
      List<int> bytes = await _generatePDFOrImage(page: page, isImage: true);
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      log(e.toString());
      print(e);
      return File('');
    } finally {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  Future<void> shareFile({required bool isImage}) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory? appDocDir = await getExternalStorageDirectory();
    String appPath = appDocDir!.path;
    final id = '3bb';
    // final id = DateTime.fromMicrosecondsSinceEpoch(
    //         DateTime.now().microsecondsSinceEpoch)
    //     .toString();
    String path = '$appPath/sales_receipt$id.pdf';
    // ${isImage ? "png" : "pdf"}';
    log(' share File path: $path');
    File file = new File(path);
    //  // final result = await
    // OpenFile.open(path);
    final result = await Share.shareFiles(
      // [file],
      [path],
      text: 'Transaction receipt',
      sharePositionOrigin: Rect.fromCircle(
        radius: Get.width * 0.25,
        center: const Offset(0, 0),
      ),
      // sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10),
    );
  

    log('file shared');
  }
}
