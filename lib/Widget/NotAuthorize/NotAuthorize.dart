import 'package:flutter/material.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class NotAuthorize extends StatefulWidget {
  const NotAuthorize({Key? key}) : super(key: key);

  @override
  State<NotAuthorize> createState() => _NotAuthorizeState();
}

class _NotAuthorizeState extends State<NotAuthorize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STM Report',
          style: StyleColor.textStyleDefaultAuto(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Text(
        'អ្នកមិនមានសិទ្ឋអនុញ្ញាតិ',
        style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 16),
      ),
    );
  }
}
