// import 'dart:io';
import 'dart:io';
import 'dart:typed_data';
// import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/src/widgets/page.dart' as pw;
import 'package:pdf/widgets.dart' hide Page;
import 'package:printing/printing.dart';
// import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReceiptController
// extends GetxController
{
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
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final id = DateTime.fromMicrosecondsSinceEpoch(
            DateTime.now().microsecondsSinceEpoch)
        .toString();
    final String filePath = '$appDocPath/sales_receipt$id.pdf';
    final File file = File(filePath);
    bool exist = await file.exists();
    if (!exist) {
      file.create();
    } else {
      file;
    }
    List<int> bytes = await _generatePDFOrImage(page: page);
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<File> getPaymentReceiptImage({required Page page}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path;
    final id = DateTime.fromMicrosecondsSinceEpoch(
            DateTime.now().microsecondsSinceEpoch)
        .toString();
    String path = '$appPath/sales_receipt$id.png';
    File file = new File(path);
    bool exists = await file.exists();
    if (exists) return file;
    List<int> bytes = await _generatePDFOrImage(page: page, isImage: true);
    await file.writeAsBytes(bytes);
    return file;
  }

//   Future<void> shareFile({dynamic transId, required bool isImage}) async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appPath = appDocDir.path;
//     String path = '$appPath/payment_receipt_$transId.${isImage? "png" : "pdf"}';
//     Share.shareFiles([path], text: 'Transaction receipt');
//   }
}
