import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:stm_report_app/Api/Domain.dart';
import 'package:stm_report_app/Extension/Extension.dart';

// ignore: must_be_immutable
class PhotoViewSlideOut extends StatefulWidget {
  String? url;
  PhotoViewSlideOut({Key? key, this.url}) : super(key: key);

  @override
  _PhotoViewSlideOutState createState() {
    return _PhotoViewSlideOutState();
  }
}

class _PhotoViewSlideOutState extends State<PhotoViewSlideOut> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.withOpacity(0.3),
      child: Stack(
        children: [
          Center(
            child: ExtendedImageSlidePage(
              slideAxis: SlideAxis.both,
              slideType: SlideType.onlyImage,
              resetPageDuration: Duration(milliseconds: 100),
              child: ExtendedImage.network(
                Domain.domain + widget.url!,
                enableSlideOutPage: true,
                clearMemoryCacheWhenDispose: true,
                mode: ExtendedImageMode.gesture,
                // ignore: missing_return

                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return Extension.getNoImage();
                  }
                  return null;
                },
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
