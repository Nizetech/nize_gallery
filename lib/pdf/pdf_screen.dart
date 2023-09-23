import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nize_gallery/pdf/controller.dart/receipt_controller.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfDownloadReceipt extends StatefulWidget {
  const PdfDownloadReceipt({super.key});

  @override
  State<PdfDownloadReceipt> createState() => _PdfDownloadReceiptState();
}

class _PdfDownloadReceiptState extends State<PdfDownloadReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'PDF Download Receipt',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<ReceiptController>(
            init: ReceiptController(),
            builder: (ctrl) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'PDF Download  or Share Receipt ',
                      style: Get.theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () async {
                        await _openOrShareFile(
                          ctrl: ctrl,
                          isImage: false,
                          open: false,
                        );
                      },
                      child: Text('Share PDF')),
                  SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () async {
                        await _openOrShareFile(
                          ctrl: ctrl,
                          isImage: true,
                          open: true,
                        );
                      },
                      child: Text('Share Image')),
                ],
              );
            }));
  }
}




Future<void> _openOrShareFile({
  required ReceiptController ctrl,
  required bool isImage,
  required bool open,
}) async {
  // final robotoFont =
  //     pw.Font.ttf(await rootBundle.load('assets/fonts/GalanoGrotesque.otf'));
  final robotoFont = await PdfGoogleFonts.robotoBold();
  final poppins = await PdfGoogleFonts.poppinsBold();
  final font = await PdfGoogleFonts.poppinsMedium();
  pw.Widget _text(String text, {int? flex, pw.TextAlign? textAlign}) =>
      pw.Expanded(
        flex: flex ?? 1,
        child: pw.Text(
          text,
          textAlign: textAlign,
          style: pw.TextStyle(
            color: PdfColors.black,
            fontSize: 14,
          ),
        ),
      );
  pw.Widget _text2(String text, {int? flex, pw.TextAlign? textAlign}) =>
      pw.Expanded(
        flex: flex ?? 1,
        child: pw.Text(
          text,
          textAlign: textAlign,
          style: pw.TextStyle(
            // overflow: TextOverflow.ellipsis,
            font: robotoFont,
            color: PdfColor.fromHex('#030803'),
            fontSize: 14,
          ),
        ),
      );

  pw.Widget _items({
    required String item,
    required String price,
    required String qty,
    required String amount,
  }) =>
      pw.Padding(
        padding: pw.EdgeInsets.only(bottom: 10),
        child: pw.Row(
          children: [
            _text2(
              item,
              flex: 2,
            ),
            _text2(
              '₦$price',
              flex: 2,
            ),
            _text2(
              qty,
              flex: 1,
              textAlign: pw.TextAlign.center,
            ),
            _text2(
              'N$amount',
              flex: 2,
              textAlign: pw.TextAlign.right,
            ),
          ],
        ),
      );

    
  // final Uint8List fontData = File('GalanoGrotesque.otf').readAsBytesSync();
  final page = pw.Page(
    pageFormat: PdfPageFormat.a4,
    // pageTheme: pw.PageTheme(
    // theme: pw.ThemeData.withFont(base: font),
    // ),
    build: (pw.Context context) {
      return pw.Container(
        width: double.infinity,
        padding: pw.EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        color: PdfColor.fromHex('#ECF9EE'),
        child: pw.Column(children: [
         
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'RC No: 273839',
                  style: pw.TextStyle(
                    color: PdfColor.fromHex('#5E645C'),
                    fontSize: 14,
                    font: font,
                  ),
                ),
                pw.Text(
                  '30th Jan,2023',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 14,
                    font: font,
                  ),
                )
              ]),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                height: 32,
                width: 32,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  color: PdfColor.fromHex('#43C153'),
                ),
                child: pw.Text(
                  'BN',
                  style: pw.TextStyle(
                    color: PdfColor.fromHex('#FFFFFF'),
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
              ),
              pw.SizedBox(width: 8),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'SALESUNIT',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('#5E645C'),
                      fontSize: 14,
                      font: font,
                    ),
                  ),
                  pw.Text(
                    '+2349012345678',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('#5E645C'),
                      fontSize: 14,
                      font: font,
                    ),
                  ),
                ],
              ),
              pw.Spacer(),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Row(children: [
                    pw.Text(
                      'Receipt No:',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#5E645C'),
                        fontSize: 14,
                        font: font,
                      ),
                    ),
                    pw.Text(
                      ' #01',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#5E645C'),
                        fontSize: 14,
                        font: font,
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text(
                      'Sales Rep:',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#5E645C'),
                        fontSize: 14,
                        font: font,
                      ),
                    ),
                    pw.Text(
                      ' Clement',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#5E645C'),
                        fontSize: 14,
                        font: font,
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 24),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 24),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      _text(
                        'Item',
                        flex: 2,
                      ),
                      _text(
                        'Unit Price',
                        flex: 2,
                      ),
                      _text(
                        'Qty',
                        flex: 1,
                        textAlign: pw.TextAlign.center,
                      ),
                      _text(
                        'Amount',
                        flex: 2,
                        textAlign: pw.TextAlign.right,
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Divider(
                    color: PdfColors.grey200,
                  ),
                  pw.SizedBox(height: 5),
                  _items(
                    item: 'Bag',
                    price: '58,000',
                    qty: '1',
                    amount: '58,000.00',
                  ),
                  _items(
                    item: 'Bag',
                    price: '58,000',
                    qty: '1',
                    amount: '58,000.00',
                  ),
                  pw.Divider(
                    color: PdfColors.grey200,
                  ),
                  pw.SizedBox(height: 12),
                  pw.Row(
                    children: [
                      _text(
                        flex: 3,
                        'Discount:',
                        textAlign: pw.TextAlign.right,
                      ),
                      pw.SizedBox(width: 40),
                      _text2(
                          flex: 1, 'N2,000.00', textAlign: pw.TextAlign.right),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    children: [
                      _text(
                        flex: 3,
                        'Balance Owed:',
                        textAlign: pw.TextAlign.right,
                      ),
                      pw.SizedBox(width: 40),
                      _text2(flex: 1, 'N0.00', textAlign: pw.TextAlign.right),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    children: [
                      _text(
                        flex: 3,
                        'Total:',
                        textAlign: pw.TextAlign.right,
                      ),
                      pw.SizedBox(width: 40),
                      _text2(
                          flex: 1, '₦71,000.00', textAlign: pw.TextAlign.right),
                    ],
                  ),
                  pw.SizedBox(height: 32),
                  pw.Text(
                    'Description',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('#030803'),
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    'No description recorded',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('#030803'),
                      fontSize: 14,
                    ),
                  ),
                  pw.SizedBox(height: Get.height * .13),
                  pw.Center(
                    child: pw.Text(
                      'Thank you for patronage',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#030803'),
                        fontSize: 14,
                        font: poppins,
                      ),
                    ),
                  ),
                ]),
          )
        ]),
      );
    },
    
  );
  try {
  File file =
      isImage
        ? await ctrl.getPaymentReceiptImage(page: page)
        :
  //? Reciept PDF is functional
        await ctrl.getPaymentReceiptPDF(page: page);

    if (open) {
      OpenFile.open(
        file.path,
        // uti: isImage ? null : 'com.adobe.pdf',
        // type: isImage ? null : 'application/pdf',
      );
    } else {
  ctrl.shareFile(isImage: isImage);
    }
  } catch (e) {
    print(e);
  }

}
