import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Authentication/Register.dart';

class Login extends StatefulWidget {
  int faceIdScanDelay = 0;
  bool isLoggedOut = false;
  Login({Key? key, this.faceIdScanDelay = 0, this.isLoggedOut = false})
      : super(key: key);
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    usernameInputController.text = "khdev";
    passwordInputController.text = "silverhong";
    initPermissionAndData();
    InitUserModels = initUserModels();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  // final Connectivity _connectivity = Connectivity();
  // ConnectivityResult? result;
  bool _passwordVisible = false;
  Future? InitConnection;
  List<UserModel> userModels = [];

  Future initPermissionAndData() async {
    Singleton.instance.apiExtension.getConnectionInit(context, noLoading: true);

    // await initUDID();
    // await initOTPActivation();
    await Singleton.instance.initUserLoginCache();
    await Singleton.instance.requestPermission(context);
    await Singleton.instance.initFaceIdPermission();
    await Singleton.instance.checkBiometrics();
    await Singleton.instance.initLocalStorage();
    await Singleton.instance.initUserLoginCache();

    usernameInputController.text =
        Singleton.instance.userAccountCache.username!;
    if (widget.isLoggedOut == false) {
      var auth = await Singleton.instance.authenticate();
      if (auth) {
        loginUser(authenticated: true);
      }
    }
  }

  void loginUser({required bool authenticated}) async {
    if (checkInput(authenticated)) {
      var body;
      if (authenticated) {
        body = {
          "username": Singleton.instance.userAccountCache.username,
          "password": Singleton.instance.userAccountCache.password,
          "udid": Singleton.instance.udid,
        };
      } else {
        body = {
          "username": usernameInputController.text.trim(),
          "password": passwordInputController.text,
          "udid": Singleton.instance.udid,
        };
      }
      var res = await Singleton.instance.apiExtension.userLogin(context, body);
      if (res.success!) {
        if (!authenticated) {
          await Singleton.instance.writeUserLoginCache(
              username: usernameInputController.text.trim(),
              password: passwordInputController.text);
        }
        Singleton.instance.token = res.data!;
        widget.isLoggedOut = false;
        // Navigat
        context.pushReplacement('/dashboard');
      } else {
        if (res.description!.trim() == "Invalid input value") {
          PopupDialog.showPopup(
            context,
            "Message.Account.InvalidCredential".tr(),
            success: 0,
          );
          return;
        } else if (res.description!.trim() == "Reviewing Account") {
          PopupDialog.showPopup(
            context,
            "Message.Account.ReviewingAccount".tr(),
            success: 0,
          );
          return;
        } else if (res.description!.trim() == "Suspended Account") {
          PopupDialog.showPopup(
            context,
            "Message.Account.SuspendedAccount".tr(),
            success: 0,
          );
          return;
        } else if (res.description!.trim() == "Please input password,") {
          PopupDialog.showPopup(
            context,
            "Message.Account.InvalidCredential".tr(),
            success: 0,
          );
          return;
        } else if (res.description!.trim() == "Wrong UDID") {
          PopupDialog.showPopup(
            context,
            "ឧបករណ៍មិនទទួលបានការអនុញ្ញាត".tr(),
            success: 0,
          );
          return;
        } else if (res.description!.trim() == "Invalid User Credentials") {
          PopupDialog.showPopup(
            context,
            "Message.Account.InvalidCredential".tr(),
            success: 0,
          );
          return;
        } else {
          PopupDialog.showPopup(context, "Message.ServerError".tr(),
              success: 0);
        }
      }
    }
  }

  bool checkInput(bool authenticated) {
    if (authenticated) {
      if (Singleton.instance.userAccountCache.username!.length == 0) {
        PopupDialog.showPopup(context, "Message.PleaseInputUsername".tr(),
            success: 2);
        return false;
      } else if (Singleton.instance.userAccountCache.password!.length == 0) {
        PopupDialog.showPopup(context, "Message.PleaseInputPassword".tr(),
            success: 2);
        return false;
      } else {
        return true;
      }
    } else {
      if (usernameInputController.text.length == 0) {
        PopupDialog.showPopup(context, "Message.PleaseInputUsername".tr(),
            success: 2);
        return false;
      } else if (passwordInputController.text.length == 0) {
        PopupDialog.showPopup(context, "Message.PleaseInputPassword".tr(),
            success: 2);
        return false;
      } else {
        return true;
      }
    }
  }

  Future<void> initUserModels() async {
    var res = await Singleton.instance.apiExtension
        .get<List<UserModel>, UserModel>(
            param: "udid=${Singleton.instance.udid}",
            context: context,
            baseUrl: ApiEndPoint.getFormApproval,
            deserialize: (e) => UserModel.fromJson(e));
    // print("res.data : ${res.data!}");
    if (res.data!.length != 0) {
      userModels = res.data!;
    }
  }

  Future<void>? InitUserModels;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Extension.clearFocus(context);
    // loginUser(authenticated: false);

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
          alignment: Alignment.center,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // Expanded(child: SizedBox()),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'assets/image/stm_report_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: Singleton.instance.apiExtension.GetConnection,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Container(
                                constraints: BoxConstraints(maxWidth: 400),
                                margin: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextField(
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: usernameInputController,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: StyleColor.appBarColor,
                                              ),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrek16,
                                            hintText: 'Login.phoneNumber'.tr(),
                                            prefixIcon: Icon(Icons.phone,
                                                color: StyleColor.appBarColor),
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
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextField(
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: passwordInputController,
                                          obscureText: !_passwordVisible,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.security,
                                              color: StyleColor.appBarColor,
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrek16,
                                            hintText: 'Login.password'.tr(),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                              left: 10,
                                              top: 13,
                                              right: 10,
                                              bottom: 15,
                                            ),
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
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    MaterialButton(
                                      minWidth: double.infinity,
                                      height: 50,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(0),
                                      clipBehavior: Clip.antiAlias,
                                      onPressed: () async {
                                        Extension.clearFocus(context);
                                        loginUser(authenticated: false);
                                      },
                                      child: Text(
                                        "Button.Login".tr(),
                                        style:
                                            StyleColor.textStyleKhmerDangrek18,
                                        textAlign: TextAlign.center,
                                      ),
                                      color: StyleColor.appBarColor,
                                      textColor: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                Register(),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 200),
                                          ),
                                        );
                                        await initPermissionAndData();
                                        InitUserModels = initUserModels();
                                      },
                                      child: Text(
                                        "Button.Register".tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 16,
                                          color: StyleColor.appBarColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    "Message.ServerConnectionError".tr(),
                                    style: StyleColor.textStyleKhmerDangrek18,
                                    textAlign: TextAlign.center,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: StyleColor.appBarColor,
                                      ),
                                      onPressed: () {
                                        // Singleton.instance.apiExtension
                                        //     .getConnectionInit(context,
                                        //         noLoading: true);
                                        // setState(() {});
                                      },
                                      child: Text(
                                        "Button.TryAgain".tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                                fontSize: 16,
                                                color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                          }
                          return AnimateLoading();
                        },
                      )
                    ],
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
