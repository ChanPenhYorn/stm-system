import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/OTP/OTPModel.dart';
import 'package:stm_report_app/Entity/OTP/Post/OTPPostModel.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Home/Web/Dashboard_Web.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmOTP extends StatefulWidget {
  final UserModel userModel;
  ConfirmOTP({
    super.key,
    required this.userModel,
  });

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  TextEditingController otpCon = TextEditingController();

  checkOTPCode(String otp) {}

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
                        'ផ្ទៀងផ្ទាត់លេខកូដ',
                        style: StyleColor.textStyleKhmerDangrek18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PinCodeTextField(
                        controller: otpCon,
                        autoFocus: true,
                        appContext: context,
                        pinTheme: PinTheme(
                            inactiveColor: StyleColor.appBarColor,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8.0)),
                        length: 6,
                        onCompleted: verifyOTP,
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                        enablePinAutofill: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(0),
                        clipBehavior: Clip.antiAlias,
                        onPressed: () async {
                          verifyOTP(otpCon.text);
                        },
                        child: Text(
                          "Button.Submit".tr(),
                          style: StyleColor.textStyleKhmerDangrek18,
                          textAlign: TextAlign.center,
                        ),
                        color: StyleColor.appBarColor,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void verifyOTP(String otp) async {
    var body = OTPPostModel(
            udid: Singleton.instance.udid,
            phoneNumber: widget.userModel.phoneNumber,
            otpCode: otp)
        .toJson();
    var res = await Singleton.instance.apiExtension.post<OTPModel, OTPModel>(
      loading: true,
      body: body,
      context: context,
      baseUrl: ApiEndPoint.submitOtp,
      deserialize: (e) => OTPModel.fromJson(e),
    );
    if (res.success! == true) {
      await PopupDialog.showSuccess(context,
          content: "លេខសំងាត់របស់លោកអ្នកគឺ ${otp}");
      var body = {
        "username": widget.userModel.phoneNumber,
        "password": otp,
        "udid": Singleton.instance.udid,
      };
      var res = await Singleton.instance.apiExtension.userLogin(context, body);

      if (res.success!) {
        // 2F8764E3-E5D8-4CD9-BC32-A59031B8B72F
        Singleton.instance.writeUserLoginCache(
          username: "${widget.userModel.phoneNumber}",
          password: "$otp",
        );
        Singleton.instance.token = res.data!;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (e) => Dashboard()), (route) => false);
      }
    } else {
      print("err: ${res.description}");
      PopupDialog.showPopup(
          context,
          res.description == ""
              ? "លេខកូដផ្ទៀងផ្ទាត់មិនត្រឹមត្រូវ"
              : res.description!,
          success: 0);
      // if (res.description == "Invalid input value") {
      //   PopupDialog.showPopup(context, "Message.Account.InvalidCredential".tr(),
      //       success: 0);
      //   return;
      // } else {
      //   PopupDialog.showPopup(context, .tr(), success: 0);
      // }
    }
  }
}
