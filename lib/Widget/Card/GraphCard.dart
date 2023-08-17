import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Enum/TableTypeEnum.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Graph/GraphExpand.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class GraphCard extends StatefulWidget {
  late String bigTitle;
  late String title;
  late Function(double animationDuration, int axisFontSize) widgetFunction;
  Object? obj;
  TABLE_TYPE_ENUM? tableTypeEnum;
  TABLE_DATE_TYPE_ENUM? tableDateType;
  String? downloadFileName = "graph";
  int? tableLength = 0;

  GraphCard({
    Key? key,
    required this.bigTitle,
    required this.title,
    required this.widgetFunction,
    this.obj,
    this.tableDateType,
    this.tableTypeEnum,
    String? downloadFileName = "graph",
    int? tableLength = 0,
  }) {
    this.downloadFileName = downloadFileName;
    this.tableLength = tableLength;
  }

  @override
  State<GraphCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<GraphCard> {
  //Instance
  ScreenshotController screenshotController = ScreenshotController();

  Widget getRatioOneWidget() {
    return MediaQuery(
      data: MediaQueryData(size: Size(1000, 1000)),
      child: MaterialApp(
        home: Container(
          width: 1000,
          height: 1000,
          child: widget.widgetFunction(
            Singleton.instance.animationDurationGraph,
            Singleton.instance.graphAxisFontSizeReport,
          ),
        ),
      ),
    );
  }

  void screenshot() async {
    final directory = (await getApplicationDocumentsDirectory());
    File file = await File('${directory.path}/graph_shared.png');
    var captureFile = await screenshotController.captureFromWidget(
      Container(
        height: 1000,
        width: 1000,
        child: widget.widgetFunction(
          Singleton.instance.animationDurationGraph,
          Singleton.instance.graphAxisFontSizeReport,
        ),
      ),
    );
    var imageSave = await file.writeAsBytes(captureFile);
    if (imageSave.path.isNotEmpty) {
      Share.shareXFiles([XFile(imageSave.path)], text: "Graph Sharing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.grey.shade50,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        widget.title,
                        style: StyleColor.textStyleKhmerContentAuto(
                          fontSize: 14,
                          // bold: true,
                        ),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GraphExpand(
                              bigTitle: widget.bigTitle,
                              title: widget.title,
                              widgetFunction: widget.widgetFunction,
                              obj: widget.obj,
                              downloadFileName: widget.downloadFileName!,
                              tableDateType: widget.tableDateType,
                              tableTypeEnum: widget.tableTypeEnum,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          "assets/svg/expand.svg",
                          width: 20,
                          height: 20,
                          color: StyleColor.appBarColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 10,
            ),
            widget.widgetFunction(
              Singleton.instance.animationDurationGraph,
              Singleton.instance.graphAxisFontSizeScreen,
            ),
          ],
        ),
      ),
    );
  }
}
