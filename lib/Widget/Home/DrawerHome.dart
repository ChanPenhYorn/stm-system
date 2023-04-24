import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stm_report_app/Extension/AppRoute.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Authentication/Login.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';
import 'package:stm_report_app/Widget/Setting/User/UserProfileView.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: Text(
            'STM Report',
            style: StyleColor.textStyleDefaultAuto(
              fontSize: 18,
              bold: true,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
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
                        url: Singleton.instance.token!.user!.image ?? "",
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: Color.fromRGBO(192, 192, 192, 0.2),
                      height: 60,
                      width: 60,
                      child: ExtensionComponent.cachedNetworkImage(
                        url: Singleton.instance.token!.user!.image ?? "",
                        profile: true,
                      ),
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
                        Singleton.instance.token!.user!.lastNameKh.toString() +
                            " " +
                            Singleton.instance.token!.user!.firstNameKh
                                .toString(),
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ID: ${Singleton.instance.token!.user!.id}',
                        style: StyleColor.textStyleKhmerContentAuto(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(color: Colors.grey.withOpacity(0.5)),
        //Button
        Container(
          // color: Colors.grey.shade300,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      right: 10,
                    ),
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserProfileView(
                          userModel: Singleton.instance.token!.user!,
                        ),
                      ),
                    );
                    // context.push(AppRoute.userProfile,
                    //     extra: Singleton.instance.token!.user!);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "UserSetting.PersonalInformation".tr(),
                        style: StyleColor.textStyleKhmerContentAuto(
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      right: 10,
                    ),
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => ChangePassword(),
                    //   ),
                    // );
                    context.push(AppRoute.changePassword);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "UserSetting.ChangePassword".tr(),
                        style: StyleColor.textStyleKhmerContentAuto(
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      right: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => SelectLanguage(),
                    //   ),
                    // );
                    context.push(AppRoute.selectLanguage);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        () {
                          return Singleton.instance.listLanguages
                              .where((element) =>
                                  element.code ==
                                  Singleton.instance.selectedLanguage)
                              .single
                              .desc!;
                        }(),
                        style: StyleColor.textStyleKhmerContentAuto(
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Image.asset(
                        "assets/image/flag/${Singleton.instance.selectedLanguage}.png",
                        width: 30,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              () {
                if (Singleton.instance.token!.permission != null &&
                    Singleton.instance.token!.permission!
                        .where((element) => element.located == "setting")
                        .isNotEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        backgroundColor: Colors.white.withOpacity(0.05),
                      ),
                      onPressed: () {
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => AdminSetting(),
                        //   ),
                        // );
                        context.push(AppRoute.adminSetting);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "UserSetting.Setting".tr(),
                            style: StyleColor.textStyleKhmerContentAuto(
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                } else
                  return Container();
              }(),

              () {
                if (Singleton.instance.isHasFaceIdScan) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.05),
                    ),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Image.asset(
                              "assets/image/faceid.png",
                              width: 30,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "UserSetting.FaceId".tr(),
                              style: StyleColor.textStyleKhmerContentAuto(
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        CupertinoSwitch(
                          // activeColor: StyleColor.appBarColor,
                          onChanged: (value) async {
                            await Singleton.instance.initFaceIdPermission();
                            if (Singleton.instance.faceIdPermission) {
                              Singleton.instance.storage
                                  .delete(key: "stm_faceId_permission");
                              await Singleton.instance.initFaceIdPermission();
                            } else {
                              Singleton.instance.storage.write(
                                  key: "stm_faceId_permission", value: "1");
                              await Singleton.instance.initFaceIdPermission();
                            }
                            setState(() {});
                          },
                          value: Singleton.instance.faceIdPermission,
                        )
                      ],
                    ),
                  );
                } else
                  return Container();
              }(),
              () {
                if (Singleton.instance.isHasFingerPrintScan) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.05),
                    ),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.fingerprint,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "UserSetting.FingerPrint".tr(),
                              style: StyleColor.textStyleKhmerContentAuto(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        CupertinoSwitch(
                          activeColor: StyleColor.appBarColor,
                          onChanged: (value) async {
                            await Singleton.instance
                                .initFingerPrintPermission();
                            if (Singleton.instance.fingerPrintPermission) {
                              Singleton.instance.storage
                                  .delete(key: "stm_fingerPrint_permission");
                              await Singleton.instance
                                  .initFingerPrintPermission();
                            } else {
                              Singleton.instance.storage.write(
                                  key: "stm_fingerPrint_permission",
                                  value: "1");
                              await Singleton.instance
                                  .initFingerPrintPermission();
                            }
                            setState(() {});
                          },
                          value: Singleton.instance.fingerPrintPermission,
                        )
                      ],
                    ),
                  );
                } else
                  return Container();
              }(),
              // Divider(
              //   height: 1,
              // ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    var res = await PopupDialog.yesNoPrompt(
                      context,
                    );
                    if (res) {
                      await Singleton.instance.clearUserLoginCache();
                      await Future.delayed(Duration(milliseconds: 150));
                      Singleton.instance.userLogOut();
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => Login(
                                  faceIdScanDelay: 2,
                                  isLoggedOut: true,
                                ),
                              ),
                              (Route<dynamic> route) => true);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    backgroundColor: Colors.white.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "UserSetting.LogOut".tr(),
                        style: StyleColor.textStyleKhmerContentAuto(
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
