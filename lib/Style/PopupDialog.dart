import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:io' as IO;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Widget/Authentication/Login.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'StyleColor.dart';

class PopupDialog {
  static Future<bool?> showPopup(BuildContext context, String content,
      {int? layerContext,
      dynamic data,
      bool pushToLogin = false,
      bool exitApp = false,
      bool dismiss = false,
      int soundEffectSuccess = 3,
      int success = 3}) async {
    var result = await showDialog(
        barrierDismissible: dismiss,
        context: context,
        builder: (_) => Dialog(
              elevation: 10,
              insetPadding: EdgeInsets.all(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Text(
                        "Message.Information".tr(),
                        style: StyleColor.textStyleKhmerDangrek18,
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                    () {
                      if (success == 3)
                        return Container(
                          width: 100,
                          height: 100,
                          child: Image.asset('images/processing.png'),
                        );
                      else if (success == 2)
                        return Container(
                          width: 70,
                          height: 70,
                          child: Lottie.asset('assets/lottie/warning.json',
                              repeat: false),
                        );
                      else if (success == 1)
                        return Container(
                          width: 70,
                          height: 70,
                          child: Lottie.asset('assets/lottie/success.json',
                              repeat: false),
                        );
                      else if (success == 0)
                        return Container(
                          width: 70,
                          height: 70,
                          child: Lottie.asset('assets/lottie/error.json',
                              repeat: false),
                        );
                      else
                        return Container();
                    }(),
                    AutoSizeText(
                      content,
                      style: StyleColor.textStyleKhmerContent,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        if (exitApp) {
                          IO.exit(0);
                        } else {
                          if (pushToLogin) {
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => Login(
                                        isLoggedOut: true,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false);
                          } else {
                            if (layerContext != null) {
                              for (int i = 0; i < layerContext; i++) {
                                if (i == layerContext - 1) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(data);
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(data);
                                }
                              }
                            } else {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(data);
                            }
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.white,
                        splashFactory: InkRipple.splashFactory,
                        shape: RoundedRectangleBorder(),
                      ),
                      child: Text(
                        "Button.Accept".tr(),
                        style: StyleColor.textStyleKhmerContentAuto(
                          color: StyleColor.appBarColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
    return result;
  }

  static Future<bool?> showSuccess(BuildContext context,
      {String content = 'Message.OperationSuccess',
      int? layerContext,
      dynamic data,
      bool pushToLogin = false,
      bool exitApp = false,
      bool dismiss = false}) async {
    var result = await showDialog(
        barrierDismissible: dismiss,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.only(top: 15, bottom: 10),
              titlePadding: EdgeInsets.all(0),
              content: Container(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Text(
                        "Message.Information".tr(),
                        style: StyleColor.textStyleKhmerDangrek18,
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      child: Lottie.asset('assets/lottie/success.json',
                          repeat: false),
                    ),
                    Text(
                      content.tr(),
                      style: StyleColor.textStyleKhmerContent,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        if (exitApp) {
                          IO.exit(0);
                        } else {
                          if (pushToLogin) {
                            // Navigator.of(context, rootNavigator: true)
                            //     .pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) => Login()),
                            //         (Route<dynamic> route) => false);
                          } else {
                            if (layerContext != null) {
                              for (int i = 0; i < layerContext; i++) {
                                if (i == layerContext - 1) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(data);
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(data);
                                }
                              }
                            } else {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(data);
                            }
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.white,
                        splashFactory: InkRipple.splashFactory,
                        shape: RoundedRectangleBorder(),
                      ),
                      child: Text(
                        "Button.Accept".tr(),
                        style: StyleColor.textStyleKhmerContentAuto(
                          color: StyleColor.appBarColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
    return result;
  }

  static Future<bool?> showFailed(BuildContext context,
      {String content = 'Message.OperationFailed',
      int? layerContext,
      dynamic data,
      bool pushToLogin = false,
      bool exitApp = false,
      bool dismiss = false}) async {
    var result = await showDialog(
        barrierDismissible: dismiss,
        context: context,
        builder: (_) => Dialog(
              elevation: 10,
              insetPadding: EdgeInsets.all(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Text(
                        "Message.Information".tr(),
                        style: StyleColor.textStyleKhmerDangrek18,
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      child: Lottie.asset('assets/lottie/error.json',
                          repeat: false),
                    ),
                    Text(
                      content.tr(),
                      style: StyleColor.textStyleKhmerContent,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        if (exitApp) {
                          IO.exit(0);
                        } else {
                          if (pushToLogin) {
                            // Navigator.of(context, rootNavigator: true)
                            //     .pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) => Login()),
                            //         (Route<dynamic> route) => false);
                          } else {
                            if (layerContext != null) {
                              for (int i = 0; i < layerContext; i++) {
                                if (i == layerContext - 1) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(data);
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(data);
                                }
                              }
                            } else {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(data);
                            }
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.white,
                        splashFactory: InkRipple.splashFactory,
                        shape: RoundedRectangleBorder(),
                      ),
                      child: Text(
                        "Button.Accept".tr(),
                        style: StyleColor.textStyleKhmerContentAuto(
                          color: StyleColor.appBarColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
    return result;
  }

  static Widget connectionError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/connectionbroken.png',
            width: 80,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'មិនអាចភ្ជាប់ទៅកាន់ប្រព័ន្ឋបានទេ',
            style: StyleColor.textHeaderStyleKhmerContent,
          ),
          Text(
            'Cannot Connect To Server.',
            style: StyleColor.textHeaderStyleKhmerContent,
          ),
        ],
      ),
    );
  }

  static Widget anprCapturing({bool landscape = false}) {
    return landscape
        ? Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: Lottie.asset(
                    'assets/lottie/cctv_capturing3.json',
                    repeat: true,
                    frameRate: FrameRate.max,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'រង់ចាំយានយន្តឆ្លងកាត់',
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      'Waiting for Vehicle Entry',
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: Lottie.asset(
                    'assets/lottie/cctv_capturing3.json',
                    repeat: true,
                    frameRate: FrameRate.max,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Text(
                  'រង់ចាំយានយន្តឆ្លងកាត់',
                  style: StyleColor.textStyleKhmerDangrekAuto(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  'Waiting for Vehicle Entry',
                  style: StyleColor.textStyleKhmerDangrekAuto(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
  }

  static Widget noResult() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Image.asset(
          //   'assets/images/noimage.png',
          //   width: 70,
          // ),
          SvgPicture.asset(
            "assets/svg/search.svg",
            width: 50,
            color: Colors.grey.shade700,
          ),
          Text(
            'មិនមានទិន្នន័យ',
            style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            'No Result Found',
            style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  static Widget noCartResult() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/shopping_cart.png',
            width: 70,
          ),
          Text(
            'មិនមានទំនិញក្នុងកន្ត្រក',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
          Text(
            'Your cart is empty',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: StyleColor.appBarColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Button.OrderNow".tr(),
                    style: StyleColor.textStyleKhmerContent14White,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget noInvoiceResult() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/invoice_noresult.png',
            width: 150,
          ),
          Text(
            'មិនមានទិន្នន័យវិក័យបត្រ',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
          Text(
            'No Result Found',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
        ],
      ),
    );
  }

  static Widget noProductResult() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/notfound.png',
            width: 100,
          ),
          Text(
            'មិនមានទិន្នន័យទំនិញ',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
          Text(
            'No Product Result Found',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
        ],
      ),
    );
  }

  static Widget noCustomerResult() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/notfound.png',
            width: 100,
          ),
          Text(
            'មិនមានទិន្នន័យអតិថិជន',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
          Text(
            'No Customer Result Found',
            style: StyleColor.textStyleKhmerDangrek18,
          ),
        ],
      ),
    );
  }

  static Future<bool> yesNoPrompt(BuildContext context,
      {String content = ""}) async {
    String con = "Message.CheckConfirm".tr();
    if (content.length > 0) con = content;
    // Extension.clearFocus(context);
    var result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.only(top: 15, bottom: 10),
        titlePadding: EdgeInsets.all(0),
        content: Container(
          constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Message.Information".tr(),
                style: StyleColor.textStyleKhmerDangrek20,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 70,
                height: 70,
                child:
                    Lottie.asset('assets/lottie/warning.json', repeat: false),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                con,
                style: TextStyle(fontFamily: 'Khmer OS Content', fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      "Button.Cancel".tr(),
                      style: StyleColor.textStyleKhmerContentAuto(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      backgroundColor: Colors.grey.shade400,
                      splashFactory: InkRipple.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      backgroundColor: StyleColor.appBarColor,
                      splashFactory: InkRipple.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                    child: Text(
                      "Button.Accept".tr(),
                      style: StyleColor.textStyleKhmerContentAuto(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    if (result == null) result = false;
    return result;
  }

  //Photo Dialog
  static final ImagePicker _picker = ImagePicker();
  static late Directory _dir;

  static Future<File?> _compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 50, autoCorrectionAngle: true);
    return result;
  }

  static Future<File?> captureImage(BuildContext context) async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    _dir = await getApplicationDocumentsDirectory();
    var path = p.join(
        _dir.path,
        p.basenameWithoutExtension(image!.path) +
            "1" +
            p.extension(image.path));
    File? img = await _compressAndGetFile(File(image.path), path);
    return img;
  }

  static Future<XFile?> captureImageWeb(BuildContext context) async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  static Future<File?> getImage(BuildContext context) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    _dir = await getApplicationDocumentsDirectory();
    var path = p.join(
        _dir.path,
        p.basenameWithoutExtension(image!.path) +
            "1" +
            p.extension(image.path));
    File? img = await _compressAndGetFile(File(image.path), path);
    return img;
  }

  static Future<XFile?> getImageWeb(BuildContext context) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  static Future<List<File?>> _getImageList(BuildContext context) async {
    var image = await _picker.pickMultiImage();
    _dir = await getApplicationDocumentsDirectory();
    List<File?> listImage = [];
    if (image != null) {
      image.forEach((e) => {listImage.add(File(e.path))});
    }

    return listImage;
  }

  //Dialog
  static Future<File?> chooseImageDialog(BuildContext context) async {
    Extension.clearFocus(context);
    File? file;
    var result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 200,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'សូមជ្រើសរើស',
                    style: StyleColor.textStyleKhmerDangrek18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              width: 130,
                              child: InkWell(
                                  splashColor: Colors.lightBlue,
                                  // disabledColor: Colors.grey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_a_photo,
                                        color: StyleColor.appBarColor,
                                        size: 30,
                                      ),
                                      Text('ថតរូប',
                                          style: StyleColor
                                              .textStyleKhmerContent14)
                                    ],
                                  ),
                                  onTap: () async {
                                    try {
                                      AnimateLoading().showLoading(
                                        context,
                                      );
                                      file = await captureImage(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } catch (err) {
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 130,
                            child: InkWell(
                                splashColor: Colors.lightBlue,
                                // disabledColor: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.image,
                                      color: StyleColor.appBarColor,
                                      size: 30,
                                    ),
                                    Text(
                                      'ជ្រើសរើសរូបភាព',
                                      style: StyleColor.textStyleKhmerContent14,
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  try {
                                    AnimateLoading().showLoading(context);
                                    file = await getImage(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } catch (err) {
                                    Navigator.pop(context);
                                  }
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    return file;
  }

  static Future<XFile?> chooseImageDialogWeb(BuildContext context) async {
    Extension.clearFocus(context);
    XFile? xFile;
    var result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 200,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'សូមជ្រើសរើស',
                    style: StyleColor.textStyleKhmerDangrek18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              width: 130,
                              child: InkWell(
                                  splashColor: Colors.lightBlue,
                                  // disabledColor: Colors.grey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_a_photo,
                                        color: StyleColor.appBarColor,
                                        size: 30,
                                      ),
                                      Text('ថតរូប',
                                          style: StyleColor
                                              .textStyleKhmerContent14)
                                    ],
                                  ),
                                  onTap: () async {
                                    try {
                                      AnimateLoading().showLoading(
                                        context,
                                      );
                                      xFile = await captureImageWeb(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } catch (err) {
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 130,
                            child: InkWell(
                                splashColor: Colors.lightBlue,
                                // disabledColor: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.image,
                                      color: StyleColor.appBarColor,
                                      size: 30,
                                    ),
                                    Text(
                                      'ជ្រើសរើសរូបភាព',
                                      style: StyleColor.textStyleKhmerContent14,
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  try {
                                    AnimateLoading().showLoading(context);
                                    xFile = await getImageWeb(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } catch (err) {
                                    Navigator.pop(context);
                                  }
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    return xFile!;
  }

  static Future<List<File?>> chooseListImagesDialog(
      BuildContext context) async {
    Extension.clearFocus(context);
    List<File?> listFiles = [];
    var result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 200,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'សូមជ្រើសរើស',
                    style: StyleColor.textStyleKhmerDangrek18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              width: 130,
                              child: InkWell(
                                  splashColor: Colors.lightBlue,
                                  // disabledColor: Colors.grey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_a_photo,
                                        color: StyleColor.appBarColor,
                                        size: 30,
                                      ),
                                      Text('ថតរូប',
                                          style: StyleColor
                                              .textStyleKhmerContent14)
                                    ],
                                  ),
                                  onTap: () async {
                                    try {
                                      AnimateLoading().showLoading(context);
                                      File? file = await captureImage(context);
                                      listFiles.add(file!);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } catch (err) {
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 130,
                            child: InkWell(
                              splashColor: Colors.lightBlue,
                              // disabledColor: Colors.grey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.image,
                                    color: StyleColor.appBarColor,
                                    size: 30,
                                  ),
                                  Text(
                                    'ជ្រើសរើសរូបភាព',
                                    style: StyleColor.textStyleKhmerContent14,
                                  )
                                ],
                              ),
                              onTap: () async {
                                try {
                                  AnimateLoading().showLoading(context);
                                  listFiles = await _getImageList(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } catch (err) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    return listFiles;
  }
}
