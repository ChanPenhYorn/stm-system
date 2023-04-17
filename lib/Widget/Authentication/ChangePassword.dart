import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordCon = TextEditingController();
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Extension.clearFocus(context);
        Singleton.instance.handleUserInteraction(context);
      },
      onPanDown: (_) {
        Singleton.instance.handleUserInteraction(context);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: StyleColor.appBarColor,
            title: Text(
              "ChangePassword.ChangePassword".tr(),
              style: StyleColor.textStyleKhmerDangrek18,
            ),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  constraints: BoxConstraints(maxWidth: 750),
                  width: double.infinity,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: StyleColor.appBarColor,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Message.PleaseInputPassword".tr();
                        } else if (value.trim().length < 6) {
                          return "Message.PasswordMoreThan6Char".tr();
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: StyleColor.textStyleKhmerContent14,
                      controller: oldPassword,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: "ChangePassword.CurrentPassword".tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  constraints: BoxConstraints(maxWidth: 750),
                  width: double.infinity,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: StyleColor.appBarColor,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Message.PleaseInputPassword".tr();
                        } else if (value.trim().length < 6) {
                          return "Message.PasswordMoreThan6Char".tr();
                        } else if (value.trim() != newPasswordCon.text.trim()) {
                          return "Message.InvalidSamePassword".tr();
                        } else if (value.trim() == oldPassword.text.trim()) {
                          return "Message.InvalidNewPassword".tr();
                        }
                        return null;
                      },
                      style: StyleColor.textStyleKhmerContent14,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: StyleColor.appBarColor,
                      obscureText: !_passwordVisible,
                      controller: newPassword,
                      decoration: InputDecoration(
                        labelText: "ChangePassword.NewPassword".tr(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  constraints: BoxConstraints(maxWidth: 750),
                  width: double.infinity,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Message.PleaseInputPassword".tr();
                      } else if (value.trim().length < 6) {
                        return "Message.PasswordMoreThan6Char".tr();
                      } else if (value.trim() != newPassword.text.trim()) {
                        return "Message.InvalidSamePassword".tr();
                      } else if (value.trim() == oldPassword.text.trim()) {
                        return "Message.InvalidNewPassword".tr();
                      }
                      return null;
                    },
                    style: StyleColor.textStyleKhmerContent14,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: StyleColor.appBarColor,
                    controller: newPasswordCon,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: "ChangePassword.RetypeNewPassword".tr(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50,
                      minWidth: 100,
                      textColor: Colors.white,
                      color: Colors.grey,
                      disabledColor: Colors.grey,
                      child: Text(
                        "Button.Cancel".tr(),
                        style: StyleColor.textStyleKhmerContent,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50,
                      minWidth: 100,
                      textColor: Colors.white,
                      color: StyleColor.appBarColor,
                      disabledColor: Colors.grey,
                      child: Text(
                        "Button.Submit".tr(),
                        style: StyleColor.textStyleKhmerContent,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (oldPassword.text.length == 0 ||
                              newPassword.text.length == 0 ||
                              newPasswordCon.text.length == 0) {
                            PopupDialog.showPopup(
                                context, "Message.InvalidInfo".tr(),
                                success: 2);
                          } else if (newPassword.text != newPasswordCon.text) {
                            PopupDialog.showPopup(
                                context, "Message.InvalidSamePassword".tr(),
                                success: 2);
                          } else if (oldPassword.text == newPassword.text) {
                            PopupDialog.showPopup(
                                context, "Message.InvalidNewPassword".tr(),
                                success: 2);
                          } else {
                            var prompt = await PopupDialog.yesNoPrompt(context);
                            if (prompt) {
                              // final body = EntityChangePassword.ChangePassword(
                              //         oldpassword: oldPassword.text,
                              //         newpassword: newPassword.text)
                              //     .toJson();
                              var body = {
                                "old_password": oldPassword.text.trim(),
                                "password": newPassword.text.trim(),
                                "confirm_password": newPasswordCon.text.trim(),
                              };
                              final res = await Singleton.instance.apiExtension
                                  .postChangePassword(context, body);

                              if (res.success!) {
                                await Singleton.instance
                                    .clearUserPasswordCache();
                                PopupDialog.showPopup(
                                    context,
                                    res.description ??
                                        "Message.OperationSuccess".tr(),
                                    success: 1,
                                    pushToLogin: true,
                                    data: true);
                              } else {
                                PopupDialog.showPopup(
                                    context,
                                    res.description ??
                                        "Message.OperationFailed".tr(),
                                    success: 0);
                              }
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
