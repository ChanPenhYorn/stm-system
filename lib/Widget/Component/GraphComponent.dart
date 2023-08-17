import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Chart/AxisKeyDataModel.dart';
import 'package:stm_report_app/Enum/AxisDataTypeEnum.dart';
import 'package:stm_report_app/Enum/ChartTypeEnum.dart';
import 'package:stm_report_app/Enum/IntervalTypeEnum.dart';
import 'package:stm_report_app/Enum/ValueDataTypeEnum.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';

class GraphComponent {
  double animationDuration = 800;
  GraphComponent();
  //Get Value Mapper
  dynamic getXValueMapper<T>({
    required CHART_TYPE_ENUM chartType,
    required Map<String, dynamic> deserialize(T e),
    required dynamic obj,
    required String axisX,
    required VALUE_DATA_TYPE valueDataType,
  }) {
    if (chartType == CHART_TYPE_ENUM.PIE_CHART)
      return deserialize(obj)[axisX];
    else {
      if (valueDataType == VALUE_DATA_TYPE.DATE_TIME)
        // return new DateFormat('yyyy-MM-dd').parse(deserialize(obj)[axisX]);
        return DateTime.parse(deserialize(obj)[axisX]);
      else if (valueDataType == VALUE_DATA_TYPE.NUMERIC)
        return int.parse(deserialize(obj)[axisX]);
      else if (valueDataType == VALUE_DATA_TYPE.STRING)
        return deserialize(obj)[axisX];
    }
  }

