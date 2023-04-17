import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/QRForm/QRFormModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/UserApproval/UserApprovalViewEditing.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  var keyQR = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isFlashOn = false;
  late bool isTorchAvailable;
  Barcode? result;
  bool isQRFound = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      ;
      await this.controller.pauseCamera();
      result = scanData;
      if (isQRFound) {
        isQRFound = false;
        await fetchQRData(result!.code!);
        isQRFound = true;
      }
      // setState(() {});
    });
  }

  fetchQRData(String code) async {
    var res = await Singleton.instance.apiExtension.post<String, String>(
      loading: true,
      context: context,
      baseUrl: ApiEndPoint.decryptQR,
      body: {"code": code},
      deserialize: (e) => e.toString(),
    );

    if (res.success!) {
      res.data = res.data!.replaceAll("'\'", "");
      var jsonData = json.decode(res.data!);
      QRFormModel qrFormModel = QRFormModel.fromJson(jsonData);
      //User Approval
      if (qrFormModel.qrType == "USER_APPROVAL") {
        if (Extension.getPermissionByActivity(
                    activiyName: "User_Approval", activityEn: true)
                .GET &&
            qrFormModel.userModel != null &&
            qrFormModel.userModel!.approved != "1") {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserApprovalViewEditing(
                userModel: qrFormModel.userModel!,
              ),
            ),
          );
          await this.controller.resumeCamera();
        } else if (!Extension.getPermissionByActivity(
                activiyName: "User_Approval", activityEn: true)
            .GET) {
          await PopupDialog.showFailed(context,
              content: "គ្មានសិទ្ធអនុញ្ញាតពាក្យស្នើសុំដំឡើង");
          await this.controller.resumeCamera();
        } else if (qrFormModel.userModel != null &&
            qrFormModel.userModel!.approved == "1") {
          await PopupDialog.showSuccess(context,
              content: "គណនីត្រូវបានអនុញ្ញាតរួចរាល់");
          await this.controller.resumeCamera();
        }
      }
    } else {
      await PopupDialog.showFailed(context, content: res.description!);
      await this.controller.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission or Camera not Available')),
      );
    }
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    await controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 180.0
        : 280.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ស្កេន QR Code',
          style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18, color: Colors.white),
        ),
        backgroundColor: StyleColor.appBarColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            QRView(
              key: keyQR,
              onQRViewCreated: _onQRViewCreated,
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
              overlay: QrScannerOverlayShape(
                borderColor: StyleColor.appBarColor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(bottom: 40),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2)),
                        child: IconButton(
                          onPressed: () async {
                            await this.controller.toggleFlash();
                            isFlashOn = !isFlashOn;
                            setState(() {});
                          },
                          icon: isFlashOn
                              ? Icon(color: Colors.grey, Icons.flash_on)
                              : Icon(color: Colors.grey, Icons.flash_off),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2)),
                        child: IconButton(
                          onPressed: () async {
                            await controller.pauseCamera();
                            var file = await PopupDialog.getImage(context);
                            if (file != null) {
                              String qrData =
                                  await Singleton.instance.getQRData(file.path);
                              if (qrData != "") {
                                await fetchQRData(qrData);
                              } else {
                                await PopupDialog.showFailed(context,
                                    content: "រកមិនឃើញ QR Code");
                                await controller.resumeCamera();
                              }
                            } else {
                              await controller.resumeCamera();
                            }
                          },
                          icon: Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
