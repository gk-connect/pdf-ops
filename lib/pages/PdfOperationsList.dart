import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_ops/management/AppStore.dart';
import 'package:pdf_ops/management/mutations.dart';
import 'package:pdf_ops/widgets/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class PdfOperationsList extends StatelessWidget {
  const PdfOperationsList({super.key});

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [MergePdf, setSaveFilePath, clearFilePath]);
    PdfAppStore? store = VxState.store as PdfAppStore;
    return Scaffold(
      appBar: AppBar(
        title: "PDF OpS".text.gray500.bold.make(),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(children: [
        10.heightBox,
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: ListTile(
            tileColor: Vx.blue200,
            leading: const Icon(Icons.merge_outlined),
            title: "Merge Selected PDF".text.bold.make(),
            onTap: () => (store.files.length > 1)
                ? MergePdf()
                : ScaffoldMessenger.of(context)
                    .showSnackBar(errorSnackMsgMinFile),
          ),
        ),
        10.heightBox,
        (store.mergedFilePath.isNotEmpty)
            ? Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    "Selected Path: ".text.bold.make(),
                    store.saveFilePath.text.ellipsis.make(),
                    2.widthBox,
                    const Icon(Icons.change_circle_outlined)
                  ],
                ),
              ).onTap(() async {
                String? result = (await FilePicker.platform.getDirectoryPath());

                setSaveFilePath(result ?? "");
              })
            : Container(),
        10.heightBox,
        (store.mergedFilePath.isNotEmpty)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (store.saveFilePath.isEmpty) {
                        String result =
                            (await FilePicker.platform.getDirectoryPath())!;

                        setSaveFilePath(result);
                      }

                      await File(store.mergedFilePath).copy(
                          "${store.saveFilePath!}/mergedFile-${DateTime.now().millisecondsSinceEpoch.toString()}.pdf");
                      ScaffoldMessenger.of(context)
                          .showSnackBar(mergeSaveSuccessfull);
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.download),
                        2.widthBox,
                        "Download".text.bold.make(),
                      ],
                    ),
                  ),
                  6.widthBox,
                  ElevatedButton(
                    onPressed: () async {
                      Share.shareXFiles(
                          [XFile(store.mergedFilePath!.toString())],
                          text: 'Merged PDF');
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.share),
                        5.widthBox,
                        "Share".text.bold.make(),
                      ],
                    ),
                  ),
                ],
              )
            : Container()
      ]),
    );
  }
}
