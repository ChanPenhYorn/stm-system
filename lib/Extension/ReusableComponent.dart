import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stm_report_app/Api/Domain.dart';

class ReusableComponent {
  static Widget cachedNetworkImage(BuildContext context, String url,
      {double? width, bool roundedBorder = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(roundedBorder ? 10 : 0),
      child: CachedNetworkImage(
        imageUrl: Domain.domain + url,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Lottie.asset('assets/lottie/loading.json'),
        errorWidget: (context, url, error) => Image.asset("images/noimage.png"),
        width: width,
      ),
    );
  }

  static TextButton textButton(
      {required BuildContext context,
      required Widget child,
      required void onPressed()}) {
    return TextButton(
      child: child,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(),
      ),
    );
  }
}
