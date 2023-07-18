import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pdf_ops/management/AppStore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class PickFiles extends VxMutation<PdfAppStore> {
  @override
  perform() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      store?.files = [];
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        store?.files = result.paths.map((path) => File(path!)).toList();
      } else {
        openAppSettings();
      }
    } else {
      openAppSettings();
    }
  }
}

class RemoveFile extends VxMutation<PdfAppStore> {
  final int index;

  RemoveFile({required this.index});
  @override
  perform() => store!.files.removeAt(index);
}

class MergePdf extends VxMutation<PdfAppStore> {
  @override
  perform() async {
    List<String> pdfPath = [];
    store!.mergedFilePath = "";
    pdfPath = store!.files.map((e) => e.path).toList();

    store!.mergedFilePath = (await PdfManipulator().mergePDFs(
      params: PDFMergerParams(pdfsPaths: pdfPath),
    ))!;
    // Share.shareXFiles([XFile(mergedPdfPath!.toString())], text: 'Merged PDF');
  }
}

class setSaveFilePath extends VxMutation<PdfAppStore> {
  final String path;

  setSaveFilePath(this.path);

  @override
  perform() {
    store?.saveFilePath = path;
  }
}

class clearFilePath extends VxMutation<PdfAppStore> {
  @override
  perform() {
    store?.mergedFilePath = "";
  }
}
