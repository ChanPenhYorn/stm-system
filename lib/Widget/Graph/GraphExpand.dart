import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVDeductionModel.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVTopupModel.dart';
import 'package:stm_report_app/Entity/Report/STMReportModel.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Enum/TableTypeEnum.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Dialog/DownloadBottomSheet.dart';
import 'package:stm_report_app/Widget/TestingReport.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot_callback/screenshot_callback.dart';

class GraphExpand<T> extends StatefulWidget {
  // Widget graphCard;
  Function(double animationDuration, int axisFontSize) widgetFunction;
  String bigTitle;
  String title;
  Object? obj;
  TABLE_TYPE_ENUM? tableTypeEnum;
  TABLE_DATE_TYPE_ENUM? tableDateType;
  String? downloadFileName = "graph";
  // int? tableLength = 0;
  GraphExpand({
    Key? key,
    required this.bigTitle,
    required this.title,
    required this.widgetFunction,
    this.obj,
    this.tableDateType,
    this.tableTypeEnum,
    this.downloadFileName,
    // this.tableLength,
  }) : super(key: key);

  @override
  State<GraphExpand> createState() => _GraphExpandState();
}

class _GraphExpandState extends State<GraphExpand> {
  late ScreenshotCallback screenshotCallback;
  Future? InitScreen;
  Future initScreen() async {
    await Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    InitScreen = initScreen();
    initScreenshotListener();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    screenshotCallback.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  void initScreenshotListener() async {
    await initScreenshotCallback();
  }

  Future<void> initScreenshotCallback() async {
    screenshotCallback = ScreenshotCallback();

    screenshotCallback.addListener(() {
      screenshot();
      print("Screenshot callback Fired!");
    });
  }

  Orientation orientation = Orientation.portrait;
  void setRotation() {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    }
    setState(() {});
  }

  bool getShrinkWrapColumn({bool? override}) {
    if (override != null)
      return override;
    else {
      if (orientation == Orientation.landscape) {
        if (widget.tableTypeEnum == TABLE_TYPE_ENUM.PPSHVTopupMixedTrx)
          return false;
        if (widget.tableTypeEnum ==
            TABLE_TYPE_ENUM.PPSHVDeductionCrossDigitalTrx) return false;
        if (widget.tableTypeEnum ==
            TABLE_TYPE_ENUM.PPSHVDeductionRevenueVehicle) return false;
        return true;
      } else {
        return false;
      }
    }
  }

  int tableRowsLength = 0;

  Widget getTable({bool? overrideWrapColumn}) {
    if (widget.obj != null && widget.tableTypeEnum != null) {
      if (widget.tableTypeEnum == TABLE_TYPE_ENUM.STMRevenueTruck) {
        tableRowsLength = (widget.obj as STMReportModel)
            .data!
            .where((element) => element.vehicleTrx! > 0)
            .length;
        return Singleton.instance.tableComponent.getSTMReportRevenueTruck(
          context: context,
          stmReportTableType: widget.tableTypeEnum!,
          model: widget.obj as STMReportModel,
          shrinkWrapColumn: getShrinkWrapColumn(override: overrideWrapColumn),
          tableDateType: widget.tableDateType!,
        );
      }
    }
    return Container();
  }

  ScreenshotController screenshotController = ScreenshotController();

  var presetScreenshotSize = [
    {
      "table": TABLE_TYPE_ENUM.PPSHVDeductionCrossDigitalTrx,
      "range": "0-7",
      "size": Size(1400, 1900)
    }
  ];

  void screenshot() async {
    AnimateLoading().showLoading(context);
    var captured = await screenshotController.captureFromWidget(
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
      targetSize: widget.tableTypeEnum == TABLE_TYPE_ENUM.PPSHVTopupMixedTrx
          ? Size(1400, (tableRowsLength * 30) + 800)
          : widget.tableTypeEnum == TABLE_TYPE_ENUM.PPSHVDeductionMixedTrx
              ? Size(1000, (tableRowsLength * 30) + 800)
              : widget.tableTypeEnum ==
                      TABLE_TYPE_ENUM.PPSHVDeductionCrossDigitalTrx
                  ? Size(1200, (tableRowsLength * 30) + 800)
                  : widget.tableTypeEnum ==
                          TABLE_TYPE_ENUM.PPSHVDeductionRevenueVehicle
                      ? Size(1200, (tableRowsLength * 30) + 800)
                      : Size(1000, (tableRowsLength * 30) + 800),
      MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: Scaffold(
          body: MediaQuery(
            data: MediaQueryData(padding: EdgeInsets.zero),
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  //Title
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/image/stm_report_logo.png",
                          width: 70,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                widget.bigTitle,
                                style: StyleColor.textStyleKhmerContentAuto(
                                  fontSize: 26,
                                  bold: false,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.title,
                                style: StyleColor.textStyleKhmerContentAuto(
                                  fontSize: 22,
                                  bold: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20,
                    ),
                    height: 400,
                    width: double.infinity,
                    child: widget.widgetFunction(
                      0,
                      Singleton.instance.graphAxisFontSizeReport,
                    ),
                  ),
                  Expanded(
                    child: getTable(
                      overrideWrapColumn: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    final directory = (await getApplicationDocumentsDirectory());
    File file = await File(
        '${directory.path}/${widget.downloadFileName! + "-" + DateTime.now().toYYYYMMDD_NoDash()}.jpg');
    var imageSave = await file.writeAsBytes(captured.toList());
    Navigator.pop(context);
    if (imageSave.path.isNotEmpty) {
      Share.shareXFiles([
        XFile(
          imageSave.path,
        )
      ]);
    }
  }

  void showBottomSheetDownload() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) {
        return DownloadBottomSheet(
          enableScreenshot: true,
          screenshotFunc: screenshot,
          filename: widget.downloadFileName!,
          pdfUrl: "",
          excelUrl: "",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OrientationBuilder(
            builder: (context, orientation) {
              this.orientation = orientation;
              // InitScreen = initScreen();
              return Screenshot(
                controller: screenshotController,
                child: FutureBuilder(
                  future: initScreen(),
                  builder: (context, snapshot) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: () {
                        if (snapshot.connectionState == ConnectionState.done)
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    height: orientation == Orientation.landscape
                                        ? MediaQuery.of(context).size.height *
                                            0.94
                                        : widget.obj != null
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.94,
                                    width: MediaQuery.of(context).size.width,
                                    // width: double.infinity,
                                    child: widget.widgetFunction(
                                      Singleton.instance.animationDurationGraph,
                                      Singleton
                                          .instance.graphAxisFontSizeScreen,
                                    ),
                                  ),
                                  getTable()
                                ],
                              ),
                            ),
                          );
                        return Container();
                      }(),
                    );
                  },
                ),
              );
            },
          ),
          //Bar
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 40,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 0, right: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/image/stm_report_logo.png",
                                width: 40),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 190,
                              ),
                              // width: 150,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                widget.title,
                                maxLines: 2,
                                maxFontSize: 14,
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                style: StyleColor.textStyleKhmerContentAuto(
                                  color: StyleColor.appBarColor,
                                  lineHeight: 1.6,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.rotate_left),
                          onPressed: setRotation,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.ios_share),
                      onPressed: () async {
                        showBottomSheetDownload();
                        // screenshot();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
