import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class UserProfileView extends StatefulWidget {
  UserModel userModel;
  UserProfileView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  File? imageProfile;
  XFile? imageProfileWeb;

  onClickUserProfile() async {
    if (!kIsWeb) {
      imageProfile = await PopupDialog.chooseImageDialog(context);
      if (imageProfile != null) {
        var body = {"image": base64Encode(imageProfile!.readAsBytesSync())};
        var res =
            await Singleton.instance.apiExtension.post<UserModel, UserModel>(
          context: context,
          baseUrl: ApiEndPoint.updateUserProfile,
          deserialize: (e) => UserModel.fromJson(e),
          loading: true,
          body: body,
        );
        if (res.success!) {
          Singleton.instance.token!.user!.image = res.data!.image;
          setState(() {});
        }
      }
    } else {
      imageProfileWeb = await PopupDialog.chooseImageDialogWeb(context);
      if (imageProfileWeb != null) {
        var body = {
          "image": base64Encode(await imageProfileWeb!.readAsBytes())
        };
        var res =
            await Singleton.instance.apiExtension.post<UserModel, UserModel>(
          context: context,
          baseUrl: ApiEndPoint.updateUserProfile,
          deserialize: (e) => UserModel.fromJson(e),
          loading: true,
          body: body,
        );
        if (res.success!) {
          Singleton.instance.token!.user!.image = res.data!.image;
          setState(() {});
        }
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
            'Navigation.Users'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
          backgroundColor: StyleColor.appBarColor,
        ),
        body: SafeArea(
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Label.InfoUser'.tr(),
                style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 20),
                textAlign: TextAlign.center,
              ),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Stack(
                          children: [
                            () {
                              if (imageProfile == null &&
                                  imageProfileWeb == null)
                                return ExtensionComponent.cachedNetworkImage(
                                  url: widget.userModel.image ?? "",
                                  profile: false,
                                );
                              else if (imageProfile != null)
                                return Image.file(
                                  imageProfile!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                );
                              else if (imageProfileWeb != null) {
                                return Image.network(
                                  imageProfileWeb!.path,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                );
                              } else
                                return Container();
                            }(),
                            InkWell(
                              onTap: onClickUserProfile,
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey.withOpacity(0.6),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
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
                              widget.userModel.fullNameKh.toString(),
                              style: StyleColor.textStyleKhmerDangrekAuto(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'ID: ${widget.userModel.id}',
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
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: StyleColor.appBarColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                                widget.userModel.id.toString(),
                                style: StyleColor.textStyleKhmerContentAuto(
                                  bold: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.appBarColorOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Label.UserName'.tr(),
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.username ?? "",
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
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.blueLighterOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Label.FullName'.tr() + '៖',
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.fullNameKh,
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
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.appBarColorOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Label.FullNameEn'.tr(),
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.fullNameEn,
                                style: TextStyle(
                                  fontFamily: 'Khmer OS Content',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.blueLighterOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Hint.Org'.tr() + '៖',
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.org ?? "",
                                style: StyleColor.textStyleKhmerContentAuto(
                                  bold: true,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.appBarColorOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Hint.Position'.tr() + '៖',
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.position ?? "",
                                style: StyleColor.textStyleKhmerContentAuto(
                                  bold: true,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.blueLighterOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Hint.PhoneNumber'.tr() + '៖',
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.phoneNumber ?? "",
                                style: StyleColor.textStyleKhmerContentAuto(
                                  bold: true,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.appBarColorOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Label.DateRegister'.tr(),
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.createdTime == null
                                    ? ""
                                    : widget.userModel.createdTime!
                                        .toDateStandardMPWT(),
                                style: StyleColor.textStyleKhmerContentAuto(
                                  bold: true,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: StyleColor.blueLighterOpa01,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text('Label.ApprovedRegister'.tr(),
                                    style: StyleColor
                                        .textStyleKhmerContent14Grey)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.userModel.approvedTime == null
                                    ? ""
                                    : widget.userModel.approvedTime!
                                        .toDateStandardMPWT(),
                                style: StyleColor.textStyleKhmerContentAuto(
                                  bold: true,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                'Role.RolePermission'.tr(),
                style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: widget.userModel.type == "DEV"
                    ? Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: StyleColor.appBarColorOpa01,
                        ),
                        child: Text(
                          'Role.RoleAdmin'.tr(),
                          style: StyleColor.textStyleKhmerContentAuto(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : widget.userModel.role != null &&
                            widget.userModel.role!.length > 0
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: widget.userModel.role!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: (index % 2) == 0
                                          ? StyleColor.blueLighterOpa01
                                          : StyleColor.appBarColorOpa01,
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            child: Text(
                                              (index + 1).toString(),
                                              style: StyleColor
                                                  .textStyleKhmerDangrekAuto(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.userModel.role![index]
                                                      .roleName ??
                                                  "",
                                              style: StyleColor
                                                  .textStyleKhmerContentAuto(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: StyleColor.appBarColorOpa01,
                            ),
                            child: Text(
                              'Role.NullPermission'.tr(),
                              style: StyleColor.textStyleKhmerContentAuto(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
