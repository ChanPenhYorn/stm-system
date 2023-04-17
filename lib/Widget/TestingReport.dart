import 'package:flutter/material.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class TestingReport extends StatefulWidget {
  const TestingReport({Key? key}) : super(key: key);

  @override
  State<TestingReport> createState() => _TestingReportState();
}

class _TestingReportState extends State<TestingReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery(
        data: MediaQueryData(padding: EdgeInsets.zero),
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              //Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/image/dip_logo.png",
                    width: 110,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/image/stm_report_logo.png",
                        width: 70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                              style: StyleColor.textStyleKhmerContentAuto(
                                fontSize: 26,
                                bold: false,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "ចរាចរណ៍ និងចំណូល",
                              style: StyleColor.textStyleKhmerContentAuto(
                                fontSize: 22,
                                bold: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/image/stm_report_logo.png",
                    width: 70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
