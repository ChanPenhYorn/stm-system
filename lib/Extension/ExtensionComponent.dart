import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/Domain.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVDeductionModel.dart';
import 'package:stm_report_app/Entity/TechInspection/TechInspectionModel.dart';
import 'package:stm_report_app/Enum/AxisDataTypeEnum.dart';
import 'package:stm_report_app/Enum/IntervalTypeEnum.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Component/GraphComponent.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExtensionComponent {
  static Widget getNoImage() {
    if (Singleton.instance.selectedLanguage == 'km-KH')
      return Image.asset(
        'images/noimage.jpg',
      );
    else
      return Image.asset(
        'images/noimage_en.jpg',
      );
  }

  static Widget cachedNetworkImage(
      {required String url,
      double width = 80,
      double height = 80,
      bool profile = false}) {
    return CachedNetworkImage(
      imageUrl: Domain.domain + url,
      fit: BoxFit.cover,
      errorWidget: (context, str, dynamic) {
        return profile ? Extension.getNoImageProfile() : Extension.getNoImage();
      },
      placeholder: (context, str) {
        return CupertinoActivityIndicator();
      },
      width: width,
      height: height,
    );
  }

  static GraphComponent graphComponent = GraphComponent();

  static List<Color> listColor = [
    Color.fromRGBO(88, 0, 255, 1),
    Color.fromRGBO(0, 215, 255, 1)
  ];

  //TECH INSPECTION
  static List<ColumnSeries<MonthData, dynamic>> getTISeries(
      TechInspectionModel techInspectionModel) {
    List<ColumnSeries<MonthData, dynamic>> list = [];
    techInspectionModel.yearData!.asMap().forEach((idx, year) {
      Color color = Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
      if (listColor.length > idx) color = listColor[idx];
      list.add(
        ColumnSeries<MonthData, dynamic>(
          name: year.year,
          trendlines: [
            Trendline(
              type: TrendlineType.linear,
              width: 2,
              dashArray: <double>[10, 3, 3, 3],
              name: "ខ្សែ ${year.year}",
              color: color,
              isVisibleInLegend: false,
            )
          ],
          dataSource: year.monthData!,
          color: color,
          xValueMapper: (MonthData obj, _) => obj.month!.getKhmerMonth(),
          yValueMapper: (MonthData obj, _) => obj.value,
        ),
      );
    });
    return list;
  }

  //PPSHV Deduction
  static List<ChartSeries<PPSHVDeductionDataModel, dynamic>>
      getPPSHVDeductionRevenueVehicleSeries(PPSHVDeductionModel deductionModel,
          double animationDuration, int axisFontSize) {
    List<ChartSeries<PPSHVDeductionDataModel, dynamic>> listSerial = [];

    listSerial.add(
      SplineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        yAxisName: "secondaryAxisRevenue",
        name: "Revenue",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.grandTotal!.amount,
        markerSettings: MarkerSettings(
          isVisible: true,
          // color: color,
          width: 5,
          height: 5,
        ),
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          labelAlignment: ChartDataLabelAlignment.top,
          angle: 270,
          showZeroValue: false,
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize + 2,
          ),
        ),
      ),
    );

    listSerial.add(
      StepAreaSeries<PPSHVDeductionDataModel, DateTime>(
          // color: color,
          animationDuration: animationDuration,
          dataSource: deductionModel.data!,
          // width: 2,
          borderColor: Color.fromRGBO(41, 110, 9, 1.0),
          color: Color.fromRGBO(41, 110, 9, 1.0).withOpacity(0.1),
          // opacity: 0.1,
          borderWidth: 1,
          yAxisName: "primaryAxisY",
          name: "Traffic",
          xValueMapper: (PPSHVDeductionDataModel obj, _) =>
              DateTime.parse(obj.date!),
          yValueMapper: (PPSHVDeductionDataModel obj, _) =>
              obj.checksum == null ? 0 : obj.checksum!.grandTotal!.trip,
          markerSettings: MarkerSettings(
            isVisible: true,
            // color: color,
            width: 5,
            height: 5,
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            showZeroValue: false,
            textStyle: StyleColor.textStyleKhmerContentAuto(
              fontSize: axisFontSize + 2,
            ),
          )),
    );

    listSerial.add(
      StepLineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "A",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeA!.trip,
        markerSettings: MarkerSettings(
          isVisible: false,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type B
    listSerial.add(
      StepLineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "B",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeB!.trip,
        markerSettings: MarkerSettings(
          isVisible: false,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type C
    listSerial.add(
      StepLineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "C",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeC!.trip,
        markerSettings: MarkerSettings(
          isVisible: false,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type D
    listSerial.add(
      StepLineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "D",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeD!.trip,
        markerSettings: MarkerSettings(
          isVisible: false,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type E
    listSerial.add(
      StepLineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "E",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeE!.trip,
        markerSettings: MarkerSettings(
          isVisible: false,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    return listSerial;
  }

  //PPSHV Deduction Traffic CA Type
  static List<ChartSeries<PPSHVDeductionDataModel, dynamic>>
      getPPSHVDeductionTrafficVehicleSeries(PPSHVDeductionModel deductionModel,
          double animationDuration, int axisFontSize) {
    List<ChartSeries<PPSHVDeductionDataModel, dynamic>> listSerial = [];

    listSerial.add(
      ColumnSeries<PPSHVDeductionDataModel, DateTime>(
          // color: color,
          animationDuration: animationDuration,
          dataSource: deductionModel.data!,
          // width: 2,
          borderColor: Color.fromRGBO(41, 110, 9, 1.0),
          color: Color.fromRGBO(41, 110, 9, 1.0).withOpacity(0.1),
          // opacity: 0.1,
          borderWidth: 1,
          yAxisName: "primaryAxisY",
          name: "Traffic",
          xValueMapper: (PPSHVDeductionDataModel obj, _) =>
              DateTime.parse(obj.date!),
          yValueMapper: (PPSHVDeductionDataModel obj, _) =>
              obj.checksum == null ? 0 : obj.checksum!.grandTotal!.trip,
          markerSettings: MarkerSettings(
            isVisible: false,
            // color: color,
            width: 5,
            height: 5,
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            angle: 270,
            labelPosition: ChartDataLabelPosition.outside,
            labelAlignment: ChartDataLabelAlignment.outer,
            showZeroValue: false,
            textStyle: StyleColor.textStyleKhmerContentAuto(
              fontSize: axisFontSize + 2,
            ),
          )),
    );

    listSerial.add(
      LineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "A",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeA!.trip,
        markerSettings: MarkerSettings(
          isVisible: true,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type B
    listSerial.add(
      LineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "B",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeB!.trip,
        markerSettings: MarkerSettings(
          isVisible: true,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type C
    listSerial.add(
      LineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "C",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeC!.trip,
        markerSettings: MarkerSettings(
          isVisible: true,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type D
    listSerial.add(
      LineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "D",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeD!.trip,
        markerSettings: MarkerSettings(
          isVisible: true,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    //Type E
    listSerial.add(
      LineSeries<PPSHVDeductionDataModel, DateTime>(
        // color: color,
        animationDuration: animationDuration,
        dataSource: deductionModel.data!,
        width: 2,
        name: "E",
        xValueMapper: (PPSHVDeductionDataModel obj, _) =>
            DateTime.parse(obj.date!),
        yValueMapper: (PPSHVDeductionDataModel obj, _) =>
            obj.checksum == null ? 0 : obj.checksum!.typeE!.trip,
        markerSettings: MarkerSettings(
          isVisible: true,
          // color: color,
          width: 5,
          height: 5,
        ),
      ),
    );
    return listSerial;
  }

  static Widget techInspectionFine({
    required bool zoom,
    required String title,
    required TechInspectionModel techInspectionReportModel,
  }) {
    return SfCartesianChart(
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
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: title,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      primaryXAxis: CategoryAxis(
        labelPosition: ChartDataLabelPosition.outside,
        labelStyle: StyleColor.textStyleKhmerContentAuto(fontSize: 12),
        placeLabelsNearAxisLine: true,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        autoScrollingMode: AutoScrollingMode.start,
      ),
      primaryYAxis: NumericAxis(
        name: "primaryAxisY",
        title: AxisTitle(
          text: "ចំនួនទឹកប្រាក់",
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        // labelsExtent: ,
        labelFormat: '៛ {value}',
        numberFormat: NumberFormat.compact(locale: "km-KH"),
        axisLine: const AxisLine(width: 1),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      enableAxisAnimation: true,
      series: getTISeries(techInspectionReportModel),
    );
  }

  static Widget techInspectionIncome({
    required bool zoom,
    required String title,
    required TechInspectionModel techInspectionReportModel,
  }) {
    return SfCartesianChart(
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
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: title,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      primaryXAxis: CategoryAxis(
        labelPosition: ChartDataLabelPosition.outside,
        labelStyle: StyleColor.textStyleKhmerContentAuto(fontSize: 12),
        placeLabelsNearAxisLine: true,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        autoScrollingMode: AutoScrollingMode.start,
      ),
      primaryYAxis: NumericAxis(
        name: "primaryAxisY",
        title: AxisTitle(
          text: "ចំនួនទឹកប្រាក់",
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        labelFormat: '៛ {value}',
        numberFormat: NumberFormat.compact(locale: "km-KH"),
        axisLine: const AxisLine(width: 1),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      enableAxisAnimation: true,
      series: getTISeries(techInspectionReportModel),
    );
  }

  static Widget techInspectionTotalIncome({
    required bool zoom,
    required String title,
    required TechInspectionModel techInspectionReportModel,
  }) {
    return SfCartesianChart(
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
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: title,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      primaryXAxis: CategoryAxis(
        labelPosition: ChartDataLabelPosition.outside,
        labelStyle: StyleColor.textStyleKhmerContentAuto(fontSize: 12),
        placeLabelsNearAxisLine: true,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        autoScrollingMode: AutoScrollingMode.start,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: "ចំនួនទឹកប្រាក់",
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        labelFormat: '៛ {value}',
        numberFormat: NumberFormat.compact(locale: "km-KH"),
        axisLine: const AxisLine(width: 1),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      enableAxisAnimation: true,
      series: getTISeries(techInspectionReportModel),
    );
  }

  static Widget ppshvDeductionRevenueVehicleType({
    required bool zoom,
    required String title,
    required PPSHVDeductionModel deductionModel,
    AXIS_DATA_TYPE primaryAxisXFormat = AXIS_DATA_TYPE.DATETIME_MMMMEEEEd,
    INTERVAL_TYPE_ENUM intervalType = INTERVAL_TYPE_ENUM.AUTO,
    double animationDuration = 800,
    double primaryAxisYInterval = -1,
    int axisFontSize = 8,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) {
    // if (deductionModel.data != null) {
    //   var data = deductionModel.data!;
    //   data.sort(
    //     (a, b) => a.date!.compareTo(b.date!),
    //   );
    //   minimumDate = DateTime.parse(data[0].date!);
    //   maximumDate = DateTime.parse(data[data.length - 1].date!);
    //
    //   print(minimumDate);
    //   print(maximumDate);
    // }
    return SfCartesianChart(
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
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: title,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      primaryXAxis: DateTimeAxis(
        minimum: minimumDate,
        maximum: maximumDate,
        dateFormat: primaryAxisXFormat == AXIS_DATA_TYPE.DATETIME_y
            ? DateFormat.y("km")
            : primaryAxisXFormat == AXIS_DATA_TYPE.DATETIME_MMMMEEEEd
                ? DateFormat.MMMMEEEEd("km")
                : DateFormat.yMMMM("km"),
        name: 'primaryAxisX',
        interval: 1,
        desiredIntervals: 2,
        edgeLabelPlacement: EdgeLabelPlacement.none,
        intervalType: intervalType == INTERVAL_TYPE_ENUM.MONTH
            ? DateTimeIntervalType.months
            : intervalType == INTERVAL_TYPE_ENUM.YEAR
                ? DateTimeIntervalType.years
                : DateTimeIntervalType.auto,
        // interval: primaryAxisXInterval == -1 ? null : primaryAxisXInterval,
        labelRotation: 270,
        labelStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize, color: Colors.grey.shade600),
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
      ),
      primaryYAxis: NumericAxis(
        name: "primaryAxisY",
        title: AxisTitle(
          // text: "ចំនួនទឹកប្រាក់",
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize,
            color: Colors.grey,
          ),
        ),
        // labelsExtent: ,
        labelFormat: '{value}',
        // interval: 5000,
        // maximum: 40000,
        interval: primaryAxisYInterval == -1 ? null : primaryAxisYInterval,
        numberFormat: NumberFormat.compact(locale: "en"),
        axisLine: const AxisLine(width: 1),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      axes: [
        NumericAxis(
          name: 'secondaryAxisRevenue',
          title: AxisTitle(
            // text: secondaryAxisYTitle,
            textStyle: StyleColor.textStyleKhmerContentAuto(
              fontSize: axisFontSize,
              color: Colors.grey,
            ),
          ),
          minimum: 0,
          interval: 40000,
          majorGridLines: MajorGridLines(width: 0, color: Colors.grey),
          labelFormat: '{value}',
          numberFormat:
              NumberFormat.compactCurrency(locale: "en", symbol: "\$"),
          rangePadding: ChartRangePadding.normal,
          opposedPosition: true,
        )
      ],
      enableAxisAnimation: true,
      series: getPPSHVDeductionRevenueVehicleSeries(
          deductionModel, animationDuration, axisFontSize),
    );
  }

  static Widget ppshvDeductionTrafficVehicleType({
    required bool zoom,
    required String title,
    required PPSHVDeductionModel deductionModel,
    AXIS_DATA_TYPE primaryAxisXFormat = AXIS_DATA_TYPE.DATETIME_MMMMEEEEd,
    INTERVAL_TYPE_ENUM intervalType = INTERVAL_TYPE_ENUM.AUTO,
    double animationDuration = 800,
    int axisFontSize = 8,
    double primaryAxisYInterval = -1,
  }) {
    return SfCartesianChart(
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
            fontSize: axisFontSize,
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
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: title,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
        textStyle: StyleColor.textStyleKhmerContentAuto(),
      ),
      primaryXAxis: DateTimeAxis(
        dateFormat: primaryAxisXFormat == AXIS_DATA_TYPE.DATETIME_y
            ? DateFormat.y("km")
            : primaryAxisXFormat == AXIS_DATA_TYPE.DATETIME_MMMMEEEEd
                ? DateFormat.MMMMEEEEd("km")
                : DateFormat.yMMMM("km"),
        name: 'primaryAxisX',
        interval: 1,
        rangePadding: ChartRangePadding.additional,
        desiredIntervals: 2,
        edgeLabelPlacement: EdgeLabelPlacement.hide,
        labelIntersectAction: AxisLabelIntersectAction.none,
        intervalType: intervalType == INTERVAL_TYPE_ENUM.MONTH
            ? DateTimeIntervalType.months
            : intervalType == INTERVAL_TYPE_ENUM.YEAR
                ? DateTimeIntervalType.years
                : DateTimeIntervalType.auto,
        // interval: primaryAxisXInterval == -1 ? null : primaryAxisXInterval,
        labelRotation: 270,
        labelStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize, color: Colors.grey.shade600),
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
      ),
      primaryYAxis: NumericAxis(
        name: "primaryAxisY",
        title: AxisTitle(
          // text: "ចំនួនទឹកប្រាក់",
          textStyle: StyleColor.textStyleKhmerContentAuto(
            fontSize: axisFontSize,
            color: Colors.grey,
          ),
        ),
        // labelsExtent: ,
        labelFormat: '{value}',
        // interval: 5000,
        // maximum: 40000,
        interval: primaryAxisYInterval == -1 ? null : primaryAxisYInterval,
        numberFormat: NumberFormat.compact(locale: "en"),
        axisLine: const AxisLine(width: 1),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      axes: [],
      enableAxisAnimation: true,
      series: getPPSHVDeductionTrafficVehicleSeries(
          deductionModel, animationDuration, axisFontSize),
    );
  }
}
