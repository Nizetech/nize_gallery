import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
          title: const Text('PDF Download Receipt'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Text('PDF Download Receipt'),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () {}, child: Text('Download PDF')),
          ],
        ));
  }
}

Future<void> _receiptFile() async {
  // await file.writeAsBytes(bytes);
  // print(filePath);
  final Uint8List fontData = File('GalanoGrotesque.otf').readAsBytesSync();
  final font = pw.Font.ttf(fontData.buffer.asByteData());
  final page = pw.Page(
    pageFormat: PdfPageFormat.a4,
    pageTheme: pw.PageTheme(
      theme: pw.ThemeData.withFont(base: font),
    ),
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
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  color: PdfColor.fromHex('#43C153'),
                ),
                child: pw.Text(
                  'BN',
                  style: pw.TextStyle(
                    color: PdfColor.fromHex('#FFFFFF'),
                    fontSize: 12,
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
        ]),
      );
    },
  );
}
