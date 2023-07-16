import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:pdf_ops/management/AppStore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

class PickFiles extends VxMutation<PdfAppStore> {
  @override
  perform() async {
    // Request the necessary permissions
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      store?.files = [];
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        store?.files = result.paths.map((path) => File(path!)).toList();
        print(store!.files);
      } else {
        // User canceled the picker
        print("User canceled the picker");
      }
    } else {
      print("User canceled the permission");
      // Permissions were denied
      if (status.isPermanentlyDenied) {
        // Permissions were permanently denied, show a snackbar or dialog to explain how to grant permissions manually
      } else {
        // Permissions were denied, show a snackbar or dialog to inform the user
      }
    }
  }
}

class RemoveFile extends VxMutation<PdfAppStore> {
  final int index;

  RemoveFile({required this.index});
  @override
  perform() => store!.files.removeAt(index);
}
