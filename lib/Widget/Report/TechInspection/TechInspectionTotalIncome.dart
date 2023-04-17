import 'package:flutter/material.dart';
import 'package:stm_report_app/DataGrid/TechInspectionDataGridSource.dart';
import 'package:stm_report_app/Entity/TechInspection/TechInspectionModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TechInspectionTotalIncome extends StatefulWidget {
  const TechInspectionTotalIncome({Key? key}) : super(key: key);

  @override
  State<TechInspectionTotalIncome> createState() =>
      _TechInspectionTotalIncomeState();
}

class _TechInspectionTotalIncomeState extends State<TechInspectionTotalIncome> {
  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  String jsonStr = "";
  late List<TechInspectionModel> jsonData;
  Future initData() async {
    await Future.delayed(
      Duration(milliseconds: 300),
    );
    source.buildYearData(jsonData[2]);
  }

  Future? InitData;

  TechInspectionDataGridSource source = TechInspectionDataGridSource();

  void initSource() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: StyleColor.appBarColor,
          title: Text(
            "ចំណូលសរុប",
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SafeArea(
              child: FutureBuilder(
                future: InitData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ExtensionComponent.techInspectionTotalIncome(
                              zoom: false,
                              title: "ចំណូលសរុប",
                              techInspectionReportModel: jsonData[2],
                            ),
                          ),
                        ),
                        //List
                        Container(
                          child: SfDataGrid(
                            shrinkWrapRows: true,
                            source: source,
                            columns: source.getColumn(),
                            gridLinesVisibility: GridLinesVisibility.both,
                            highlightRowOnHover: true,
                            defaultColumnWidth: 120,
                            rowHeight: 40,
                            headerRowHeight: 40,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                            columnWidthMode: ColumnWidthMode.fill,
                            allowSorting: true,
                            horizontalScrollPhysics: ClampingScrollPhysics(),
                            verticalScrollPhysics: ClampingScrollPhysics(),
                          ),
                        )
                      ],
                    );
                  }
                  return AnimateLoading();
                },
              ),
            );
          },
        ));
  }
}
