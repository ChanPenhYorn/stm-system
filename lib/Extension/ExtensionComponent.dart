import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:stm_report_app/Api/Domain.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Widget/Component/GraphComponent.dart';

class ExtensionComponent {
  static Widget getNoImage() {
    if (Singleton.instance.selectedLanguage == 'km-KH')
      return Image.asset(
        'images/noimage.jpg',
      );
    else
      return Image.asset(
        'images/noimage_en.jpg',
      );
  }

  static Widget cachedNetworkImage(
      {required String url,
      double width = 80,
      double height = 80,
      bool profile = false}) {
    return CachedNetworkImage(
      key: Key(url),
      imageUrl: Domain.domain + url,
      fit: BoxFit.cover,
      errorWidget: (context, str, dynamic) {
        return profile ? Extension.getNoImageProfile() : Extension.getNoImage();
      },
      placeholder: (context, str) {
        return CupertinoActivityIndicator();
      },
      width: width,
      height: height,
    );
  }

  static GraphComponent graphComponent = GraphComponent();

  static List<Color> listColor = [
    Color.fromRGBO(88, 0, 255, 1),
    Color.fromRGBO(0, 215, 255, 1)
  ];
}
