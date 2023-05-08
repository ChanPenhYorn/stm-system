import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/QRForm/QRFormModel.dart';
import 'package:stm_report_app/Entity/Role/RoleModel.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Role/Dialog/RoleSelectionDialog.dart';

class UserApprovalViewEditing extends StatefulWidget {
  UserModel userModel;
  UserApprovalViewEditing({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<UserApprovalViewEditing> createState() =>
      _UserApprovalViewEditingState();
}

class _UserApprovalViewEditingState extends State<UserApprovalViewEditing> {
  @override
  void initState() {
    // TODO: implement initState
    widget.userModel.username = widget.userModel.phoneNumber;
    firstNameKhCon.text = widget.userModel.firstNameKh ?? "";
    lastNameKhCon.text = widget.userModel.lastNameKh ?? "";
    firstNameEnCon.text = widget.userModel.firstNameEn ?? "";
    lastNameEnCon.text = widget.userModel.lastNameEn ?? "";
    positionCon.text = widget.userModel.position ?? "";
    orgCon.text = widget.userModel.org ?? "";
    phoneCon.text = widget.userModel.phoneNumber ?? "";
    super.initState();
  }

  TextEditingController firstNameKhCon = TextEditingController();
  TextEditingController lastNameKhCon = TextEditingController();
  TextEditingController firstNameEnCon = TextEditingController();
  TextEditingController lastNameEnCon = TextEditingController();
  TextEditingController positionCon = TextEditingController();
  TextEditingController orgCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<RoleModel> listRole = [];
  File? attachment;

  onClickSubmit() async {
    bool available = _formKey.currentState!.validate();
    if (available && listRole.length > 0
        // && attachment != null
        ) {
      var prompt = await PopupDialog.yesNoPrompt(context);
      if (prompt) {
        widget.userModel.firstNameKh = firstNameKhCon.text.trim();
        widget.userModel.lastNameKh = lastNameKhCon.text.trim();
        widget.userModel.firstNameEn = firstNameEnCon.text.trim();
        widget.userModel.lastNameEn = lastNameEnCon.text.trim();
        widget.userModel.position = positionCon.text.trim();
        widget.userModel.org = orgCon.text.trim();
        widget.userModel.phoneNumber = phoneCon.text.trim();
        widget.userModel.role = listRole;
        widget.userModel.approved = 1;
        if (attachment != null) {
          widget.userModel.formAttachment =
              base64Encode(attachment!.readAsBytesSync());
        }
        var body = widget.userModel.toJson();
        var res = await Singleton.instance.apiExtension.post<String, String>(
            context: context,
            loading: true,
            baseUrl: ApiEndPoint.userApproval,
            body: body,
            deserialize: (e) => e.toString());
        if (res.success!) {
          await PopupDialog.showSuccess(context, data: true, layerContext: 3);
        } else
          PopupDialog.showFailed(context, data: false);
      }
    } else if (listRole.length == 0) {
      PopupDialog.showPopup(
          context, "Message.RoleUser.PleaseSelectRoleUser".tr(),
          success: 2);
    }
    // else if (attachment == null) {
    //   PopupDialog.showPopup(
    //       context, "Message.FormPDF.PleaseUploadDocument".tr(),
    //       success: 2);
    // }
  }

  onClickAddRole() async {
    var result = await showDialog<List<RoleModel>>(
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 10,
          insetPadding: EdgeInsets.all(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: RoleSelectionDialog(),
        );
      },
    );
    if (result!.length > 0) {
      listRole.clear();
      listRole.addAll(result);
    }
    setState(() {});
  }

  onClickDeleteRole(RoleModel role) {
    listRole.remove(role);
    setState(() {});
  }

  onClickAddAttachment() async {
    var file = await PopupDialog.chooseImageDialog(context);
    if (file != null) {
      String? result = await Singleton.instance.getQRData(file.path);
      print("result : $result");
      if (result != "") {
        var res = await Singleton.instance.apiExtension.post<String, String>(
          loading: true,
          context: context,
          baseUrl: ApiEndPoint.decryptQR,
          body: {"code": result},
          deserialize: (e) => e.toString(),
        );
        print("res.description : ${res.description!}");
        if (res.success!) {
          res.data = res.data!.replaceAll("'\'", "");
          var jsonData = json.decode(res.data!);
          QRFormModel qrFormModel = QRFormModel.fromJson(jsonData);
          if (qrFormModel.userModel!.id != widget.userModel.id) {
            PopupDialog.showFailed(context,
                content: "Message.FormPDF.InvalidDocument".tr());
          } else {
            attachment = file;
            setState(() {});
          }
        } else {
          PopupDialog.showFailed(context,
              content: "Message.FormPDF.InvalidDocument".tr());
        }
      } else {
        PopupDialog.showFailed(context,
            content: "Message.FormPDF.InvalidDocument".tr());
      }
    }
  }

  Widget buildRoleChip() {
    List<Widget> listChip = [];
    listRole.forEach((element) {
      listChip.add(Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: InputChip(
          padding: EdgeInsets.all(5.0),
          label: Text(
            element.roleName!,
            style: TextStyle(color: Colors.black),
          ),
          deleteIconColor: StyleColor.appBarColor,
          backgroundColor: StyleColor.blueLighter.withOpacity(0.5),
          selected: false,
          onDeleted: () {
            onClickDeleteRole(element);
          },
        ),
      ));
    });
    if (listChip.length > 0)
      return Wrap(
        children: listChip,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
      );
    else
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
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
      );
  }

  Widget buildAttachment() {
    if (attachment != null && attachment!.path != "")
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: StyleColor.appBarColorOpa01,
        ),
        child: Image.file(
          File(attachment!.path),
        ),
      );
    else
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: StyleColor.appBarColorOpa01,
        ),
        child: Text(
          'Label.NoReferences'.tr(),
          style: StyleColor.textStyleKhmerContentAuto(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
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
            'Label.Register'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
          backgroundColor: StyleColor.appBarColor,
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Singleton.instance.largeScreenWidthConstraint,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Label.RegisterInfo'.tr(),
                    style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 20),
                    textAlign: TextAlign.center,
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Hint.UserName'.tr() + '៖',
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regExp = RegExp(
                                        r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputLastNameKH"
                                          .tr();
                                    } else if (!regExp.hasMatch(value)) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: lastNameKhCon,
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
                                    hintText: 'Hint.UserName'.tr(),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.appBarColorOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.Name'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regExp = RegExp(
                                        r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputLastNameKH"
                                          .tr();
                                    } else if (!regExp.hasMatch(value)) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: firstNameKhCon,
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
                                    hintText: 'Hint.Name'.tr(),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.UserNameEn'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regExp = RegExp(r"^[a-zA-Z]");
                                    if (value!.isEmpty) {
                                      return 'Message.PleaseInputLastNameEN'
                                          .tr();
                                    } else if (!regExp.hasMatch(value)) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: lastNameEnCon,
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
                                    hintText: 'Hint.UserNameEn'.tr(),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.appBarColorOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.NameEn'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regExp = RegExp(r"^[a-zA-Z]");

                                    if (value!.isEmpty) {
                                      return 'Message.PleaseInputFirstNameEN'
                                          .tr();
                                    } else if (!regExp.hasMatch(value)) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: firstNameEnCon,
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
                                    hintText: 'Hint.NameEn'.tr(),
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Hint.Org'.tr() + '៖',
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regExp = RegExp(
                                        r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                    if (value!.isEmpty) {
                                      return 'Message.PleaseInputOrg'.tr();
                                    } else if (!regExp.hasMatch(value) ||
                                        value.contains(RegExp("[A-Za-z]"))) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: orgCon,
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
                                    hintText: 'Hint.Org'.tr(),
                                    prefixIcon: Icon(Icons.business_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.appBarColorOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Hint.Position'.tr() + '៖',
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regExp = RegExp(
                                        r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputPosition".tr();
                                    } else if (!regExp.hasMatch(value) ||
                                        value.contains(RegExp("[A-Za-z]"))) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: positionCon,
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
                                    hintText: 'Hint.Position'.tr(),
                                    prefixIcon: Icon(Icons.work_outline),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Hint.PhoneNumber'.tr() + '៖',
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: phoneCon,
                                  maxLength: 10,
                                  validator: (value) {
                                    String pattern =
                                        r'^\$?(([1-9]\d{0,2}(,\d{3})*)|0)';
                                    RegExp regExp = RegExp(pattern);
                                    if (value!.isEmpty) {
                                      return 'Message.PleaseInputPhoneNumber'
                                          .tr();
                                    } else if (!regExp.hasMatch(value)) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    counter: Offstage(),
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
                                    hintText: 'Hint.PhoneNumber'.tr(),
                                    prefixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.CodeDevice'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.userModel.udid ?? "",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      ],
                    ),
                  ),

                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Role.RolePermission'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: StyleColor.appBarColor,
                            ),
                            onPressed: () {
                              onClickAddRole();
                            }),
                      ),
                    ],
                  ),
                  //Role
                  buildRoleChip(),

                  //Button
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
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
                            'Button.Approve'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        onPressed: onClickSubmit,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
