import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Product/ProductModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class ProductEdit extends StatefulWidget {
  final ProductModel productModel;
  ProductEdit({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  @override
  void initState() {
    // TODO: implement initState
    nameEnCon.text = widget.productModel.nameEn ?? "";
    nameKhCon.text = widget.productModel.nameKh ?? "";
    descriptionCon.text = widget.productModel.description ?? "";
    super.initState();
  }

  TextEditingController nameEnCon = TextEditingController();
  TextEditingController nameKhCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  String logoBase64 = "";
  File? imageProfile;
  XFile? imageProfileWeb;
  final _formKey = GlobalKey<FormState>();

  onClickSubmit() async {
    bool available = _formKey.currentState!.validate();
    if (available) {
      var prompt = await PopupDialog.yesNoPrompt(context);
      if (prompt) {
        var body = ProductModel(
          code: widget.productModel.code,
          nameEn: nameEnCon.text.trim(),
          nameKh: nameKhCon.text.trim(),
          image: logoBase64,
        ).toJson();
        var res = await Singleton.instance.apiExtension.post<String, String>(
            context: context,
            loading: true,
            baseUrl: ApiEndPoint.productUpdate,
            body: body,
            deserialize: (e) => e.toString());
        if (res.success!) {
          await PopupDialog.showSuccess(context, data: true, layerContext: 2);
        } else
          PopupDialog.showFailed(context, data: false);
      }
    }
  }

  onClickUserProfile() async {
    if (!kIsWeb) {
      imageProfile = await PopupDialog.chooseImageDialog(context);
      if (imageProfile != null) {
        logoBase64 = base64Encode(await imageProfile!.readAsBytes());
      }
    } else {
      imageProfileWeb = await PopupDialog.chooseImageDialogWeb(context);
      if (imageProfileWeb != null) {
        logoBase64 = base64Encode(await imageProfileWeb!.readAsBytes());
      }
    }
  }

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
            'Navigation.Product'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
          backgroundColor: StyleColor.appBarColor,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Singleton.instance.largeScreenWidthConstraint,
            ),
            alignment: Alignment.topCenter,
            child: Form(
              key: _formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    'Navigation.ProductEntity.Info'.tr(),
                    style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        () {
                          if (imageProfile != null)
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                imageProfile!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            );
                          else if (imageProfileWeb != null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageProfileWeb!.path,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else
                            return Container();
                        }(),
                        InkWell(
                          onTap: onClickUserProfile,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.withOpacity(0.6),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //Panel
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: StyleColor.appBarColor.withOpacity(0.5),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Customer Last Name
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('ឈ្មោះទំនិញ (ខ្មែរ)'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: nameKhCon,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        StyleColor.textStyleKhmerContent12Red,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: StyleColor.appBarColor),
                                    ),
                                    hintStyle:
                                        StyleColor.textStyleKhmerDangrekAuto(
                                            color: Colors.grey),
                                    hintText: 'នាមត្រកូល'.tr(),
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 13,
                                        right: 10,
                                        bottom: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Name En
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('ឈ្មោះទំនិញ (អង់គ្លេស)'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: nameEnCon,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        StyleColor.textStyleKhmerContent12Red,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: StyleColor.appBarColor),
                                    ),
                                    hintStyle:
                                        StyleColor.textStyleKhmerDangrekAuto(
                                            color: Colors.grey),
                                    hintText: 'នាមខ្លួន'.tr(),
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 13,
                                        right: 10,
                                        bottom: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Product Description
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.appBarColorOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('បរិយាយ'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: descriptionCon,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        StyleColor.textStyleKhmerContent12Red,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: StyleColor.appBarColor),
                                    ),
                                    hintStyle:
                                        StyleColor.textStyleKhmerDangrekAuto(
                                            color: Colors.grey),
                                    hintText: 'បរិយាយ'.tr(),
                                    prefixIcon: Icon(Icons.description),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 13,
                                        right: 10,
                                        bottom: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Button
                  Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: StyleColor.appBarColor,
                          splashFactory: InkRipple.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            'Button.Submit'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        onPressed: onClickSubmit,
                      ),
                    ],
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
