import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Report/STMReportDetailModel.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';

// ignore: must_be_immutable
class STMReportViewDialog extends StatefulWidget {
  STMReportDetailDataModel stmReportDataModel;
  STMReportViewDialog({Key? key, required this.stmReportDataModel})
      : super(key: key);

  @override
  State<STMReportViewDialog> createState() => _STMReportViewDialogState();
}

class _STMReportViewDialogState extends State<STMReportViewDialog> {
  @override
  Widget build(BuildContext context) {
    return //Panel
        SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        width: 500,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Dismiss
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            //Station In
            () {
              if (widget.stmReportDataModel.couponIn != null) {
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: StyleColor.appBarColorOpa01,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ស្ថានីយ៍ចូល',
                        style: StyleColor.textStyleKhmerDangrekAuto(
                            color: StyleColor.appBarColor, fontSize: 16),
                      ),
                      //Image Caption
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'រូបភាពយានយន្ត',
                                style: StyleColor.textStyleKhmerContentAuto(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                'រូបភាពផ្លាកលេខ',
                                style: StyleColor.textStyleKhmerContentAuto(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Images Front
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          dragStartBehavior: DragStartBehavior.start,
                          scrollBehavior: ScrollBehavior(),
                          children: [
                            //Front Camera
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponIn!.vehicleFrontUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponIn!.vehicleFrontUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponIn!.plateFrontUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponIn!.plateFrontUrl!,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Back Camera
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponIn!.vehicleBackUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponIn!.vehicleBackUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponIn!.plateBackUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponIn!.plateBackUrl!,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            }(),
            () {
              if (widget.stmReportDataModel.couponOut != null) {
                print('here');
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: StyleColor.appBarColorOpa01,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ស្ថានីយ៍ចេញ',
                        style: StyleColor.textStyleKhmerDangrekAuto(
                            color: StyleColor.appBarColor, fontSize: 16),
                      ),
                      //Image Caption
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'រូបភាពយានយន្ត',
                                style: StyleColor.textStyleKhmerContentAuto(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                'រូបភាពផ្លាកលេខ',
                                style: StyleColor.textStyleKhmerContentAuto(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Images Front
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          dragStartBehavior: DragStartBehavior.start,
                          scrollBehavior: ScrollBehavior(),
                          children: [
                            //Front Camera
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponOut!.vehicleFrontUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponOut!.vehicleFrontUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponOut!.plateFrontUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponOut!.plateFrontUrl!,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Back Camera
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponOut!.vehicleBackUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponOut!.vehicleBackUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (_) => PhotoViewSlideOut(
                                            url: widget.stmReportDataModel
                                                .couponOut!.plateBackUrl!,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ExtensionComponent
                                            .cachedNetworkImage(
                                          height: 150,
                                          url: widget.stmReportDataModel
                                              .couponOut!.plateBackUrl!,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            }(),
            //Company
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ក្រុមហ៊ុន'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.companyName != null
                            ? widget.stmReportDataModel.companyName!
                            : "គ្មានទិន្នន័យ",
                        style: StyleColor.textStyleKhmerContentAuto(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Customer
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('អតិថិជន'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.customerName != null
                            ? widget.stmReportDataModel.customerName!
                            : "គ្មានទិន្នន័យ",
                        style: StyleColor.textStyleKhmerContentAuto(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Zone
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('តំបន់'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.zoneName != null
                            ? widget.stmReportDataModel.zoneName!
                            : "គ្មានទិន្នន័យ",
                        style: StyleColor.textStyleKhmerContentAuto(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Product
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ទំនិញ'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.productName != null
                            ? widget.stmReportDataModel.productName!
                            : "គ្មានទិន្នន័យ",
                        style: StyleColor.textStyleKhmerContentAuto(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Front Plate
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ផ្លាកលេខមុខ',
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                            widget.stmReportDataModel.frontPlateObj != null
                                ? widget.stmReportDataModel.frontPlateObj!
                                    .plateNumberFormatted!
                                : "",
                            style: StyleColor.textStyleKhmerContent)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ប្រភេទផ្លាកមុខ'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.frontPlateObj != null
                            ? widget.stmReportDataModel.frontPlateObj!.nameKh!
                            : "",
                        style: StyleColor.textStyleKhmerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Back Plate
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ផ្លាកលេខក្រោយ',
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                            widget.stmReportDataModel.backPlateObj != null
                                ? widget.stmReportDataModel.backPlateObj!
                                    .plateNumberFormatted!
                                : "",
                            style: StyleColor.textStyleKhmerContent)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ប្រភេទផ្លាកក្រោយ'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.backPlateObj != null
                            ? widget.stmReportDataModel.backPlateObj!.nameKh!
                            : "",
                        style: StyleColor.textStyleKhmerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Station In
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ស្ថានីយចូល',
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                            widget.stmReportDataModel.stationInId != null
                                ? widget.stmReportDataModel.stationInId!
                                : "",
                            style: StyleColor.textStyleKhmerContent)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ទម្ងន់សរុប(គក)'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightIn != null
                            ? widget.stmReportDataModel.weightIn!
                                .toNumberFormat()
                            : "",
                        style: StyleColor.textStyleKhmerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('កាលបរិច្ឆេទចូល'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightInDate != null
                            ? widget.stmReportDataModel.weightInDate!
                                .toDateStandardMPWT()
                            : "",
                        style: StyleColor.textStyleKhmerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Station Out
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ស្ថានីយចេញ',
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                            widget.stmReportDataModel.stationOutId != null
                                ? widget.stmReportDataModel.stationOutId!
                                : "",
                            style: StyleColor.textStyleKhmerContent)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ទម្ងន់សំបក(គក)'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightOut != null
                            ? widget.stmReportDataModel.weightOut!
                                .toNumberFormat()
                            : "",
                        style: StyleColor.textStyleKhmerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.appBarColorOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('កាលបរិច្ឆេទចេញ'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightOutDate != null
                            ? widget.stmReportDataModel.weightOutDate!
                                .toDateStandardMPWT()
                            : "",
                        style: StyleColor.textStyleKhmerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Product
            Container(
              padding: EdgeInsets.all(5),
              color: StyleColor.blueLighterOpa01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('ទម្ងន់ទំនិញសុទ្ឋ(គក)'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightProduct != null
                            ? widget.stmReportDataModel.weightProduct!
                                .toNumberFormat()
                            : "",
                        style: StyleColor.textStyleKhmerContentAuto(bold: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
