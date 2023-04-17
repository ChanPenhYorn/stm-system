// import 'package:flutter/material.dart';
// import 'package:stm_report_app/Entity/PPSHV/PPSHVDeductionModel.dart';
// import 'package:stm_report_app/Extension/Extension.dart';
// import 'package:stm_report_app/Style/AnimateLoading.dart';
// import 'package:stm_report_app/Style/StyleColor.dart';
//
// class PPSHVDeductionMixedReport extends StatefulWidget {
//   const PPSHVDeductionMixedReport({Key? key}) : super(key: key);
//
//   @override
//   State<PPSHVDeductionMixedReport> createState() =>
//       _PPSHVDeductionMixedReportState();
// }
//
// class _PPSHVDeductionMixedReportState extends State<PPSHVDeductionMixedReport> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     InitData = initData();
//     super.initState();
//   }
//
//   String jsonStr = "";
//   late PPSHVDeductionModel jsonData;
//   Future initData() async {
//     await Future.delayed(
//       Duration(milliseconds: 300),
//     );
//     jsonData = PPSHVDeductionModel.fromJson(Extension.jsonDataDeduction);
//   }
//
//   Future? InitData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: StyleColor.appBarColor,
//         title: Text(
//           'របាយការណ៍កាត់ទឹកប្រាក់',
//           style: StyleColor.textStyleKhmerDangrekAuto(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: FutureBuilder(
//           future: InitData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Container(),
//               );
//             }
//             return AnimateLoading();
//           },
//         ),
//       ),
//     );
//   }
// }
