import 'package:flutter/material.dart';
import 'package:stm_report_app/DataGrid/PPSHVDeductionDataGridSource.dart';
import 'package:stm_report_app/DataGrid/PPSHVTopupDataGridSource.dart';
import 'package:stm_report_app/DataGrid/STMReportDataGridSource.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVDeductionModel.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVTopupModel.dart';
import 'package:stm_report_app/Entity/Report/STMReportModel.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Enum/TableTypeEnum.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableComponent {
  Widget getPPSHVDeductionMixedTrx({
    required BuildContext context,
    required PPSHVDeductionModel model,
    required bool shrinkWrapColumn,
    required TABLE_DATE_TYPE_ENUM tableDateType,
    required TABLE_TYPE_ENUM ppshvDeductionTableType,
    String? downloadFileName = "graph",
  }) {
    PPSHVDeductionDataGridSource dt = PPSHVDeductionDataGridSource(
        downloadFileName: downloadFileName!,
        model: model,
        tableDateType: tableDateType,
        ppshvDeductionTable: ppshvDeductionTableType,
        context: context);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        frozenPaneElevation: 0,
        headerColor: Colors.grey.shade100,
        frozenPaneLineWidth: 0,
      ),
      child: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        stackedHeaderRows: dt.getStackedHeaderRow(),
        source: dt,
        columns: dt.getColumn(),
        frozenRowsCount: 1,
        frozenColumnsCount: 1,
        shrinkWrapColumns: shrinkWrapColumn,
        highlightRowOnHover: true,
        defaultColumnWidth: 130,
        rowHeight: 35,
        headerRowHeight: 35,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        horizontalScrollPhysics: ClampingScrollPhysics(),
        verticalScrollPhysics: ClampingScrollPhysics(),
        onCellTap: (cellTap) {},
      ),
    );
  }

  Widget getPPSHVTopupMixedTrx({
    required PPSHVTopupModel model,
    required bool shrinkWrapColumn,
    required TABLE_DATE_TYPE_ENUM tableDateType,
  }) {
    PPSHVTopupDataGridSource dt =
        PPSHVTopupDataGridSource(model: model, tableDateType: tableDateType);
    dt.buildPPSHVTopupMixedTrx(topupModel: model, tableDateType: tableDateType);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        frozenPaneElevation: 0,
        frozenPaneLineWidth: 0,
        headerColor: Colors.grey.shade100,
      ),
      child: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        stackedHeaderRows: dt.getStackedHeaderRows(),
        source: dt,
        columns: dt.getColumn(),
        // shrinkWrapRows: true,
        frozenRowsCount: 1,
        frozenColumnsCount: 1,
        shrinkWrapColumns: shrinkWrapColumn,
        highlightRowOnHover: true,
        defaultColumnWidth: 130,
        rowHeight: 35,
        headerRowHeight: 35,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        horizontalScrollPhysics: ClampingScrollPhysics(),
        verticalScrollPhysics: ClampingScrollPhysics(),
      ),
    );
  }

  Widget getSTMReportRevenueTruck({
    required STMReportModel model,
    required bool shrinkWrapColumn,
    required TABLE_DATE_TYPE_ENUM tableDateType,
    required BuildContext context,
    required TABLE_TYPE_ENUM stmReportTableType,
    String? downloadFileName = "graph",
  }) {
    STMDataGridSource dt = STMDataGridSource(
        model: model,
        tableDateType: tableDateType,
        stmReportTable: stmReportTableType,
        downloadFileName: "graph",
        context: context);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        frozenPaneElevation: 0,
        frozenPaneLineWidth: 0,
        headerColor: Colors.grey.shade100,
      ),
      child: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        stackedHeaderRows: dt.getStackedHeaderRow(),
        source: dt,
        columns: dt.getColumn(),
        // shrinkWrapRows: true,
        frozenRowsCount: 1,
        frozenColumnsCount: 1,
        shrinkWrapColumns: shrinkWrapColumn,
        highlightRowOnHover: true,
        defaultColumnWidth: 130,
        rowHeight: 35,
        headerRowHeight: 35,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        horizontalScrollPhysics: ClampingScrollPhysics(),
        verticalScrollPhysics: ClampingScrollPhysics(),
      ),
    );
  }
}
