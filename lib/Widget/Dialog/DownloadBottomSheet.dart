import 'package:flutter/material.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:share_plus/share_plus.dart';

class DownloadBottomSheet extends StatefulWidget {
  Function screenshotFunc;
  bool? enableScreenshot = true;
  String pdfUrl;
  String excelUrl;
  String filename;
  DownloadBottomSheet({
    Key? key,
    required this.screenshotFunc,
    this.enableScreenshot,
    required this.pdfUrl,
    required this.excelUrl,
    required this.filename,
  }) : super(key: key);

  @override
  State<DownloadBottomSheet> createState() => _DownloadBottomSheetState();
}

class _DownloadBottomSheetState extends State<DownloadBottomSheet> {
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
    Navigator.pop(context);
    if (selectedType == 0) {
      widget.screenshotFunc();
    } else if (selectedType == 1) {
      var file = await Singleton.instance.apiExtension.downloadFile(
        url: widget.pdfUrl,
        extension: "pdf",
        filename: "table-" + widget.filename,
      );
      Share.shareXFiles([
        XFile(
          file.path,
        )
      ]);
    } else if (selectedType == 2) {
      var file = await Singleton.instance.apiExtension.downloadFile(
        url: widget.excelUrl,
        extension: "xlsx",
        filename: "table-" + widget.filename,
      );
      Share.shareXFiles([XFile(file.path, mimeType: "xlsx")]);
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
