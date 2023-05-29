import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Report/STMReportDetailModel.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';

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
            //Images
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
                            url: widget
                                .stmReportDataModel.couponIn!.vehicleFrontUrl!,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ExtensionComponent.cachedNetworkImage(
                          height: 150,
                          url: widget
                              .stmReportDataModel.couponIn!.vehicleFrontUrl!,
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
                            url: widget
                                .stmReportDataModel.couponIn!.plateFrontUrl!,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ExtensionComponent.cachedNetworkImage(
                          height: 150,
                          url: widget
                              .stmReportDataModel.couponIn!.plateFrontUrl!,
                        ),
                      ),
                    ),
                  )
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
                            widget.stmReportDataModel.frontPlateObj!
                                .plateNumberFormatted!,
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
                        child: Text('ប្រភេទផ្លាក'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.frontPlateObj!.nameKh ?? "",
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
                        child: Text(widget.stmReportDataModel.stationInId!,
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
                        child: Text('ទម្ងន់ចូល(គក)'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightIn!.toNumberFormat(),
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
                        widget.stmReportDataModel.weightInDate!
                            .toDateStandardMPWT(),
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
                        child: Text(widget.stmReportDataModel.stationOutId!,
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
                        child: Text('ទម្ងន់ចេញ(គក)'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightOut!.toNumberFormat(),
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
                        widget.stmReportDataModel.weightOutDate!
                            .toDateStandardMPWT(),
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
                        child: Text('ទម្ងន់ទំនិញ(គក)'.tr(),
                            style: StyleColor.textStyleKhmerContent14Grey)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.stmReportDataModel.weightProduct!
                            .toNumberFormat(),
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
