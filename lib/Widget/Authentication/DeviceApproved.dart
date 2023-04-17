import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/OTP/OTPModel.dart';
import 'package:stm_report_app/Entity/OTP/Post/OTPPostModel.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Authentication/ConfirmOTP.dart';
import 'package:stm_report_app/Widget/Setting/User/User.dart';

class DeviceApproved extends StatefulWidget {
  final UserModel User;
  const DeviceApproved({required this.User, super.key});

  @override
  State<DeviceApproved> createState() => _DeviceApprovedState();
}

class _DeviceApprovedState extends State<DeviceApproved> {
  TextEditingController phoneCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    phoneCon.text = MaskTextInputFormatter(mask: "### ### ### #")
        .maskText(widget.User.phoneNumber!);
    super.initState();
  }

  onClickSubmit() async {
    var body = OTPPostModel(
            phoneNumber: widget.User.phoneNumber, udid: Singleton.instance.udid)
        .toJson();
    var res = await Singleton.instance.apiExtension.post<OTPModel, OTPModel>(
        body: body,
        context: context,
        loading: true,
        baseUrl: ApiEndPoint.requestOtp,
        deserialize: (e) => OTPModel.fromJson(e));
    if (res.success!) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ConfirmOTP(
            userModel: widget.User,
          ),
        ),
      );
    } else {
      print("Error Messsage : ${res.description}");
      PopupDialog.showFailed(context,
          content: res.description == null || res.description == ""
              ? "Message.ServerError".tr()
              : res.description!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/image/login_background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
              child: Center(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    child: Image.asset(
                      'assets/image/stm_report_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'បើកដំណើរការគណនី',
                      style: StyleColor.textStyleKhmerDangrek18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      style: StyleColor.textStyleKhmerContent,
                      controller: phoneCon,
                      // maxLength: 10,
                      validator: (value) {
                        value = value!.replaceAll(" ", "");
                        String pattern = r'^\$?(([1-9]\d{0,2}(,\d{3})*)|0)';
                        RegExp regExp = RegExp(pattern);
                        if (value.isEmpty) {
                          return 'Message.PleaseInputPhoneNumber'.tr();
                        } else if (!regExp.hasMatch(value) ||
                            value.length < 9) {
                          return "Message.PleaseInputCorrectly".tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      // enabled: false,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: "### ### ### #",
                            initialText: widget.User.phoneNumber!)
                      ],
                      enabled: false,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        errorStyle: StyleColor.textStyleKhmerContent12Red,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 2, color: StyleColor.appBarColor),
                        ),
                        hintStyle: StyleColor.textStyleKhmerDangrekAuto(
                            color: Colors.grey),
                        hintText: 'លេខទូរស័ព្ទ',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(0),
                      clipBehavior: Clip.antiAlias,
                      onPressed: onClickSubmit,
                      child: Text(
                        "Button.Submit".tr(),
                        style: StyleColor.textStyleKhmerDangrek18,
                        textAlign: TextAlign.center,
                      ),
                      color: StyleColor.appBarColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
