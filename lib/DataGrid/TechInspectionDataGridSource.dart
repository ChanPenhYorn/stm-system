import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/TechInspection/TechInspectionModel.dart';
import 'package:stm_report_app/Enum/ValueDataTypeEnum.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TechInspectionDataGridSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  late TechInspectionModel tiModel;

  //Init Rows
  void buildYearData(TechInspectionModel tiModel) {
    this.tiModel = tiModel;
    //Add Year Data
    tiModel.yearData!.forEach((YearData yearData) {
      List<DataGridCell> listCell = [];
      //Add Cell 0
      listCell.add(
        DataGridCell(columnName: 'desc', value: "ឆ្នាំ ${yearData.year}"),
      );
      //Add Month Data
      yearData.monthData!.forEach((MonthData monthData) {
        listCell.add(
          DataGridCell(
            columnName: monthData.month!,
            value: monthData.value!,
          ),
        );
      });

      //Add Total
      listCell.add(
        DataGridCell(
          columnName: 'total',
          value: yearData.total!,
        ),
      );
      _dataGridRows.add(DataGridRow(cells: listCell));
    });

    //Add Change Amount Data
    List<DataGridCell> changeAmountCell = [
      DataGridCell(columnName: 'change-amount', value: 'កំណើន ៛'),
    ];
    tiModel.changeAmount!.monthData!.forEach((element) {
      changeAmountCell.add(DataGridCell<dynamic>(
          columnName: element.month!, value: element.value!));
    });
    changeAmountCell.add(
      DataGridCell(
        columnName: 'total',
        value: tiModel.changeAmount!.total!,
      ),
    );
    _dataGridRows.add(
      DataGridRow(cells: changeAmountCell),
    );

    //Add Change Percent Data
    List<DataGridCell> changePercentCell = [
      DataGridCell(columnName: 'change-percent', value: 'កំណើន %'),
    ];

    tiModel.changePercent!.monthData!.forEach((element) {
      changePercentCell.add(
        DataGridCell<dynamic>(
            columnName: element.month!, value: "${element.value!}%"),
      );
    });

    changePercentCell.add(
      DataGridCell(
        columnName: 'total',
        value: "${tiModel.changePercent!.total!}%",
      ),
    );
    _dataGridRows.add(
      DataGridRow(cells: changePercentCell),
    );

    initColumn();
  }

  List<GridColumn> listColumn = [];

  //Init Column
  void initColumn() {
    //Description
    listColumn.add(
      GridColumn(
        columnName: "",
        allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Month
    tiModel.yearData![0].monthData!.forEach((monthData) {
      listColumn.add(
        GridColumn(
          // width: 120,
          width:
              Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
          columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
              ? ColumnWidthMode.none
              : ColumnWidthMode.fill,
          columnName: 'A',
          label: Container(
            alignment: Alignment.center,
            child: Text(
              monthData.month!.getKhmerMonth(),
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
    //Total
    listColumn.add(
      GridColumn(
        columnName: "",
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "សរុប",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  List<GridColumn> getColumn() => listColumn;

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    List<Widget> listCell = [];
    row.getCells().forEach((element) {
      listCell.add(
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 5, right: 5),
            child: () {
              if (element.value.toString().getDataType() ==
                  VALUE_DATA_TYPE.NUMERIC) {
                if (element.value < 0) {
                  //Negative double number
                  return AutoSizeText(
                    "(${(element.value as double).abs().toKhmerCurrency()})",
                    style:
                        StyleColor.textStyleKhmerContentAuto(color: Colors.red),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    minFontSize: 12,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  );
                } else {
                  //Double number
                  return AutoSizeText(
                    double.parse(element.value.toString()).toKhmerCurrency(),
                    style: StyleColor.textStyleKhmerContentAuto(),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    minFontSize: 12,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  );
                }
              } else if (element.value.toString().getDataType() ==
                  VALUE_DATA_TYPE.PERCENT) {
                var isParse = double.tryParse(element.value
                    .toString()
                    .substring(0, element.value.toString().length - 1));
                if (isParse != null && isParse < 0) {
                  return AutoSizeText(
                    "(${double.parse(element.value.toString().substring(0, element.value.toString().length - 1)).abs()}%)",
                    style:
                        StyleColor.textStyleKhmerContentAuto(color: Colors.red),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    minFontSize: 12,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  );
                } else if (isParse != null && isParse >= 0) {
                  return AutoSizeText(
                    element.value,
                    style: StyleColor.textStyleKhmerContentAuto(),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    minFontSize: 12,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  );
                } else {
                  return AutoSizeText(
                    element.value,
                    style: StyleColor.textStyleKhmerContentAuto(),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    minFontSize: 12,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  );
                }
              } else
                //Normal String
                return AutoSizeText(
                  element.value,
                  style: StyleColor.textStyleKhmerContentAuto(),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  minFontSize: 12,
                  maxFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                );
            }()),
      );
    });
    return DataGridRowAdapter(cells: listCell);
  }
}
