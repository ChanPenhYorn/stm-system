import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVTopupModel.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PPSHVTopupDataGridSource extends DataGridSource {
  PPSHVTopupDataGridSource(
      {required PPSHVTopupModel model,
      required TABLE_DATE_TYPE_ENUM tableDateType}) {
    // buildPPSHVTopupMixedTrx(topupModel: model, tableDateType: tableDateType);
  }
  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  late PPSHVTopupModel topupModel;

  List<StackedHeaderRow> getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
          columnNames: <String>[
            'transaction-obu',
            'transaction-obu-total-percent',
            'transaction-anpr',
            'transaction-anpr-total-percent',
            'transaction-total'
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Transaction',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'amount-obu-dollar',
            'amount-obu-total-percent',
            'amount-anpr-dollar',
            'amount-anpr-total-percent',
            'amount-total',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Amount',
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

  //Init Rows
  void buildPPSHVTopupMixedTrx(
      {required PPSHVTopupModel topupModel,
      required TABLE_DATE_TYPE_ENUM tableDateType}) {
    //Sort DESC
    topupModel.data!.sort(
      (a, b) => b.date!.compareTo(a.date!),
    );

    this.topupModel = topupModel;
    //Add Total
    _dataGridRows.add(DataGridRow(cells: [
      DataGridCell(columnName: '', value: "Total"),
      DataGridCell<int>(
        columnName: 'transaction-obu',
        value: topupModel.total!.transactionObu!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'transaction-obu-total-percent',
        value: topupModel.total!.transactionObuTotalPercent!,
      ),
      DataGridCell<int>(
        columnName: 'transaction-anpr',
        value: topupModel.total!.transactionAnpr!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'transaction-anpr-total-percent',
        value: topupModel.total!.transactionAnprTotalPercent,
      ),
      DataGridCell<int>(
        columnName: 'transaction-total',
        value: topupModel.total!.transactionTotal!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'amount-obu-dollar',
        value: topupModel.total!.amountObuDollar,
      ),
      DataGridCell<double>(
        columnName: 'amount-obu-total-percent',
        value: topupModel.total!.amountObuTotalPercent,
      ),
      DataGridCell<double>(
        columnName: 'amount-anpr-dollar',
        value: topupModel.total!.amountAnprDollar!,
      ),
      DataGridCell<double>(
        columnName: 'amount-anpr-total-percent',
        value: topupModel.total!.amountAnprTotalPercent,
      ),
      DataGridCell<double>(
        columnName: 'amount-total',
        value: topupModel.total!.amountTotal,
      ),
    ]));

    //Add Year Data
    topupModel.data!.forEach((PPSHVTopupDataModel data) {
      if (data.transactionTotal! <= 0) return;
      if (data.transactionTotal! <= 0) return;
      List<DataGridCell> listCell = [];
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

      //Add OBU Trx
      listCell.add(
        DataGridCell<int>(
            columnName: 'transaction-obu', value: data.transactionObu),
      );

      //Add OBU Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'transaction-obu-total-percent',
          value: data.transactionObuTotalPercent!,
        ),
      );

      //Add ANPR Trx
      listCell.add(
        DataGridCell<int>(
          columnName: 'transaction-anpr',
          value: data.transactionAnpr,
        ),
      );

      //Add ANPR Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'transaction-anpr-total-percent',
          value: data.transactionAnprTotalPercent,
        ),
      );

      //Add Transaction Total
      listCell.add(
        DataGridCell<int>(
          columnName: 'transaction-total',
          value: data.transactionTotal!,
        ),
      );

      //Add OBU Amount
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-obu-dollar',
          value: data.amountObuDollar,
        ),
      );

      //Add OBU Amount Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-obu-total-percent',
          value: data.amountObuTotalPercent,
        ),
      );

      //Add ANPR Amount
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-anpr-dollar',
          value: data.amountAnprDollar,
        ),
      );

      //Add ANPR Amount Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-anpr-total-percent',
          value: data.amountAnprTotalPercent,
        ),
      );

      //Add Total Amount
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-total',
          value: data.amountTotal,
        ),
      );

      _dataGridRows.add(DataGridRow(cells: listCell));
    });
    initColumn();
  }

  List<GridColumn> listColumn = [];
  //Init Column
  void initColumn() {
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
    //ETC Trx
    listColumn.add(
      GridColumn(
        columnName: "transaction-obu",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ETC Trx",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.etcColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //ETC Percent
    listColumn.add(
      GridColumn(
        columnName: "transaction-obu-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ETC (%)",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.etcColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //ANPR Trx
    listColumn.add(
      GridColumn(
        columnName: "transaction-anpr",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ANPR Trx",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.anprColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //ANPR Percent
    listColumn.add(
      GridColumn(
        columnName: "transaction-anpr-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ANPR (%)",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.anprColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Total Trx
    listColumn.add(
      GridColumn(
        columnName: "transaction-total",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Total Trx",
            style: StyleColor.textStyleKhmerContentAuto(
                color: StyleColor.tranGreenColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //OBU Amount
    listColumn.add(
      GridColumn(
        columnName: "amount-obu-dollar",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ETC Amount",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.etcColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //OBU Amount Percent
    listColumn.add(
      GridColumn(
        columnName: "amount-obu-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ETC (%)",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.etcColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //ANPR Amount
    listColumn.add(
      GridColumn(
        columnName: "amount-anpr-dollar",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ANPR Amount",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.anprColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //ANPR Amount Percent
    listColumn.add(
      GridColumn(
        columnName: "amount-anpr-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "ANPR (%)",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.anprColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    listColumn.add(
      GridColumn(
        columnName: "amount-total",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 130 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Total Amount",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  List<GridColumn> getColumn() => listColumn;

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

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
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
          (row.getCells()[2].value as double).toPercentFormat(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[3].value as int).toNumberFormat(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[4].value as double).toPercentFormat(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[5].value as int).toNumberFormat(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[6].value as double).toDollarCurrency(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[7].value as double).toPercentFormat(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[8].value as double).toDollarCurrency(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[9].value as double).toPercentFormat(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          (row.getCells()[10].value as double).toDollarCurrency(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}
