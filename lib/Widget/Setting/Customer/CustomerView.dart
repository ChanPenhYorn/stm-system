import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Customer/CustomerModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';
import 'package:stm_report_app/Widget/Setting/Customer/Edit/CustomerEdit.dart';

// ignore: must_be_immutable
class CustomerView extends StatefulWidget {
  CustomerModel customerModel;
  CustomerView({Key? key, required this.customerModel}) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Extension.clearFocus(context);
        Singleton.instance.handleUserInteraction(context);
      },
      onPanDown: (_) {
        Singleton.instance.handleUserInteraction(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Navigation.Customer'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
          backgroundColor: StyleColor.appBarColor,
          actions: [
            () {
              if (Extension.getPermissionByActivity(
                      activiyName: "Customer", activityEn: true)
                  .UPDATE) {
                return InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerEdit(
                          customerModel: widget.customerModel,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Label.Edit'.tr(),
                          style: StyleColor.textStyleKhmerContent14White,
                        )
                      ],
                    ),
                  ),
                );
              } else
                return Container();
            }()
          ],
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Singleton.instance.largeScreenWidthConstraint,
              ),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: StyleColor.appBarColorOpa01,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showDialog(
                                useSafeArea: false,
                                context: context,
                                builder: (_) => PhotoViewSlideOut(
                                  url: widget.customerModel.imagePath ?? "",
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: ExtensionComponent.cachedNetworkImage(
                                url: widget.customerModel.imagePath ?? "",
                                profile: false,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.customerModel.fullName.toString(),
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ID: ${widget.customerModel.code}',
                                  style: StyleColor.textStyleKhmerContentAuto(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  //Panel
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: StyleColor.appBarColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Code
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.Code'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                        widget.customerModel.code.toString(),
                                        style:
                                            StyleColor.textStyleKhmerContent)),
                              ),
                            ],
                          ),
                        ),

                        //Customer Full Name
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('ឈ្មោះអតិថិជន'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.customerModel.fullName ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Khmer OS Content',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Description
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.appBarColorOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.Description'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.customerModel.description ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Khmer OS Content',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Address
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.Address'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.customerModel.address ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Khmer OS Content',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Phone Number
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.PhoneNumber'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.customerModel.phoneNumber ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Khmer OS Content',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