  //Generate Serial
  dynamic generateSerials<T>({
    required CHART_TYPE_ENUM chartType,
    required List<T> jsonData,
    required Map<String, dynamic> deserialize(T e),
    required String axisX,
    required List<AxisKeyDataModel> axisY,
    required String xDataType,
    String? secondaryAxisX,
    List<AxisKeyDataModel>? secondaryAxisY,
    bool showDataLabel = true,
    int axisFontSize = 8,
  }) {
    if (chartType == CHART_TYPE_ENUM.LINE_CHART) {
      List<ChartSeries<T, dynamic>> listSerial = [];
      axisY.forEach((element) {
        Color color = element.colorRgb != null
            ? element.colorRgb!
            : Color(Random().nextInt(0xffffffff));
        listSerial.add(
          SplineSeries<T, DateTime>(
            color: color,
            animationDuration: 800,
            dataSource: jsonData,
            width: 2,
            name: element.label,
            xValueMapper: (T obj, _) => getXValueMapper(
              chartType: chartType,
              deserialize: deserialize,
              obj: obj,
              axisX: axisX,
              valueDataType: xDataType.getDataType(),
            ),
            yValueMapper: (T obj, _) => deserialize(obj)[element.data],
            markerSettings: MarkerSettings(
              isVisible: true,
              color: color,
              width: 5,
              height: 5,
            ),
          ),
        );
      });
      if (secondaryAxisY != null) {
        secondaryAxisY.forEach((element) {
          Color color = element.colorRgb != null
              ? element.colorRgb!
              : Color(Random().nextInt(0xffffffff));
          listSerial.add(
            StepAreaSeries<T, dynamic>(
              animationDuration: animationDuration,
              dataSource: jsonData,
              borderColor: color,
              borderWidth: 1,
              color: color.withOpacity(0.1),
              // width: 2,
              name: element.label,
              xValueMapper: (T obj, _) => getXValueMapper(
                chartType: chartType,
                deserialize: deserialize,
                obj: obj,
                axisX: axisX,
                valueDataType: xDataType.getDataType(),
              ),
              yValueMapper: (T obj, _) => deserialize(obj)[element.data],
              yAxisName: "secondaryAxisY",
              markerSettings: MarkerSettings(
                isVisible: false,
                color: color,
                width: 5,
                height: 5,
              ),
            ),
          );
        });
      }

      return listSerial;
    } else if (chartType == CHART_TYPE_ENUM.BAR_CHART) {
      List<ColumnSeries<T, dynamic>> listSerial = [];
      axisY.forEach((element) {
        Color color = element.colorRgb != null
            ? element.colorRgb!
            : Color(Random().nextInt(0xffffffff));
        listSerial.add(
          ColumnSeries<T, dynamic>(
            color: color,
            animationDuration: animationDuration,
            dataSource: jsonData,
            width: 0.8,
            name: element.label,
            xValueMapper: (T obj, _) => getXValueMapper(
              chartType: chartType,
              deserialize: deserialize,
              obj: obj,
              axisX: axisX,
              valueDataType: xDataType.getDataType(),
            ),
            yValueMapper: (T obj, _) => deserialize(obj)[element.data],
          ),
        );
      });
      //Add Secondary Job
      if (secondaryAxisY != null) {
        secondaryAxisY.forEach((element) {
          Color color = element.colorRgb != null
              ? element.colorRgb!
              : Color(Random().nextInt(0xffffffff));
          listSerial.add(
            ColumnSeries<T, DateTime>(
              animationDuration: animationDuration,
              dataSource: jsonData,
              color: color,
              width: 0.8,
              name: element.label,
              xValueMapper: (T obj, _) => getXValueMapper(
                chartType: chartType,
                deserialize: deserialize,
                obj: obj,
                axisX: axisX,
                valueDataType: xDataType.getDataType(),
              ),
              yValueMapper: (T obj, _) => deserialize(obj)[element.data],
              yAxisName: "secondaryAxisY",
            ),
          );
        });
      }
      return listSerial;
    } else if (chartType == CHART_TYPE_ENUM.STACK_100_BAR) {
      List<ChartSeries<T, DateTime>> listSerial = [];
      axisY.forEach((element) {
        Color color = element.colorRgb != null
            ? element.colorRgb!
            : Color(Random().nextInt(0xffffffff));
        listSerial.add(
          StackedColumn100Series<T, DateTime>(
            animationDuration: animationDuration,
            dataSource: jsonData,
            name: element.label,
            color: color,
            xValueMapper: (T obj, _) => getXValueMapper(
              chartType: chartType,
              deserialize: deserialize,
              obj: obj,
              axisX: axisX,
              valueDataType: xDataType.getDataType(),
            ),
            pointColorMapper: (T obj, _) => color,
            yValueMapper: (T obj, _) => deserialize(obj)[element.data] * 100,
          ),
        );
      });
      return listSerial;
    } else if (chartType == CHART_TYPE_ENUM.STACK_BAR) {
      List<ChartSeries<T, DateTime>> listSerial = [];
      axisY.forEach((element) {
        Color randomColor = Color(Random().nextInt(0xffffffff));
        Color color =
            element.colorRgb != null ? element.colorRgb! : randomColor;
        listSerial.add(
          ColumnSeries<T, DateTime>(
            animationDuration: animationDuration,
            dataSource: jsonData,
            name: element.label,
            color: color,
            xValueMapper: (T obj, _) => getXValueMapper(
              chartType: chartType,
              deserialize: deserialize,
              obj: obj,
              axisX: axisX,
              valueDataType: xDataType.getDataType(),
            ),
            pointColorMapper: (T obj, _) => color,
            yValueMapper: (T obj, _) => deserialize(obj)[element.data],
            sortingOrder: SortingOrder.none,
            // dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        );
      });
      return listSerial;
    } else if (chartType == CHART_TYPE_ENUM.STACK_BAR_AND_LINE) {
      List<ChartSeries<T, dynamic>> listSerial = [];
      axisY.forEach((element) {
        Color randomColor = Color(Random().nextInt(0xffffffff));
        Color color =
            element.colorRgb != null ? element.colorRgb! : randomColor;
        listSerial.add(
          ColumnSeries<T, dynamic>(
            animationDuration: animationDuration,
            dataSource: jsonData,
            name: element.label,
            color: color,
            borderColor: StyleColor.blueDarker,
            borderWidth: 1,
            xValueMapper: (T obj, _) => getXValueMapper(
              chartType: chartType,
              deserialize: deserialize,
              obj: obj,
              axisX: axisX,
              valueDataType: xDataType.getDataType(),
            ),
            // yAxisName: "primaryAxisX",
            pointColorMapper: (T obj, _) => color,
            yValueMapper: (T obj, _) => deserialize(obj)[element.data],
            dataLabelSettings: DataLabelSettings(
              isVisible: element.label == "Digital" ? false : showDataLabel,
              labelIntersectAction: LabelIntersectAction.shift,
              showZeroValue: false,
              labelAlignment: ChartDataLabelAlignment.outer,
              alignment: element.label == "Digital"
                  ? ChartAlignment.far
                  : ChartAlignment.center,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle:
                  StyleColor.textStyleDefaultAuto(fontSize: axisFontSize + 2),
              angle: 270,
              // offset: Offset.zero,
            ),
            sortingOrder: SortingOrder.none,
          ),
        );
      });
      if (secondaryAxisY != null) {
        secondaryAxisY.forEach((element) {
          Color color = element.colorRgb != null
              ? element.colorRgb!
              : Color(Random().nextInt(0xffffffff));
          if (element.chartType == CHART_TYPE_ENUM.STACK_BAR) {
            listSerial.add(
              StackedColumnSeries<T, dynamic>(
                animationDuration: animationDuration,
                dataSource: jsonData,
                borderColor: color,
                borderWidth: 1,
                color: color,
                name: element.label,
                xValueMapper: (T obj, _) => getXValueMapper(
                  chartType: chartType,
                  deserialize: deserialize,
                  obj: obj,
                  axisX: axisX,
                  valueDataType: xDataType.getDataType(),
                ),
                yValueMapper: (T obj, _) => deserialize(obj)[element.data],
                yAxisName: "secondaryAxisY_Stack_Bar",
                dataLabelSettings: DataLabelSettings(
                  isVisible: element.label == "Digital" ? false : true,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelAlignment: ChartDataLabelAlignment.top,
                  textStyle: StyleColor.textStyleDefaultAuto(
                      fontSize: axisFontSize + 2),
                  angle: 270,
                  showZeroValue: false,
                  margin: EdgeInsets.only(bottom: 10),
                ),
              ),
            );
          } else
            listSerial.add(
              LineSeries<T, dynamic>(
                animationDuration: animationDuration,
                dataSource: jsonData,
                color: color,
                name: element.label,
                xValueMapper: (T obj, _) => getXValueMapper(
                  chartType: chartType,
                  deserialize: deserialize,
                  obj: obj,
                  axisX: axisX,
                  valueDataType: xDataType.getDataType(),
                ),
                yValueMapper: (T obj, _) => deserialize(obj)[element.data],
                yAxisName: "secondaryAxisY",
                markerSettings: MarkerSettings(
                  isVisible: true,
                  color: color,
                  width: 5,
                  height: 5,
                ),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  showZeroValue: false,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelAlignment: ChartDataLabelAlignment.top,
                  alignment: ChartAlignment.far,
                  textStyle: StyleColor.textStyleDefaultAuto(
                      fontSize: axisFontSize + 2),
                  angle: 270,
                ),
              ),
            );
        });
      }
      return listSerial;
    }
  }

  ChartAxis getAxis(
      VALUE_DATA_TYPE type,
      double primaryAxisXInterval,
      AXIS_DATA_TYPE axis_data_type,
      INTERVAL_TYPE_ENUM intervalType,
      int axisFontSize) {
    if (type == VALUE_DATA_TYPE.DATE_TIME) {
      return DateTimeAxis(
        name: 'primaryAxisX',
        rangePadding: ChartRangePadding.additional,
        desiredIntervals: 2,
        interval: primaryAxisXInterval == -1 ? null : primaryAxisXInterval,
        labelRotation: 270,
        dateFormat: axis_data_type == AXIS_DATA_TYPE.DATETIME_y
            ? DateFormat.y("km")
            : axis_data_type == AXIS_DATA_TYPE.DATETIME_MMMMEEEEd
                ? DateFormat.MMMMEEEEd("km")
                : DateFormat.yMMMM("km"),
        labelStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize, color: Colors.grey.shade600),
        edgeLabelPlacement: EdgeLabelPlacement.hide,
        labelIntersectAction: AxisLabelIntersectAction.none,
        intervalType: intervalType == INTERVAL_TYPE_ENUM.MONTH
            ? DateTimeIntervalType.months
            : intervalType == INTERVAL_TYPE_ENUM.YEAR
                ? DateTimeIntervalType.years
                : DateTimeIntervalType.auto,
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
      );
    } else if (type == VALUE_DATA_TYPE.NUMERIC) {
      return NumericAxis(
        // rangePadding: ChartRangePadding.additional,
        desiredIntervals: 1,
        labelStyle: StyleColor.textStyleKhmerContentAuto(),
        labelFormat: '\${value}',
        numberFormat: NumberFormat("#,###", "en"),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      );
    } else
      return NumericAxis(
        // rangePadding: ChartRangePadding.additional,
        desiredIntervals: 1,
        labelStyle: StyleColor.textStyleKhmerContentAuto(),
        labelFormat: '\${value}',
        numberFormat: NumberFormat("#,###", "en"),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      );
  }

