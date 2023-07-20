import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf_ops/management/AppStore.dart';
import 'package:pdf_ops/management/mutations.dart';
import 'package:pdf_ops/widgets/pdfPreview.dart';
import "package:velocity_x/velocity_x.dart";

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PickFiles, RemoveFile]);

    // Get access to the store
    PdfAppStore? store = VxState.store as PdfAppStore;

    return Scaffold(
        appBar: AppBar(
          title: "PDF OpS".text.gray500.bold.make(),
          backgroundColor: Colors.greenAccent,
          actions: [
            (store.files.isNotEmpty)
                ? Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          clearFilePath();
                          context.router.pushNamed("/pdf-route");
                        },
                        child: "Next".text.make()))
                : Container()
          ],
        ),
        body: store.files.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/add_files.json'),
                  "@gopu_krishnan".text.bold.gray800.make()
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Files Selected: ${store.files.length}".text.make(),
                    ],
                  ),
                  (store.files.isNotEmpty)
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: store.files.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PdfPreview(
                                filePath: store.files[index].path,
                                index: index,
                              );
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => PickFiles(),
          child: const Icon(Icons.add),
        ));
  }
}
