import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class DownloadCouponInvoiceBottomSheet extends StatefulWidget {
  Function screenshotFunc;
  bool? enableScreenshot = true;
  String pdfUrl;
  String excelUrl;
  String filename;
  String? date;
  String? param = "";
  DownloadCouponInvoiceBottomSheet({
    Key? key,
    required this.screenshotFunc,
    this.enableScreenshot,
    required this.pdfUrl,
    required this.excelUrl,
    required this.filename,
    this.param,
    this.date,
  }) : super(key: key);

  @override
  State<DownloadCouponInvoiceBottomSheet> createState() =>
      _DownloadCouponInvoiceBottomSheetState();
}

class _DownloadCouponInvoiceBottomSheetState
    extends State<DownloadCouponInvoiceBottomSheet> {
  int selectedType = 0;

  Widget getTickIcon(bool status) {
    if (status) {
      return Image.asset(
        "assets/image/check_enable.png",
        width: 20,
      );
    } else
      return Image.asset(
        "assets/image/check_disable.png",
        width: 20,
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.enableScreenshot == true)
      selectedType = 0;
    else if (widget.pdfUrl != "")
      selectedType = 1;
    else if (widget.excelUrl != "")
      selectedType = 2;
    else
      selectedType = -1;
    super.initState();
  }

  void onDownloadClick() async {
    if (selectedType == 0) {
      Navigator.pop(context);
      widget.screenshotFunc();
    } else if (selectedType == 1) {
      var stream = await Singleton.instance.apiExtension
          .downloadReportCouponInvoiceFile(context,
              date: widget.date!,
              periodType: "daily",
              fileType: "pdf",
              param: widget.param);
      Navigator.pop(context);
      if (kIsWeb) {
        await FileSaver.instance.saveFile(
          name: "file.pdf",
          ext: "pdf",
          bytes: stream,
          mimeType: MimeType.pdf,
        );
      } else {
        String dir = (await getTemporaryDirectory()).path + "file.pdf";
        final file = File(dir);
        await file.writeAsBytes(stream!);
        Share.shareXFiles([XFile(file.path, mimeType: "pdf")]);
      }
    } else if (selectedType == 2) {
      var stream = await Singleton.instance.apiExtension
          .downloadReportCouponInvoiceFile(context,
              date: widget.date!,
              periodType: "daily",
              fileType: "excel",
              param: widget.param);
      Navigator.pop(context);
      if (kIsWeb) {
        await FileSaver.instance.saveFile(
          name: "file.xlsx",
          ext: "xlsx",
          bytes: stream!,
          mimeType: MimeType.microsoftExcel,
        );
      } else {
        String dir = (await getTemporaryDirectory()).path + "file.xlsx";
        final file = File(dir);
        await file.writeAsBytes(stream!);
        Share.shareXFiles([XFile(file.path, mimeType: "xlsx")]);
      }
    }
  }

  Widget getImageButton() {
    return widget.enableScreenshot == true
        ? Stack(
            alignment: Alignment.topRight,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.grey.shade200,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  setState(() {
                    selectedType = 0;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/image/image.png",
                        width: 50,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'រូបភាព',
                        style: StyleColor.textStyleKhmerContentAuto(),
                      )
                    ],
                  ),
                ),
              ),
              selectedType == 0 ? getTickIcon(true) : getTickIcon(false),
            ],
          )
        : Opacity(
            opacity: 0.5,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    backgroundBlendMode: BlendMode.saturation,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/image/image.png",
                            width: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'រូបភាព',
                            style: StyleColor.textStyleKhmerContentAuto(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                selectedType == 0 ? getTickIcon(true) : getTickIcon(false),
              ],
            ),
          );
  }

  Widget getPDFButton() {
    return widget.pdfUrl != ""
        ? Stack(
            alignment: Alignment.topRight,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.grey.shade200,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  setState(() {
                    selectedType = 1;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/image/pdf.png",
                        width: 50,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'PDF',
                        style: StyleColor.textStyleKhmerContentAuto(),
                      )
                    ],
                  ),
                ),
              ),
              selectedType == 1 ? getTickIcon(true) : getTickIcon(false),
            ],
          )
        : Opacity(
            opacity: 0.5,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    backgroundBlendMode: BlendMode.saturation,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/image/pdf.png",
                            width: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'PDF',
                            style: StyleColor.textStyleKhmerContentAuto(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                selectedType == 1 ? getTickIcon(true) : getTickIcon(false),
              ],
            ),
          );
  }

  Widget getExcelButton() {
    return widget.excelUrl != ""
        ? Stack(
            alignment: Alignment.topRight,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.grey.shade200,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  setState(() {
                    selectedType = 2;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/image/excel.png",
                        width: 50,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Excel',
                        style: StyleColor.textStyleKhmerContentAuto(),
                      )
                    ],
                  ),
                ),
              ),
              selectedType == 2 ? getTickIcon(true) : getTickIcon(false),
            ],
          )
        : Opacity(
            opacity: 0.5,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    backgroundBlendMode: BlendMode.saturation,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/image/excel.png",
                            width: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Excel',
                            style: StyleColor.textStyleKhmerContentAuto(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                selectedType == 2 ? getTickIcon(true) : getTickIcon(false),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Title
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                  ),
                  child: Text(
                    'ក្រាហ្វ និង តារាង',
                    style: StyleColor.textStyleKhmerDangrekAuto(
                      // bold: true,
                      fontSize: 22,
                    ),
                  ),
                ),
                //Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    getImageButton(),
                    getPDFButton(),
                    getExcelButton(),
                  ],
                ),
                //Download Button

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: StyleColor.appBarColor.withOpacity(0.7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onDownloadClick,
                    child: Container(
                      height: 40,
                      width: 250,
                      alignment: Alignment.center,
                      child: Text(
                        "ទាញយក",
                        style: StyleColor.textStyleKhmerContentAuto(
                          fontSize: 18,
                          color: Colors.white,
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 250,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      "បោះបង់",
                      style: StyleColor.textStyleKhmerContentAuto(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Title
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: Text(
                    'ក្រាហ្វ និង តារាង',
                    style: StyleColor.textStyleKhmerDangrekAuto(
                      // bold: true,
                      fontSize: 22,
                    ),
                  ),
                ),

                //New Implementation
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //         margin: EdgeInsets.all(5),
                //         height: 30,
                //         width: 200,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         child: ElevatedButton(
                //             onPressed: () {},
                //             style: ElevatedButton.styleFrom(
                //                 backgroundColor:
                //                     StyleColor.appBarColor.withOpacity(0.7),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 )),
                //             child: Text('ស្ថានីយចូល',
                //                 style: StyleColor.textStyleKhmerContentAuto(
                //                   fontSize: 18,
                //                   color: Colors.white,
                //                   bold: true,
                //                 )))),
                //     Container(
                //         margin: EdgeInsets.all(5),
                //         height: 30,
                //         width: 200,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         child: ElevatedButton(
                //             onPressed: () {},
                //             style: ElevatedButton.styleFrom(
                //                 backgroundColor:
                //                     StyleColor.appBarColor.withOpacity(0.7),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 )),
                //             child: Text('ស្ថានីយចេញ',
                //                 style: StyleColor.textStyleKhmerContentAuto(
                //                   fontSize: 18,
                //                   color: Colors.white,
                //                   bold: true,
                //                 )))),
                //   ],
                // ),

                //Button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: getImageButton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: getPDFButton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: getExcelButton(),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //Download Button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  StyleColor.appBarColor.withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: onDownloadClick,
                          child: Container(
                            height: 30,
                            width: 250,
                            alignment: Alignment.center,
                            child: Text(
                              "ទាញយក",
                              style: StyleColor.textStyleKhmerContentAuto(
                                fontSize: 18,
                                color: Colors.white,
                                bold: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 250,
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                              "បោះបង់",
                              style: StyleColor.textStyleKhmerContentAuto(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