  Widget getChart<T>({
    required CHART_TYPE_ENUM chartType,
    required String title,
    required List<T> jsonData,
    required Map<String, dynamic> primaryDeserialize(T e),
    required String primaryAxisX,
    required List<AxisKeyDataModel> primaryAxisY,
    required VALUE_DATA_TYPE primaryAxisYDataType,
    required String primaryAxisYTitle,
    AXIS_DATA_TYPE primaryAxisXFormat = AXIS_DATA_TYPE.DATETIME_MMMMEEEEd,
    List<AxisKeyDataModel>? secondaryAxisY,
    String? secondaryAxisYTitle = "",
    VALUE_DATA_TYPE secondaryAxisYDataType = VALUE_DATA_TYPE.RIEL,
    INTERVAL_TYPE_ENUM intervalType = INTERVAL_TYPE_ENUM.AUTO,
    bool zoom = false,
    bool primaryAxisYCompact = true,
    bool showDataLabel = true,
    double primaryAxisXInterval = 1,
    double primaryAxisYInterval = -1,
    double secondaryAxisYInterval = -1,
    double primaryAxisYGridLine = 0.3,
    double secondaryAxisYGridLine = 0,
    double animationDuration = 800,
    bool sideBySideSeries = true,
    int axisFontSize = 8,
  }) {
    //Check axisX datatype
    this.animationDuration = animationDuration;
    var xDataType = primaryDeserialize(jsonData[0])[primaryAxisX].toString();
    return SfCartesianChart(
      enableSideBySideSeriesPlacement: sideBySideSeries,
      trackballBehavior: TrackballBehavior(
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        enable: true,
        activationMode: ActivationMode.singleTap,
        markerSettings: TrackballMarkerSettings(
          height: 10,
          width: 10,
          borderWidth: 1,
        ),
        tooltipSettings: InteractiveTooltip(
          format: ' series.name : point.y',
          textStyle: StyleColor.textStyleKhmerContentAuto(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        tooltipAlignment: ChartAlignment.center,
      ),
      zoomPanBehavior: zoom == true
          ? ZoomPanBehavior(
              enablePinching: true,
              enableMouseWheelZooming: true,
              enablePanning: true,
            )
          : null,
      title: ChartTitle(
        text: title,
        textStyle: StyleColor.textStyleKhmerContentAuto(color: Colors.grey),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
      ),
      primaryXAxis: getAxis(xDataType.getDataType(), primaryAxisXInterval,
          primaryAxisXFormat, intervalType, axisFontSize),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.auto,
        name: "primaryAxisY",
        minimum: 0,
        interval: primaryAxisYInterval == -1 ? null : primaryAxisYInterval,
        // interval: null,
        title: AxisTitle(
          text: primaryAxisYTitle,
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize,
            color: Colors.grey,
          ),
        ),
        labelFormat: primaryAxisYDataType == VALUE_DATA_TYPE.NUMERIC
            ? '\$ {value}'
            : '{value}',
        numberFormat: primaryAxisYCompact == false
            ? NumberFormat("#,###", "en")
            : chartType == CHART_TYPE_ENUM.STACK_100_BAR
                ? NumberFormat("###", "en")
                : primaryAxisYDataType == VALUE_DATA_TYPE.PERCENT
                    ? NumberFormat.percentPattern("en")
                    : NumberFormat.compact(locale: "en"),
        axisLine: const AxisLine(width: 1),
        majorTickLines: MajorTickLines(width: 1, color: Colors.grey),
        majorGridLines:
            MajorGridLines(width: primaryAxisYGridLine, color: Colors.grey),
      ),
      axes: [
        NumericAxis(
          name: 'secondaryAxisY',
          title: AxisTitle(
            text: secondaryAxisYTitle,
            textStyle: StyleColor.textStyleKhmerContentAuto(
              fontSize: axisFontSize,
              color: Colors.grey,
            ),
          ),
          minimum: 0,
          interval:
              secondaryAxisYInterval == -1 ? null : secondaryAxisYInterval,
          majorTickLines: MajorTickLines(width: 1, color: Colors.grey),
          majorGridLines:
              MajorGridLines(width: secondaryAxisYGridLine, color: Colors.grey),
          labelFormat: '{value}',
          // numberFormat: NumberFormat("#,###", "en"),
          // numberFormat: NumberFormat.compact(locale: "en"),
          numberFormat: () {
            if (secondaryAxisYDataType == VALUE_DATA_TYPE.RIEL)
              return NumberFormat.compactCurrency(locale: "km", symbol: "៛");
            else if (secondaryAxisYDataType == VALUE_DATA_TYPE.DOLLAR)
              return NumberFormat.compactCurrency(locale: "en", symbol: "\$");
            else {
              return NumberFormat.compact(locale: "en");
            }
          }(),
          rangePadding: ChartRangePadding.normal,
          opposedPosition: true,
        )
      ],
      enableAxisAnimation: true,
      series: generateSerials(
          chartType: chartType,
          jsonData: jsonData,
          deserialize: primaryDeserialize,
          axisY: primaryAxisY,
          axisX: primaryAxisX,
          xDataType: xDataType,
          secondaryAxisY: secondaryAxisY,
          showDataLabel: showDataLabel,
          axisFontSize: axisFontSize),
      // tooltipBehavior: TooltipBehavior(
      //   enable: kIsWeb ? false : true,
      // ),
    );
  }

