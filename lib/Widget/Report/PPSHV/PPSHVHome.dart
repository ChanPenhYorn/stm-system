import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Report/PPSHV/PPSHVDeductionReport.dart';
import 'package:stm_report_app/Widget/Report/PPSHV/PPSHVTopupReport.dart';

class PPSHVHome extends StatefulWidget {
  const PPSHVHome({Key? key}) : super(key: key);

  @override
  State<PPSHVHome> createState() => _PPSHVHomeState();
}

class _PPSHVHomeState extends State<PPSHVHome> {
  @override
  void initState() {
    initButton();
    super.initState();
  }

  List<Widget> listButton = [];

  void initButton() {
    if (Extension.getPermissionByActivity(
            activiyName: "PPSHV_Topup", activityEn: true)
        .GET)
      listButton.add(TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PPSHVTopupReport(),
            ),
          );
        },
        style: TextButton.styleFrom(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(5),
          backgroundColor: StyleColor.appBarDarkColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/svg/ppshv-topup.svg",
                  color: Colors.white,
                  width: 70,
                ),
              ),
            ),
            Text(
              "បញ្ចូលទឹកប្រាក់",
              style: StyleColor.textStyleKhmerDangrekAuto(
                  fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ));
    if (Extension.getPermissionByActivity(
            activiyName: "PPSHV_Deduction", activityEn: true)
        .GET)
      listButton.add(TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PPSHVDeductionReport(),
            ),
          );
        },
        style: TextButton.styleFrom(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(5),
          backgroundColor: StyleColor.appBarDarkColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/svg/ppshv-deduction.svg",
                  color: Colors.white,
                  width: 70,
                ),
              ),
            ),
            Text(
              "ចរាចរណ៍ និងចំណូល",
              style: StyleColor.textStyleKhmerDangrekAuto(
                  fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ',
          style: StyleColor.textStyleKhmerDangrekAuto(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: listButton),
          ),
        ),
      ),
    );
  }
}
