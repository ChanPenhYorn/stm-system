import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Api/ApiExtension.dart';
import 'package:stm_report_app/Entity/AppVersion.dart';
import 'package:stm_report_app/Entity/Cache/UserCache.dart';
import 'package:stm_report_app/Entity/Language/Language.dart';
import 'package:stm_report_app/Entity/Setting/DashboardButton.dart';
import 'package:stm_report_app/Entity/Token.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Authentication/Login.dart';
import 'package:stm_report_app/Widget/Component/TableComponent.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as IO;

import 'package:store_redirect/store_redirect.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class Singleton with ChangeNotifier {
  static final Singleton instance = Singleton.internal();

  factory Singleton() {
    return instance;
  }

  List<DashboardButton> dashboardButton = [
    DashboardButton(
      id: 213221,
      buttonTitle: 'Navigation.RolePermission'.tr(),
      icon: 'assets/image/setting/userright.png',
      route: '/role',
      initFunc: () {},
    ),
    DashboardButton(
      id: 424423,
      buttonTitle: 'Navigation.Users'.tr(),
      icon: 'assets/image/setting/user.png',
      route: '/user',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123431,
      buttonTitle: 'Navigation.Register'.tr(),
      icon: 'assets/image/setting/userapproval.png',
      route: '/approval',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123432,
      buttonTitle: 'Navigation.Company'.tr(),
      icon: 'assets/image/setting/company.png',
      route: '/company',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123433,
      buttonTitle: 'Navigation.Customer'.tr(),
      icon: 'assets/image/setting/customer.png',
      route: '/customer',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123434,
      buttonTitle: 'Navigation.Product'.tr(),
      icon: 'assets/image/setting/product.png',
      route: '/product',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123435,
      buttonTitle: 'Navigation.Customer'.tr(),
      icon: 'assets/image/setting/customer.png',
      route: '/customer',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123436,
      buttonTitle: 'Navigation.Zone'.tr(),
      icon: 'assets/image/setting/zone.png',
      route: '/zone',
      initFunc: () {},
    ),
    DashboardButton(
      id: 123437,
      buttonTitle: 'Navigation.Barge'.tr(),
      icon: 'assets/image/setting/barge.png',
      route: '/barge',
      initFunc: () {},
    ),
  ];

  List<Language> listLanguages = [
    Language(code: "km-KH", desc: "ភាសាខ្មែរ"),
    Language(code: "en-US", desc: "English")
  ];
  String selectedLanguage = 'km-KH';

  late ApiExtension apiExtension;
  Dio dio = Dio()
    ..options.headers = {
      "Authorization": "Bearer jdkewowjs@#Dfjsdkk3er@sfdgsdfgwer231"
    };
  TableComponent tableComponent = TableComponent();

  Orientation orientation = Orientation.portrait;

  void apiExtensionInit() async {
    apiExtension = ApiExtension();
    await initVersion();
  }

  double largeScreenWidthConstraint = 700;
  double animationDurationGraph = 800;
  int graphAxisFontSizeReport = 12;
  int graphAxisFontSizeScreen = 8;

  int getAxisFontSizeScreenType() {
    if (Extension.getDeviceType() == DeviceType.PHONE)
      return 8;
    else
      return 11;
  }

  GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  //User Setting
  //Authentication
  final LocalAuthentication auth = LocalAuthentication();
  bool faceIdPermission = false;
  bool fingerPrintPermission = false;
  bool isUserLoginCache = false;
  bool isHasFaceIdScan = false;
  bool isHasFingerPrintScan = false;
  bool autoPrintPermission = false;
  UserCache userAccountCache = UserCache();
  String? udid;
  String? modelName;
  String? modelVersion;
  Token? token;

  //Inactivity Timeout
  Timer? timer;

  AppVersion appVersion = AppVersion();
  bool isLoggedIn = false;

  void dioBearerFirstTokenInitialize() {
    dio.options.headers = {
      "Authorization": "Bearer 296A607EF9B90303F208E6A677B88262B22C1973"
    };
  }

  void dioBearerSecondTokenInitialize() {
    dio.options.headers = {
      "Authorization":
          "${Singleton.instance.token == null ? " " : Singleton.instance.token!.BearerToken}"
    };
  }

  Future initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Singleton.instance.appVersion = AppVersion(
      appVersion: packageInfo.version,
    );
  }

  //Secure Storage
  FlutterSecureStorage storage = FlutterSecureStorage();

  //Permission
  Future<bool> writeLocalStorage(String key, String value) async {
    try {
      var res = await storage.write(key: key, value: value);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> requestPermission(BuildContext context) async {
    // var locationAlwaysStatus = await Permission.location.status;
    // var photoStatus = await Permission.photos.status;
    // var cameraStatus = await Permission.camera.status;
    // var locationService = await Permission.location.serviceStatus;
    // var notification = await Permission.notification.status;
    //
    // if (notification.isDenied) {
    //   var res = await Permission.notification.request();
    //   return res.isGranted;
    // } else {
    //   bool res = await checkPermission(context);
    //   return res;
    // }
    return true;
  }

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      if (IO.Platform.isIOS) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          isHasFaceIdScan = true;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          isHasFingerPrintScan = true;
          // Touch ID.
        }
      } else {
        isHasFingerPrintScan = true;
      }
    }
  }

  Future<void> clearBiomatrice() async {
    await storage.write(
      key: "stm_fingerPrint_permission",
      value: "",
    );
    await storage.write(
      key: "stm_faceId_permission",
      value: "",
    );
  }

  Future<bool> writeLoginToken({required Token token}) async {
    try {
      await storage.write(key: "stm_token", value: jsonEncode(token.toJson()));
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> readLoginToken() async {
    var res = await storage.read(key: "stm_token");
    if (res != null) {
      token = Token.fromJson(jsonDecode(res));
      return true;
    } else
      return false;
  }

  Future<bool> initFingerPrintPermission() async {
    var fingerPrintValue =
        await storage.read(key: "stm_fingerPrint_permission");
    if (fingerPrintValue != null && fingerPrintValue == "1") {
      fingerPrintPermission = true;
      return fingerPrintPermission;
    } else
      fingerPrintPermission = false;
    return fingerPrintPermission;
  }

  Future<bool> initFaceIdPermission() async {
    var faceIdValue = await storage.read(key: "stm_faceId_permission");
    if (faceIdValue != null && faceIdValue == "1") {
      faceIdPermission = true;
      return faceIdPermission;
    } else
      faceIdPermission = false;
    return faceIdPermission;
  }

  Future<bool> initLocalStorage() async {
    var lang = await storage.read(key: "stm_language_selected");
    if (lang != null) {
      selectedLanguage = lang;
    } else {
      selectedLanguage = 'km-KH';
    }
    return true;
  }

  Future<bool> initUserLoginCache() async {
    var username = await storage.read(key: "stm_userNameCache");
    var password = await storage.read(key: "stm_passWordCache");
    if (username != null && password != null) {
      userAccountCache = UserCache(username: username, password: password);
      isUserLoginCache = true;
    } else
      isUserLoginCache = false;
    return isUserLoginCache;
  }

  Future<bool> writeUserLoginCache(
      {required String username, required String password}) async {
    var user = UserCache(username: username, password: password).toJson();
    try {
      await storage.write(key: "stm_passWordCache", value: password);
      await storage.write(key: "stm_userNameCache", value: username);
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  //Log Out
  void logOutUser({required BuildContext context}) {
    timer?.cancel();
    timer = null;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: 130,
              child: Column(
                children: <Widget>[
                  Text(
                    'ព៌តមាន',
                    style: StyleColor.textStyleKhmerDangrek18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Session Expired",
                    style: StyleColor.textStyleKhmerContent,
                  ),
                  TextButton(
                    onPressed: () {
                      // socket.disconnect();
                      // socket.destroy();
                      // socket.dispose();
                      globalKey.currentState!.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "យល់ព្រម",
                      style: StyleColor.textStyleKhmerContent,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> clearUserLoginCache() async {
    try {
      await storage.delete(key: "stm_userNameCache");
      await storage.delete(key: "stm_passWordCache");
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> clearUserstm_passWordCache() async {
    try {
      await storage.delete(key: "stm_passWordCache");
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> clearTokenCache() async {
    try {
      await storage.delete(key: "stm_token");
      return true;
    } catch (err) {
      return false;
    }
  }

  //Authentication FaceID or Biometric
  Future<bool> authenticate({int faceIdScanDelay = 0}) async {
    await Future.delayed(
      Duration(
        seconds: faceIdScanDelay == 0 ? 1 : faceIdScanDelay,
      ),
    );
    final canCheck = await auth.canCheckBiometrics;
    if (canCheck) {
      bool result = false;
      if (IO.Platform.isIOS) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        if (availableBiometrics.contains(BiometricType.face)) {
          var faceIdPermission =
              await Singleton.instance.initFaceIdPermission();
          if (faceIdPermission) {
            result = await auth.authenticate(
                localizedReason: "ស្កេនមុខដើម្បីចូលទៅកាន់ប្រព័ន្ឋ");
          }
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          var fingerPrintPermission =
              await Singleton.instance.initFingerPrintPermission();
          if (fingerPrintPermission) {
            result = await auth.authenticate(
                localizedReason: "ស្កេនក្រយ៉ៅដៃដើម្បីចូលទៅកាន់ប្រព័ន្ឋ");
          }
        }
      } else {
        var fingerPrintPermission =
            await Singleton.instance.initFingerPrintPermission();
        if (fingerPrintPermission) {
          result = await auth.authenticate(
            localizedReason: "ស្កេនក្រយ៉ៅដៃដើម្បីចូលទៅកាន់ប្រព័ន្ឋ",
            options: AuthenticationOptions(stickyAuth: true),
          );
        }
      }
      return result;
    } else {
      return false;
    }
  }

  //Utilities
  void handleUserInteraction(BuildContext context) {
    initializeTimer(context);
  }

  void initializeTimer(BuildContext context) {
    if (timer != null) {
      timer!.cancel();
    }
    timer =
        Timer(const Duration(hours: 10), () => logOutUser(context: context));
  }

  //Listener
  userLogIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  userLogOut() {
    token = null;
    isLoggedIn = false;
    notifyListeners();
  }

  Future<void> getUpdate(BuildContext context) async {
    var res = await Singleton.instance.apiExtension.get<AppVersion, AppVersion>(
        context: context,
        loading: false,
        baseUrl: ApiEndPoint.appVersion,
        deserialize: (e) => AppVersion.fromJson(e));
    String? latestVersion = res.data?.appVersion?.replaceAll(".", "");
    String? currentVersion = appVersion.appVersion?.replaceAll(".", "");

    latestVersion = latestVersion == null ? "0" : latestVersion;
    currentVersion = currentVersion == null ? "0" : currentVersion;
    print("$latestVersion || $currentVersion");
    if (int.parse(latestVersion) > int.parse(currentVersion)) {
      bool prompt = await PopupDialog.yesNoPrompt(context,
          content: "សូមធ្វើបច្ចុប្បន្នភាពកម្មវិធី");
      if (prompt) {
        StoreRedirect.redirect(
          iOSAppId: "1669701398",
        );
        return getUpdate(context);
      } else {
        IO.exit(0);
      }
    } else {
      print('App is up to date ');
    }
  }

  Future<String> getQRData(String path) async {
    InputImage visionImage = InputImage.fromFile(IO.File(path));
    final List<BarcodeFormat> formats = [
      BarcodeFormat.qrCode,
      BarcodeFormat.codabar
    ];
    final barcodeScanner = BarcodeScanner(formats: formats);
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(visionImage);
    if (barcodes.length != 0) {
      return barcodes[0].rawValue ?? "";
    }
    return "";
  }

  String localLanguage() {
    if (selectedLanguage == 'km-KH') {
      return "km";
    } else if (selectedLanguage == "en-US") {
      return "en";
    } else {
      return "";
    }
  }

  Singleton.internal() {
    print('Instance Singleton Created.');
  }
}