  //Pie Chart
  Widget getPie<T>({
    required String title,
    required T jsonData,
    required Map<String, dynamic> primaryDeserialize(T e),
    required List<AxisKeyDataModel> primaryAxisY,
  }) {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      title: ChartTitle(
        text: title,
      ),
      legend: Legend(
        alignment: ChartAlignment.center,
        isVisible: true,
        position: LegendPosition.bottom,
        itemPadding: 5,
        textStyle: StyleColor.textStyleKhmerContentAuto(
          fontSize: 12,
        ),
      ),
      series: generatePieSeries(
        jsonData: jsonData,
        primaryDeserialize: primaryDeserialize,
        primaryAxisY: primaryAxisY,
      ),
    );
  }

  dynamic generatePieSeries<T>({
    required T jsonData,
    required Map<String, dynamic> primaryDeserialize(T e),
    required List<AxisKeyDataModel> primaryAxisY,
  }) {
    List<PieSeries<AxisKeyDataModel, String>> listSeries = [];
    List<AxisKeyDataModel> listObj = [];
    primaryAxisY.forEach((element) {
      listObj.add(
        AxisKeyDataModel(
          label: element.label,
          data: (primaryDeserialize(jsonData)[element.data] * 100).toString(),
          colorRgb: element.colorRgb,
        ),
      );
    });

    listObj.forEach((element) {
      listSeries.add(
        PieSeries<AxisKeyDataModel, String>(
          explode: true,
          enableTooltip: true,
          explodeOffset: '10%',
          dataSource: listObj,
          pointColorMapper: (AxisKeyDataModel data, _) => data.colorRgb,
          xValueMapper: (AxisKeyDataModel data, _) => data.label,
          yValueMapper: (AxisKeyDataModel data, _) => double.parse(data.data!),
          strokeColor: Colors.white,
          strokeWidth: 2,
          dataLabelMapper: (AxisKeyDataModel data, _) =>
              "${data.label} ${double.parse(data.data!).toStringAsFixed(0)}",
          startAngle: 90,
          endAngle: 90,
          animationDuration: 700,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            overflowMode: OverflowMode.shift,
            // textStyle: TextStyle(
            //   fontSize: 12,
            //   fontFamily: 'Khmer OS Content',
            //
            // ),
          ),
        ),
      );
    });
    return listSeries;
  }
}
