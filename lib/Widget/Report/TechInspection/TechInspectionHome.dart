import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Report/TechInspection/TechInspectionFine.dart';
import 'package:stm_report_app/Widget/Report/TechInspection/TechInspectionIncome.dart';
import 'package:stm_report_app/Widget/Report/TechInspection/TechInspectionTotalIncome.dart';

class TechInspectionHome extends StatefulWidget {
  const TechInspectionHome({Key? key}) : super(key: key);

  @override
  State<TechInspectionHome> createState() => _TechInspectionHomeState();
}

class _TechInspectionHomeState extends State<TechInspectionHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ត្រួតពិនិត្យលក្ខណៈបច្ចេកទេសយានជំនិះ',
          style: StyleColor.textStyleKhmerDangrekAuto(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                //Total
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TechInspectionTotalIncome(),
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
                            "assets/svg/ti-total-income.svg",
                            color: Colors.white,
                            width: 80,
                          ),
                        ),
                      ),
                      Text(
                        "ចំណូលសរុប",
                        style: StyleColor.textStyleKhmerDangrekAuto(
                            fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                //Top-up
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TechInspectionFine(),
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
                            "assets/svg/ti-fine.svg",
                            color: Colors.white,
                            width: 80,
                          ),
                        ),
                      ),
                      Text(
                        "ចំណូលពីសេវាពិន័យ",
                        style: StyleColor.textStyleKhmerDangrekAuto(
                            fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                //Tech Inspection
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TechInspectionIncome(),
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
                            "assets/svg/ti-income.svg",
                            color: Colors.white,
                            width: 70,
                          ),
                        ),
                      ),
                      Text(
                        "ចំណូលពីសេវាឆៀក",
                        style: StyleColor.textStyleKhmerDangrekAuto(
                            fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
