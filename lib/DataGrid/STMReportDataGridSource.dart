import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Report/STMReportModel.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Enum/TableTypeEnum.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Dialog/DownloadBottomSheet.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class STMDataGridSource extends DataGridSource {
  late TABLE_TYPE_ENUM stmReportTable;
  late BuildContext context;
  late String downloadFileName;
  final TABLE_DATE_TYPE_ENUM tableDateType;
  STMDataGridSource({
    required STMReportModel model,
    required this.tableDateType,
    required TABLE_TYPE_ENUM stmReportTable,
    required BuildContext context,
    required this.downloadFileName,
  }) {
    this.context = context;
    this.stmReportTable = stmReportTable;
    buildSTMDReport(reportModel: model, tableDateType: tableDateType);
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  late STMReportModel reportModel;

  List<StackedHeaderRow> getStackedHeaderRow() {
    if (stmReportTable == TABLE_TYPE_ENUM.STMRevenueTruck)
      return getSTMReportStackHeaderRow();
    else
      return getSTMReportStackHeaderRow();
  }

  List<StackedHeaderRow> getSTMReportStackHeaderRow() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
          columnNames: <String>[
            'vehicle-trx',
            'vehicle-total-percent',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'ឡាន',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'weight-kg',
            'weight-total-percent',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'ទម្ងន់',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'income-dollar',
            'income-total-percent',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'ចំណូល',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ])
    ];
    return stackedHeaderRows;
  }

  String getDateResultByFormat(
      {required String dateStr, required TABLE_DATE_TYPE_ENUM tableDateType}) {
    if (tableDateType == TABLE_DATE_TYPE_ENUM.DAILY)
      return dateStr.toDateYYYYMMDD();
    else if (tableDateType == TABLE_DATE_TYPE_ENUM.MONTHLY)
      return dateStr.toDateYYYYMM();
    else if (tableDateType == TABLE_DATE_TYPE_ENUM.YEARLY)
      return dateStr.toDateYYYY();
    return dateStr.toDateYYYYMMDD();
  }

  // DataGridRow getTotalRow(STMReportDataModel reportDataModel) {
  //   return DataGridRow(cells: [
  //     DataGridCell(columnName: '', value: "Total"),
  //     DataGridCell<int>(
  //       columnName: 'transaction-digital',
  //       value: deductionModel.total!.transactionDigital!.toInt(),
  //     ),
  //     DataGridCell<double>(
  //       columnName: 'transaction-digital-total-percent',
  //       value: deductionModel.total!.transactionDigitalTotalPercent!,
  //     ),
  //     DataGridCell<int>(
  //       columnName: 'transaction-total',
  //       value: deductionModel.total!.transactionTotal!.toInt(),
  //     ),
  //     DataGridCell<double>(
  //       columnName: 'amount-digital-total-dollar',
  //       value: deductionModel.total!.amountDigitalTotalDollar,
  //     ),
  //     DataGridCell<double>(
  //       columnName: 'amount-digital-total-percent',
  //       value: deductionModel.total!.amountDigitalTotalPercent!,
  //     ),
  //     DataGridCell<double>(
  //       columnName: 'amount-total',
  //       value: deductionModel.total!.amountTotal,
  //     ),
  //   ]);
  // }

  //Init buildSTMDReport Rows
  void buildSTMDReport(
      {required STMReportModel reportModel,
      required TABLE_DATE_TYPE_ENUM tableDateType}) {
    //Sort DESC
    reportModel.data!.sort(
      (a, b) => b.date!.compareTo(a.date!),
    );

    this.reportModel = reportModel;

    //Add Total
    _dataGridRows.add(
      DataGridRow(
        cells: [
          DataGridCell(columnName: '', value: "Total"),
          //Add vehicle-trx

          DataGridCell<int>(
            columnName: 'vehicle-trx',
            value: reportModel.total!.vehicleTrx!,
          ),

          //Add vehicle-total-percent

          DataGridCell<double>(
            columnName: 'vehicle-total-percent',
            value: null,
          ),

          //Add weight-kg
          DataGridCell<double>(
            columnName: 'weight-kg',
            value: reportModel.total!.weightKg!,
          ),

          //Add weight-total-percent
          DataGridCell<double>(
            columnName: 'weight-total-percent',
            value: null,
          ),

          //Add income-dollar

          DataGridCell<double>(
            columnName: 'income-dollar',
            value: reportModel.total!.incomeDollar,
          ),

          //Add income-total-percent
          DataGridCell<double>(columnName: 'income-total-percent', value: null),
        ],
      ),
    );

    //Add Year Data
    reportModel.data!.forEach((STMReportDataModel data) {
      if (data.vehicleTrx == null) {
        return;
      }
      ;
      List<DataGridCell> listCell = [];
      // print(data.toJson());

      //Add Date
      listCell.add(
        DataGridCell(
          columnName: 'date',
          value: getDateResultByFormat(
            dateStr: data.date!,
            tableDateType: tableDateType,
          ),
        ),
      );

      //Add vehicle-trx
      listCell.add(
        DataGridCell<int>(
          columnName: 'vehicle-trx',
          value: data.vehicleTrx,
        ),
      );

      //Add vehicle-total-percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'vehicle-total-percent',
          value: data.vehicleTotalPercent!,
        ),
      );

      //Add weight-kg
      listCell.add(
        DataGridCell<double>(
          columnName: 'weight-kg',
          value: data.weightKg!,
        ),
      );

      //Add weight-total-percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'weight-total-percent',
          value: data.weightTotalPercent!,
        ),
      );
      //Add income-dollar
      listCell.add(
        DataGridCell<double>(
          columnName: 'income-dollar',
          value: data.incomeDollar,
        ),
      );

      //Add income-total-percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'income-total-percent',
          value: data.incomeTotalPercent!,
        ),
      );
      _dataGridRows.add(DataGridRow(cells: listCell));
    });

    initSTMReportColumn();
  }

  List<GridColumn> listColumn = [];

  //Init Column
  void initSTMReportColumn() {
    //Date
    listColumn.add(
      GridColumn(
        columnName: "date",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Date",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Digital Trx
    listColumn.add(
      GridColumn(
        columnName: "vehicle-trx",
        visible: Extension.getPermissionByActivity(
                    activiyName: "Revenue Report - Car Trx Truck",
                    activityEn: true)
                .GET
            ? true
            : false,
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ចំនួនឡាន",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.digitalColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Vehicle Total
    listColumn.add(
      GridColumn(
        columnName: "vehicle-total-percent",
        visible: Extension.getPermissionByActivity(
                    activiyName: "Revenue Report - Car Trx Percent Truck",
                    activityEn: true)
                .GET
            ? true
            : false,
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ភាគរយ",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.digitalColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Weight
    listColumn.add(
      GridColumn(
        columnName: "weight-kg",
        visible: Extension.getPermissionByActivity(
                    activiyName: "Revenue Report - Car Weight Truck",
                    activityEn: true)
                .GET
            ? true
            : false,
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "គិតជា(គក)",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //weight-total-percent
    listColumn.add(
      GridColumn(
        columnName: "weight-total-percent",
        visible: Extension.getPermissionByActivity(
                    activiyName: "Revenue Report - Car Weight Percent Truck",
                    activityEn: true)
                .GET
            ? true
            : false,
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ភាគរយ",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.blueDarker,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Income
    listColumn.add(
      GridColumn(
        columnName: "income-dollar",
        visible: Extension.getPermissionByActivity(
                    activiyName: "Revenue Report - Car Revenue Truck",
                    activityEn: true)
                .GET
            ? true
            : false,
        width: Extension.getDeviceType() == DeviceType.PHONE ? 130 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ចំណូលសរុប",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.digitalColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    listColumn.add(
      GridColumn(
        columnName: "income-total-percent",
        visible: Extension.getPermissionByActivity(
                    activiyName: "Revenue Report - Car Revenue Percent Truck",
                    activityEn: true)
                .GET
            ? true
            : false,
        width: Extension.getDeviceType() == DeviceType.PHONE ? 130 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ភាគរយ",
            style: StyleColor.textStyleKhmerContentAuto(
                color: StyleColor.etcColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  List<GridColumn> getColumn() => listColumn;

  void onDownloadRowClick(
      {required String pdf, required String excel, required String date}) {
    showModalBottomSheet(
      // context: Singleton.instance.graphContext!,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) {
        return DownloadBottomSheet(
          enableScreenshot: false,
          screenshotFunc: () {},
          filename: downloadFileName + "-" + date.toDateYYYYMMDD_NoDash(),
          date: date,
          pdfUrl: pdf,
          excelUrl: excel,
        );
      },
    );
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  void performSorting(List<DataGridRow> rows) {
    // TODO: implement performSorting
    try {
      final DataGridRow firstRow = rows.first;
      rows.removeAt(0);
      super.performSorting(rows);
      rows.insert(0, firstRow);
    } catch (err) {}
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    if (stmReportTable == TABLE_TYPE_ENUM.STMRevenueTruck)
      return DataGridRowAdapter(cells: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  row.getCells()[0].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: InkWell(
                  onTap: () {
                    onDownloadRowClick(

                        // date: DateTime.parse(row.getCells()[0].value)
                        //     .toYYYYMMDD(),
                        date: () {
                          if (tableDateType == TABLE_DATE_TYPE_ENUM.MONTHLY) {
                            return DateFormat("yyyy-MM")
                                .parse(row.getCells()[0].value)
                                .toYYYYMMDD();
                          } else
                            return "";
                        }(),
                        pdf: "report",
                        excel: "report");
                  },
                  child: row.getCells()[0].value.toString() == "Total" ||
                          tableDateType != TABLE_DATE_TYPE_ENUM.MONTHLY
                      ? Container()
                      : Icon(
                          Icons.ios_share,
                          size: 20,
                          color: Colors.grey,
                        ),
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   alignment: Alignment.centerRight,
        //   padding: const EdgeInsets.all(8),
        //   child: Text(
        //     row.getCells()[0].value.toString(),
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[1].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[2].value != null
                ? (row.getCells()[2].value as double).toPercentFormat()
                : "",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[3].value != null
                ? (row.getCells()[3].value as double).toNumberDoubleFormat()
                : "",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[4].value != null
                ? (row.getCells()[4].value as double).toPercentFormat()
                : "",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[5].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[6].value != null
                ? (row.getCells()[6].value as double).toPercentFormat()
                : "",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]);
  }
}
