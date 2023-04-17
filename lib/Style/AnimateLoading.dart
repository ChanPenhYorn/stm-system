import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'StyleColor.dart';

class AnimateLoading extends StatelessWidget {
  AnimateLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitThreeBounce(
            color: StyleColor.appBarColor,
            size: 20.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Message.Loading".tr(),
            // style: StyleColor.textStyleKhmerDangrek16,
            style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          )
        ],
      ),
    );
  }

  void showLoading(BuildContext context,
      {String? content,
      int? layerContext,
      String? data,
      bool dismiss = false}) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: dismiss,
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
        body: Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SpinKitThreeBounce(
                  color: StyleColor.appBarColor,
                  size: 20.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  content == null ? "Message.Loading".tr() : content,
                  style: StyleColor.textStyleKhmerDangrek16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPopup(BuildContext context) {}
}
