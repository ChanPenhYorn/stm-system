import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Widget/Authentication/DeviceApproved.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? logoAnimation;

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  initData() async {
    await Singleton.instance.getUpdate(context);
    await initInfoDevice();
    await initOTPActivation();
  }

  Future? InitData;

  Future<void> initOTPActivation() async {
    var res = await Singleton.instance.apiExtension.get<UserModel, UserModel>(
        context: context,
        param: "udid=${Singleton.instance.udid}",
        loading: false,
        baseUrl: ApiEndPoint.getApprovedAccountByUDID,
        deserialize: (e) => UserModel.fromJson(e));
    if (res.success!) {
      // print(res.data!.toJson());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DeviceApproved(User: res.data!),
        ),
      );
    } else {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => Login(),
      //   ),
      // );
      context.pushReplacement('/login');
    }
  }

  Future<void> initInfoDevice() async {
    // print("init udid");
    Singleton.instance.udid =
        await Singleton.instance.storage.read(key: "udidCache") ?? "";
    Singleton.instance.modelVersion =
        await Singleton.instance.storage.read(key: "modelVersionCache") ?? "";
    Singleton.instance.modelName =
        await Singleton.instance.storage.read(key: "modelNameCache") ?? "";
    // print("UDID : ${Singleton.instance.udid}");
    // print("modelVersion : ${Singleton.instance.modelVersion}");
    // print("modelName : ${Singleton.instance.modelName}");
    if (Singleton.instance.udid == "" ||
        Singleton.instance.modelVersion == "" ||
        Singleton.instance.modelName == "") {
      await _writeInfoDevice();
    }
  }

  Future<void> _writeInfoDevice() async {
    var deviceInfo = DeviceInfoPlugin();
    var _udid, _modelName, _modelVersion;
    try {
      if (Platform.isIOS) {
        var iosDeviceInfo = await deviceInfo.iosInfo;
        _udid = iosDeviceInfo.identifierForVendor ?? ""; // unique ID on iOS
        _modelName = iosDeviceInfo.name ?? ""; // Phone Name
        _modelVersion = iosDeviceInfo.systemVersion ?? ""; // Version Firmeware
        print("_modelVersion : $_modelVersion");
        print("_modelName : $_modelName");
        if (_udid != null && _udid != "") {
          /// UDID
          await Singleton.instance.storage
              .write(key: "udidCache", value: _udid);
          Singleton.instance.udid = _udid;
        }
        if (_modelName != null && _modelName != "") {
          /// Phone Name
          await Singleton.instance.storage
              .write(key: "modelNameCache", value: _modelName);
          Singleton.instance.modelName = _modelName;
        }
        if (_modelVersion != null && _modelVersion != "") {
          /// Version Firmeware
          await Singleton.instance.storage
              .write(key: "modelVersionCache", value: "IOS " + _modelVersion);
          Singleton.instance.modelVersion = "IOS " + _modelVersion;
        }
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        _udid = androidDeviceInfo.id; // unique ID on Android
        _modelName = androidDeviceInfo.model ?? ""; // Phone Name
        _modelVersion =
            androidDeviceInfo.version.release ?? ""; // Version Firmeware
        print("_modelVersion : $_modelVersion");
        print("_modelName : $_modelName");
        if (_udid != null && _udid != "") {
          ///UDID
          await Singleton.instance.storage
              .write(key: "udidCache", value: _udid);
          Singleton.instance.udid = _udid;
        }
        if (_modelName != null && _modelName != "") {
          /// Phone Name
          await Singleton.instance.storage
              .write(key: "modelNameCache", value: _modelName);
          Singleton.instance.modelName = _modelName;
        }
        if (_modelVersion != null && _modelVersion != "") {
          /// Version Firmeware
          await Singleton.instance.storage.write(
              key: "modelVersionCache", value: "Android " + _modelVersion);
          Singleton.instance.modelVersion = "Android " + _modelVersion;
        }
      }
    } catch (e) {
      print("Error : ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    logoAnimation = Tween<double>(begin: 50, end: 400).animate(controller!);
    controller!.forward();

    Timer(Duration(seconds: 1), () {
      InitData = initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: logoAnimation!,
        builder: (context, widget) {
          return Scaffold(
              body: FutureBuilder(
            future: InitData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {}
              return Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(80),
                        width: logoAnimation!.value,
                        decoration: const BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: const AssetImage(
                                'assets/image/stm_report_logo.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ));
        });
  }
}
