import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf_ops/management/AppStore.dart';
import 'package:pdf_ops/management/mutations.dart';
import 'package:velocity_x/velocity_x.dart';

class PdfPreview extends StatelessWidget {
  final String filePath;
  final int index;
  const PdfPreview({super.key, required this.filePath, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Vx.black)),
          child: PDFView(
            filePath: filePath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageSnap: true,
            defaultPage: 0,
            fitPolicy: FitPolicy.WIDTH,
            preventLinkNavigation: false,
            onPageError: (page, error) {
              print('Error occurred while loading page $page: $error');
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconButton(
            iconSize: 30,
            color: Vx.red700,
            onPressed: () => RemoveFile(index: index),
            icon: const Icon(Icons.delete_forever),
          ),
        )
      ],
    );
  }
}
