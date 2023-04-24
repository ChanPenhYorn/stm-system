import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVDeductionModel.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Enum/TableTypeEnum.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Dialog/DownloadBottomSheet.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PPSHVDeductionDataGridSource extends DataGridSource {
  late TABLE_TYPE_ENUM ppshvDeductionTable;
  late BuildContext context;
  late String downloadFileName;
  PPSHVDeductionDataGridSource({
    required PPSHVDeductionModel model,
    required TABLE_DATE_TYPE_ENUM tableDateType,
    required TABLE_TYPE_ENUM ppshvDeductionTable,
    required BuildContext context,
    required this.downloadFileName,
  }) {
    this.context = context;
    this.ppshvDeductionTable = ppshvDeductionTable;
    if (ppshvDeductionTable == TABLE_TYPE_ENUM.PPSHVDeductionMixedTrx)
      buildPPSHVDeductionMixedTrx(
          deductionModel: model, tableDateType: tableDateType);
    else if (ppshvDeductionTable ==
        TABLE_TYPE_ENUM.PPSHVDeductionCrossDigitalTrx)
      buildPPSHVDeductionCrossDigitalTrx(
          deductionModel: model, tableDateType: tableDateType);
    else if (ppshvDeductionTable ==
        TABLE_TYPE_ENUM.PPSHVDeductionRevenueVehicle)
      buildPPSHVDeductionRevenueVehicle(
          deductionModel: model, tableDateType: tableDateType);
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  late PPSHVDeductionModel deductionModel;

  List<StackedHeaderRow> getStackedHeaderRow() {
    if (ppshvDeductionTable == TABLE_TYPE_ENUM.PPSHVDeductionMixedTrx)
      return getMixedTrxStackedHeaderRows();
    else if (ppshvDeductionTable ==
        TABLE_TYPE_ENUM.PPSHVDeductionCrossDigitalTrx)
      return getCrossDigitalTrxStackedHeaderRows();
    else if (ppshvDeductionTable ==
        TABLE_TYPE_ENUM.PPSHVDeductionRevenueVehicle)
      return getRevenueVehicleStackedHeaderRows();
    return [];
  }

  List<StackedHeaderRow> getMixedTrxStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
          columnNames: <String>[
            'transaction-digital',
            'transaction-digital-total-percent',
            'transaction-total',
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
            'amount-digital-total-dollar',
            'amount-digital-total-percent',
            'amount-total',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Revenue',
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

  List<StackedHeaderRow> getCrossDigitalTrxStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
          columnNames: <String>[
            'transaction-obu',
            'transaction-obu-total-percent',
            'transaction-anpr',
            'transaction-anpr-total-percent',
            'transaction-iccard',
            'transaction-iccard-total-percent',
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
            'amount-anpr-dollar',
            'amount-iccard-dollar',
            'amount-total',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Revenue',
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

  List<StackedHeaderRow> getRevenueVehicleStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
          columnNames: <String>[
            'total_trip_0point0',
            'total_trip_0point0_percentage',
            'total_trip_78point4',
            'total_trip_78point4_percentage',
            'total_trip_80point0',
            'total_trip_80point0_percentage',
            'total_trip',
            'total_amount'
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Total',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'type_a_type_0point0',
            'type_a_type_78point4',
            'type_a_type_80point0',
            'type_a_trip',
            'type_a_trip_percentage',
            'type_a_amount',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'A',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'type_b_type_0point0',
            'type_b_type_78point4',
            'type_b_type_80point0',
            'type_b_trip',
            'type_b_trip_percentage',
            'type_b_amount',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'B',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'type_c_type_0point0',
            'type_c_type_78point4',
            'type_c_type_80point0',
            'type_c_trip',
            'type_c_trip_percentage',
            'type_c_amount',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'C',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'type_d_type_0point0',
            'type_d_type_78point4',
            'type_d_type_80point0',
            'type_d_trip',
            'type_d_trip_percentage',
            'type_d_amount',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'D',
              style: StyleColor.textStyleKhmerContentAuto(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        StackedHeaderCell(
          columnNames: <String>[
            'type_e_type_0point0',
            'type_e_type_78point4',
            'type_e_type_80point0',
            'type_e_trip',
            'type_e_trip_percentage',
            'type_e_amount',
          ],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'E',
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

  DataGridRow getTotalRow(PPSHVDeductionModel deductionModel) {
    return DataGridRow(cells: [
      DataGridCell(columnName: '', value: "Total"),
      DataGridCell<int>(
        columnName: 'transaction-digital',
        value: deductionModel.total!.transactionDigital!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'transaction-digital-total-percent',
        value: deductionModel.total!.transactionDigitalTotalPercent!,
      ),
      DataGridCell<int>(
        columnName: 'transaction-total',
        value: deductionModel.total!.transactionTotal!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'amount-digital-total-dollar',
        value: deductionModel.total!.amountDigitalTotalDollar,
      ),
      DataGridCell<double>(
        columnName: 'amount-digital-total-percent',
        value: deductionModel.total!.amountDigitalTotalPercent!,
      ),
      DataGridCell<double>(
        columnName: 'amount-total',
        value: deductionModel.total!.amountTotal,
      ),
    ]);
  }

  //Init MixedTrx Rows
  void buildPPSHVDeductionMixedTrx(
      {required PPSHVDeductionModel deductionModel,
      required TABLE_DATE_TYPE_ENUM tableDateType}) {
    this.deductionModel = deductionModel;

    //Sort DESC
    deductionModel.data!.sort(
      (a, b) => b.date!.compareTo(a.date!),
    );

    //Add Total
    _dataGridRows.add(getTotalRow(deductionModel));

    //Add Year Data
    deductionModel.data!.forEach((PPSHVDeductionDataModel data) {
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

      //Add Digital Trx
      listCell.add(
        DataGridCell<int>(
            columnName: 'transaction-digital', value: data.transactionDigital),
      );

      //Add Digital Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'transaction-digital-total-percent',
          value: data.transactionDigitalTotalPercent!,
        ),
      );

      //Add Traffic Trx
      listCell.add(
        DataGridCell<int>(
          columnName: 'transaction-total',
          value: data.transactionTotal,
        ),
      );

      //Add Digital Amount
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-digital-total-dollar',
          value: data.amountDigitalTotalDollar,
        ),
      );

      //Add Digital Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-digital-total-dollar',
          value: data.amountDigitalTotalPercent!,
        ),
      );

      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-total',
          value: data.amountTotal,
        ),
      );

      _dataGridRows.add(DataGridRow(cells: listCell));
    });
    initMixedTrxColumn();
  }

  //Init CrossDigitalTrx Rows
  void buildPPSHVDeductionCrossDigitalTrx(
      {required PPSHVDeductionModel deductionModel,
      required TABLE_DATE_TYPE_ENUM tableDateType}) {
    //Sort DESC
    deductionModel.data!.sort(
      (a, b) => b.date!.compareTo(a.date!),
    );

    this.deductionModel = deductionModel;
    //Add Total
    _dataGridRows.add(DataGridRow(cells: [
      DataGridCell(columnName: '', value: "Total"),
      DataGridCell<int>(
        columnName: 'transaction-obu',
        value: deductionModel.total!.transactionObu!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'transaction-obu-total-percent',
        value: deductionModel.total!.transactionObuTotalPercent!,
      ),
      DataGridCell<int>(
        columnName: 'transaction-anpr',
        value: deductionModel.total!.transactionAnpr!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'transaction-anpr-total-percent',
        value: deductionModel.total!.transactionAnprTotalPercent,
      ),
      DataGridCell<int>(
        columnName: 'transaction-iccard',
        value: deductionModel.total!.transactionIccard!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'transaction-iccard-total-percent',
        value: deductionModel.total!.transactionIccardTotalPercent,
      ),
      DataGridCell<int>(
        columnName: 'transaction-total',
        value: deductionModel.total!.transactionTotal!.toInt(),
      ),
      DataGridCell<double>(
        columnName: 'amount-obu-dollar',
        value: deductionModel.total!.amountObuDollar,
      ),
      DataGridCell<double>(
        columnName: 'amount-anpr-dollar',
        value: deductionModel.total!.amountAnprDollar!,
      ),
      DataGridCell<double>(
        columnName: 'amount-iccard-dollar',
        value: deductionModel.total!.amountIccardDollar!,
      ),
      DataGridCell<double>(
        columnName: 'amount-total',
        value: deductionModel.total!.amountTotal,
      ),
    ]));

    //Add Year Data
    deductionModel.data!.forEach((PPSHVDeductionDataModel data) {
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

      //Add MTC Trx
      listCell.add(
        DataGridCell<int>(
          columnName: 'transaction-iccard',
          value: data.transactionIccard,
        ),
      );

      //Add MTC Percent
      listCell.add(
        DataGridCell<double>(
          columnName: 'transaction-iccard-total-percent',
          value: data.transactionIccardTotalPercent,
        ),
      );

      //Add Transaction Total
      listCell.add(
        DataGridCell<int>(
          columnName: 'transaction-total',
          value: data.transactionTotal!,
        ),
      );

      //Add OBU Revenue
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-obu-dollar',
          value: data.amountObuDollar,
        ),
      );

      //Add ANPR Revenue
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-anpr-dollar',
          value: data.amountAnprDollar,
        ),
      );

      //Add ETC Revenue
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-iccard-dollar',
          value: data.amountIccardDollar,
        ),
      );

      //Add Total Revenue
      listCell.add(
        DataGridCell<double>(
          columnName: 'amount-total',
          value: data.amountTotal,
        ),
      );

      _dataGridRows.add(DataGridRow(cells: listCell));
    });
    initCrossDigitalTrxColumn();
  }

  //Init CrossDigitalTrx Rows
  void buildPPSHVDeductionRevenueVehicle(
      {required PPSHVDeductionModel deductionModel,
      required TABLE_DATE_TYPE_ENUM tableDateType}) {
    //Sort DESC
    deductionModel.data!.sort(
      (a, b) => b.date!.compareTo(a.date!),
    );

    this.deductionModel = deductionModel;

    //Add Total
    _dataGridRows.add(
      DataGridRow(
        cells: [
          DataGridCell(columnName: '', value: "Total"),
          //Add Total 0% Trx

          DataGridCell<int>(
              columnName: 'total_trip_0point0',
              value: deductionModel.checksum!.grandTotal!.trip0point0),

          //Add Total 0% %

          DataGridCell<double>(
              columnName: 'total_trip_0point0_percentage',
              value:
                  deductionModel.checksum!.grandTotal!.trip0point0Percentage!),

          //Add Total 78.4% Trx

          DataGridCell<int>(
              columnName: 'total_trip_78point4',
              value: deductionModel.checksum!.grandTotal!.trip78point4),

          //Add Total 78.4% %
          DataGridCell<double>(
              columnName: 'total_trip_78point4_percentage',
              value:
                  deductionModel.checksum!.grandTotal!.trip78point4Percentage!),

          //Add Total 80% Trx

          DataGridCell<int>(
              columnName: 'total_trip_80point0',
              value: deductionModel.checksum!.grandTotal!.trip80point0),

          //Add Total 80% %
          DataGridCell<double>(
              columnName: 'total_trip_80point0_percentage',
              value:
                  deductionModel.checksum!.grandTotal!.trip80point0Percentage!),

          //Add Total Trip

          DataGridCell<int>(
              columnName: 'total_trip',
              value: deductionModel.checksum!.grandTotal!.trip!),

          //Add Total Amount
          DataGridCell<double>(
              columnName: 'total_amount',
              value: deductionModel.checksum!.grandTotal!.amount!),

          //Add Type A

          DataGridCell<int>(
              columnName: 'type_a_type_0point0',
              value: deductionModel.checksum!.typeA!.type0point0),

          DataGridCell<int>(
              columnName: 'type_a_type_78point4',
              value: deductionModel.checksum!.typeA!.type78point4),

          DataGridCell<int>(
              columnName: 'type_a_type_80point4',
              value: deductionModel.checksum!.typeA!.type80point0),

          DataGridCell<int>(
              columnName: 'type_a_trip',
              value: deductionModel.checksum!.typeA!.trip),

          DataGridCell<double>(
              columnName: 'type_a_trip_percentage',
              value: deductionModel.checksum!.typeA!.tripPercentage),

          DataGridCell<double>(
              columnName: 'type_a_amount',
              value: deductionModel.checksum!.typeA!.amount),

          //Add Type B

          DataGridCell<int>(
              columnName: 'type_b_type_0point0',
              value: deductionModel.checksum!.typeB!.type0point0),

          DataGridCell<int>(
              columnName: 'type_b_type_78point4',
              value: deductionModel.checksum!.typeB!.type78point4),

          DataGridCell<int>(
              columnName: 'type_b_type_80point4',
              value: deductionModel.checksum!.typeB!.type80point0),

          DataGridCell<int>(
              columnName: 'type_b_trip',
              value: deductionModel.checksum!.typeB!.trip),

          DataGridCell<double>(
              columnName: 'type_b_trip_percentage',
              value: deductionModel.checksum!.typeB!.tripPercentage),

          DataGridCell<double>(
              columnName: 'type_b_amount',
              value: deductionModel.checksum!.typeB!.amount),

          //Add Type C

          DataGridCell<int>(
              columnName: 'type_c_type_0point0',
              value: deductionModel.checksum!.typeC!.type0point0),

          DataGridCell<int>(
              columnName: 'type_c_type_78point4',
              value: deductionModel.checksum!.typeC!.type78point4),

          DataGridCell<int>(
              columnName: 'type_c_type_80point4',
              value: deductionModel.checksum!.typeC!.type80point0),

          DataGridCell<int>(
              columnName: 'type_c_trip',
              value: deductionModel.checksum!.typeC!.trip),

          DataGridCell<double>(
              columnName: 'type_c_trip_percentage',
              value: deductionModel.checksum!.typeC!.tripPercentage),

          DataGridCell<double>(
              columnName: 'type_c_amount',
              value: deductionModel.checksum!.typeC!.amount),

          //Add Type D

          DataGridCell<int>(
              columnName: 'type_d_type_0point0',
              value: deductionModel.checksum!.typeD!.type0point0),

          DataGridCell<int>(
              columnName: 'type_d_type_78point4',
              value: deductionModel.checksum!.typeD!.type78point4),

          DataGridCell<int>(
              columnName: 'type_d_type_80point4',
              value: deductionModel.checksum!.typeD!.type80point0),

          DataGridCell<int>(
              columnName: 'type_d_trip',
              value: deductionModel.checksum!.typeD!.trip),

          DataGridCell<double>(
              columnName: 'type_d_trip_percentage',
              value: deductionModel.checksum!.typeD!.tripPercentage),

          DataGridCell<double>(
              columnName: 'type_d_amount',
              value: deductionModel.checksum!.typeD!.amount),

          //Add Type E

          DataGridCell<int>(
              columnName: 'type_e_type_0point0',
              value: deductionModel.checksum!.typeE!.type0point0),

          DataGridCell<int>(
              columnName: 'type_e_type_78point4',
              value: deductionModel.checksum!.typeE!.type78point4),

          DataGridCell<int>(
              columnName: 'type_e_type_80point4',
              value: deductionModel.checksum!.typeE!.type80point0),

          DataGridCell<int>(
              columnName: 'type_e_trip',
              value: deductionModel.checksum!.typeE!.trip),

          DataGridCell<double>(
              columnName: 'type_e_trip_percentage',
              value: deductionModel.checksum!.typeE!.tripPercentage),

          DataGridCell<double>(
              columnName: 'type_e_amount',
              value: deductionModel.checksum!.typeE!.amount),

          //PDF

          DataGridCell<String>(
              columnName: 'pdf', value: deductionModel.checksum!.pdfUrl!),

          //EXCEL
          DataGridCell<String>(
              columnName: 'excel', value: deductionModel.checksum!.excelUrl!),

          //Full Date
          DataGridCell<String>(columnName: 'full_date', value: ""),
        ],
      ),
    );

    //Add Year Data
    deductionModel.data!.forEach((PPSHVDeductionDataModel data) {
      if (data.checksum == null) return;
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

      //Add Total 0% Trx
      listCell.add(
        DataGridCell<int>(
            columnName: 'total_trip_0point0',
            value: data.checksum!.grandTotal!.trip0point0),
      );

      //Add Total 0% %
      listCell.add(
        DataGridCell<double>(
            columnName: 'total_trip_0point0_percentage',
            value: data.checksum!.grandTotal!.trip0point0Percentage!),
      );

      //Add Total 78.4% Trx
      listCell.add(
        DataGridCell<int>(
            columnName: 'total_trip_78point4',
            value: data.checksum!.grandTotal!.trip78point4),
      );

      //Add Total 78.4% %
      listCell.add(
        DataGridCell<double>(
            columnName: 'total_trip_78point4_percentage',
            value: data.checksum!.grandTotal!.trip78point4Percentage!),
      );
      //Add Total 80% Trx
      listCell.add(
        DataGridCell<int>(
            columnName: 'total_trip_80point0',
            value: data.checksum!.grandTotal!.trip80point0),
      );

      //Add Total 80% %
      listCell.add(
        DataGridCell<double>(
            columnName: 'total_trip_80point0_percentage',
            value: data.checksum!.grandTotal!.trip80point0Percentage!),
      );
      //Add Total Trip
      listCell.add(
        DataGridCell<int>(
            columnName: 'total_trip', value: data.checksum!.grandTotal!.trip!),
      );
      //Add Total Amount
      listCell.add(
        DataGridCell<double>(
            columnName: 'total_amount',
            value: data.checksum!.grandTotal!.amount!),
      );

      //Add Type A
      listCell.add(
        DataGridCell<int>(
            columnName: 'type_a_type_0point0',
            value: data.checksum!.typeA!.type0point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_a_type_78point4',
            value: data.checksum!.typeA!.type78point4),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_a_type_80point4',
            value: data.checksum!.typeA!.type80point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_a_trip', value: data.checksum!.typeA!.trip),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_a_trip_percentage',
            value: data.checksum!.typeA!.tripPercentage),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_a_amount', value: data.checksum!.typeA!.amount),
      );

      //Add Type B
      listCell.add(
        DataGridCell<int>(
            columnName: 'type_b_type_0point0',
            value: data.checksum!.typeB!.type0point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_b_type_78point4',
            value: data.checksum!.typeB!.type78point4),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_b_type_80point4',
            value: data.checksum!.typeB!.type80point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_b_trip', value: data.checksum!.typeB!.trip),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_b_trip_percentage',
            value: data.checksum!.typeB!.tripPercentage),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_b_amount', value: data.checksum!.typeB!.amount),
      );

      //Add Type C
      listCell.add(
        DataGridCell<int>(
            columnName: 'type_c_type_0point0',
            value: data.checksum!.typeC!.type0point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_c_type_78point4',
            value: data.checksum!.typeC!.type78point4),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_c_type_80point4',
            value: data.checksum!.typeC!.type80point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_c_trip', value: data.checksum!.typeC!.trip),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_c_trip_percentage',
            value: data.checksum!.typeC!.tripPercentage),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_c_amount', value: data.checksum!.typeC!.amount),
      );

      //Add Type D
      listCell.add(
        DataGridCell<int>(
            columnName: 'type_d_type_0point0',
            value: data.checksum!.typeD!.type0point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_d_type_78point4',
            value: data.checksum!.typeD!.type78point4),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_d_type_80point4',
            value: data.checksum!.typeD!.type80point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_d_trip', value: data.checksum!.typeD!.trip),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_d_trip_percentage',
            value: data.checksum!.typeD!.tripPercentage),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_d_amount', value: data.checksum!.typeD!.amount),
      );

      //Add Type E
      listCell.add(
        DataGridCell<int>(
            columnName: 'type_e_type_0point0',
            value: data.checksum!.typeE!.type0point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_e_type_78point4',
            value: data.checksum!.typeE!.type78point4),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_e_type_80point4',
            value: data.checksum!.typeE!.type80point0),
      );

      listCell.add(
        DataGridCell<int>(
            columnName: 'type_e_trip', value: data.checksum!.typeE!.trip),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_e_trip_percentage',
            value: data.checksum!.typeE!.tripPercentage),
      );

      listCell.add(
        DataGridCell<double>(
            columnName: 'type_e_amount', value: data.checksum!.typeE!.amount),
      );

      //PDF
      listCell.add(
        DataGridCell<String>(columnName: 'pdf', value: data.checksum!.pdfUrl!),
      );
      //EXCEL
      listCell.add(
        DataGridCell<String>(
            columnName: 'excel', value: data.checksum!.excelUrl!),
      );
      //full date
      listCell.add(
        DataGridCell<String>(columnName: 'full_date', value: data.date),
      );

      _dataGridRows.add(DataGridRow(cells: listCell));
    });
    initRevenueVehicleColumn();
  }

  List<GridColumn> listColumn = [];
  //Init Column
  void initMixedTrxColumn() {
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
        columnName: "transaction-digital",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Digital Trx",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.digitalColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Digital Percent
    listColumn.add(
      GridColumn(
        columnName: "transaction-digital-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Digital (%)",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.digitalColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Traffic Trx
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
            "Transaction",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Traffic Amount
    listColumn.add(
      GridColumn(
        columnName: "amount-digital-total-dollar",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Digital Amount",
            style: StyleColor.textStyleKhmerContentAuto(
              color: StyleColor.blueDarker,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    listColumn.add(
      GridColumn(
        columnName: "amount-digital-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Digital (%)",
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
        columnName: "amount-total",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 130 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Revenue",
            style: StyleColor.textStyleKhmerContentAuto(
                color: StyleColor.etcColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  void initCrossDigitalTrxColumn() {
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
    //MTC Trx
    listColumn.add(
      GridColumn(
        columnName: "transaction-iccard",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 100 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "MTC Trx",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //MTC Percent
    listColumn.add(
      GridColumn(
        columnName: "transaction-iccard-total-percent",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 110 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "MTC (%)",
            style: StyleColor.textStyleKhmerContentAuto(),
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
    //MTC Amount
    listColumn.add(
      GridColumn(
        columnName: "amount-iccard-dollar",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "MTC Amount",
            style: StyleColor.textStyleKhmerContentAuto(),
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
            "Revenue",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  void initRevenueVehicleColumn() {
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
    //Total
    //Total 0% Trx
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "total_trip_0point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Total 0% %
    listColumn.add(
      GridColumn(
        columnName: "total_trip_0point0_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 60 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Total 78.4% Trx
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "total_trip_78point4",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Total 78.4% %
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "total_trip_78point4_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 70 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Total 80% Trx
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "total_trip_80point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Total 80% %
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "total_trip_80point0_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 70 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Total Trip
    listColumn.add(
      GridColumn(
        columnName: "total_trip",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 90 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Trip",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Total Amount
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "total_amount",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Total Amount",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Type A 0%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_a_type_0point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type A 78.4%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_a_type_78point4",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type A 80%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_a_type_80point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type A Trip
    listColumn.add(
      GridColumn(
        columnName: "type_a_trip",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 90 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Trip",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type A Trip Percent
    listColumn.add(
      GridColumn(
        columnName: "type_a_trip_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 60 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type A Trip Amount
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_a_amount",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Amount",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Type B 0%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_b_type_0point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type B 78.4%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_b_type_78point4",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type B 80%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_b_type_80point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type B Trip
    listColumn.add(
      GridColumn(
        columnName: "type_b_trip",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 90 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Trip",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type B Trip Percent
    listColumn.add(
      GridColumn(
        columnName: "type_b_trip_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 60 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type B Trip Amount
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_b_amount",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Amount",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Type C 0%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_c_type_0point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type C 78.4%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_c_type_78point4",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type C 80%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_c_type_80point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type C Trip
    listColumn.add(
      GridColumn(
        columnName: "type_c_trip",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 90 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Trip",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type C Trip Percent
    listColumn.add(
      GridColumn(
        columnName: "type_c_trip_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 60 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type C Trip Amount
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_c_amount",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Amount",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Type D 0%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_d_type_0point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type D 78.4%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_d_type_78point4",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type D 80%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_d_type_80point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type D Trip
    listColumn.add(
      GridColumn(
        columnName: "type_d_trip",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 90 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Trip",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type D Trip Percent
    listColumn.add(
      GridColumn(
        columnName: "type_d_trip_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 60 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type D Trip Amount
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_d_amount",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Amount",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    //Type E 0%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_e_type_0point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "0%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type E 78.4%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_e_type_78point4",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "78.4%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type E 80%
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_e_type_80point0",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 80 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "80%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type E Trip
    listColumn.add(
      GridColumn(
        columnName: "type_e_trip",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 90 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Trip",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type E Trip Percent
    listColumn.add(
      GridColumn(
        columnName: "type_e_trip_percentage",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 60 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "%",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //Type E Trip Amount
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "type_e_amount",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Amount",
            style: StyleColor.textStyleKhmerContentAuto(
                // color: StyleColor.etcColor,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //PDF
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "pdf",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "PDF",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //EXCEL
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "excel",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Excel",
            style: StyleColor.textStyleKhmerContentAuto(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    //EXCEL
    listColumn.add(
      GridColumn(
        visible: false,
        columnName: "full_date",
        width: Extension.getDeviceType() == DeviceType.PHONE ? 120 : double.nan,
        columnWidthMode: Extension.getDeviceType() == DeviceType.PHONE
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        // allowSorting: true,
        label: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Full Date",
            style: StyleColor.textStyleKhmerContentAuto(),
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
    if (ppshvDeductionTable == TABLE_TYPE_ENUM.PPSHVDeductionMixedTrx)
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
            (row.getCells()[4].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[5].value as double).toPercentFormat(),
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
      ]);
    else if (ppshvDeductionTable ==
        TABLE_TYPE_ENUM.PPSHVDeductionCrossDigitalTrx)
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
            (row.getCells()[6].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[7].value as int).toNumberFormat(),
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
            (row.getCells()[9].value as double).toDollarCurrency(),
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
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[11].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]);
    else if (ppshvDeductionTable ==
        TABLE_TYPE_ENUM.PPSHVDeductionRevenueVehicle) {
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
                        date: row.getCells()[41].value,
                        pdf: row.getCells()[39].value,
                        excel: row.getCells()[40].value);
                  },
                  child: row.getCells()[0].value.toString() == "Total"
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
            (row.getCells()[6].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[7].value as int).toNumberFormat(),
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

        //A
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[9].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[10].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[11].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[12].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[13].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[14].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        //B
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[15].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[16].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[17].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[18].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[19].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[20].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        //C
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[21].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[22].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[23].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[24].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[25].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[26].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        //D
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[27].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[28].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[29].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[30].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[31].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[32].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        //E
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[33].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[34].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[35].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[36].value as int).toNumberFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[37].value as double).toPercentFormat(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            (row.getCells()[38].value as double).toDollarCurrency(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[39].value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[40].value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        //FULL DATE
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[41].value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]);
    }
  }
}
