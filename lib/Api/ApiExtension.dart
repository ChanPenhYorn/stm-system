import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Api/Domain.dart';
import 'package:stm_report_app/Entity/Token.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Infrastructor/Response/ResponseAPI.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:path_provider/path_provider.dart';

class ApiExtension {
  //Future Instance
  Future? GetConnection;
  void getConnectionInit(BuildContext context, {bool noLoading = false}) {
    GetConnection = getConnection(context, noLoading: noLoading);
  }

  Future<bool> getConnection(BuildContext context,
      {bool noLoading = false}) async {
    return true;
    if (!noLoading) AnimateLoading().showLoading(context);
    final res = await Singleton.instance.dio
        .get(
      Domain.domain + "api/v1/authentication/getconnection",
    )
        .catchError((err) {
      if (!noLoading) {
        Navigator.pop(context);
        PopupDialog.showPopup(context, "Message.OperationFailed".tr());
      }
    });

    if (res != null) {
      if (!noLoading) Navigator.pop(context);
      return true;
    } else
      return false;
  }

  //New Repository

  Future<ResponseRes<T, D>> get<T, D>({
    required BuildContext context,
    required String baseUrl,
    required D deserialize(dynamic e),
    String param = "",
    bool loading = false,
  }) async {
    try {
      if (loading) AnimateLoading().showLoading(context);
      Singleton.instance.dioBearerSecondTokenInitialize();
      final res = await Singleton.instance.dio
          .get(
        Domain.domain + "${baseUrl}?${param}",
        options: Options(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 501;
          },
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
            'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token'
          },
        ),
      )
          .catchError((err) {
        print('this error');
        print(err);
        if (loading) Navigator.of(context, rootNavigator: true).pop();
        PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
            success: 0);
      });
      if (loading) Navigator.of(context, rootNavigator: true).pop();
      return ResponseRes<T, D>.fromJson(res.data,
          deserialize: (e) => deserialize(e));
    } catch (err) {
      print('error zone');
      print(err);
      return ResponseRes.noDataResponse();
    }
  }

  Future<ResponseRes<T, D>> post<T, D>({
    required BuildContext context,
    required String baseUrl,
    D deserialize(dynamic e)?,
    required Map<String, dynamic> body,
    String param = "",
    bool loading = false,
  }) async {
    try {
      if (loading) AnimateLoading().showLoading(context);
      Singleton.instance.dioBearerSecondTokenInitialize();
      final res = await Singleton.instance.dio
          .post(
        Domain.domain + "${baseUrl}?${param}",
        data: body,
        options: Options(
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 501;
            }),
      )
          .catchError((err) {
        if (loading) Navigator.of(context, rootNavigator: true).pop();
        PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
            success: 0);
      });
      if (loading) Navigator.of(context, rootNavigator: true).pop();
      return ResponseRes<T, D>.fromJson(res.data,
          deserialize: (e) => deserialize!(e));
    } catch (err) {
      return ResponseRes.noDataResponse();
    }
  }

  Future<ResponseRes<T, D>> put<T, D>({
    required BuildContext context,
    required String baseUrl,
    D deserialize(dynamic e)?,
    required Map<String, dynamic> body,
    String param = "",
    bool loading = false,
  }) async {
    try {
      if (loading) AnimateLoading().showLoading(context);
      Singleton.instance.dioBearerSecondTokenInitialize();

      final res = await Singleton.instance.dio
          .put(
        Domain.domain + "${baseUrl}?${param}",
        data: body,
        options: Options(
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 501;
            }),
      )
          .catchError((err) {
        if (loading) Navigator.of(context, rootNavigator: true).pop();
        PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
            success: 0);
      });
      if (loading) Navigator.of(context, rootNavigator: true).pop();
      return ResponseRes<T, D>.fromJson(res.data,
          deserialize: (e) => deserialize!(e));
    } catch (err) {
      return ResponseRes.noDataResponse();
    }
  }

  Future<ResponseRes<T, D>> delete<T, D>({
    required BuildContext context,
    required String baseUrl,
    D deserialize(dynamic e)?,
    String param = "",
    bool loading = false,
  }) async {
    try {
      if (loading) AnimateLoading().showLoading(context);
      Singleton.instance.dioBearerSecondTokenInitialize();

      final res = await Singleton.instance.dio
          .delete(
        Domain.domain + "${baseUrl}?${param}",
        options: Options(
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 501;
            }),
      )
          .catchError((err) {
        if (loading) Navigator.of(context, rootNavigator: true).pop();
        PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
            success: 0);
      });
      print(res.data);
      if (loading) Navigator.of(context, rootNavigator: true).pop();
      return ResponseRes<T, D>.fromJson(res.data,
          deserialize: (e) => deserialize!(e));
    } catch (err) {
      return ResponseRes.noDataResponse();
    }
  }

  Future<File?> downloadFile(
      {required String url,
      required String filename,
      required String extension}) async {
    String dir =
        (await getTemporaryDirectory()).path + "/${filename}.${extension}";
    Response res = await Singleton.instance.dio.download(url, dir);
    if (res.statusCode == 200) return File(dir);
    return File("");
  }

  Future<Uint8List?> downloadReportFile(BuildContext context,
      {required String date, required periodType, required fileType}) async {
    try {
      AnimateLoading().showLoading(context);
      Singleton.instance.dioBearerSecondTokenInitialize();

      final res = await Singleton.instance.dio
          .get(
        Domain.domain +
            "${ApiEndPoint.vehicleRevenueExport}?type=${periodType}&file_type=${fileType}&date=${date}",
        options: Options(
            headers: {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
              'Access-Control-Allow-Headers':
                  'Origin, Content-Type, X-Auth-Token'
            },
            responseType: ResponseType.bytes,
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 501;
            }),
      )
          .catchError((err) {
        Navigator.pop(context);
        PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
            success: 0);
      });

      Navigator.of(context, rootNavigator: true).pop();
      return res.data;
    } catch (err) {
      return null;
    }
  }

  Future<Uint8List?> downloadReportCouponInvoiceFile(BuildContext context,
      {required String date,
      required periodType,
      required fileType,
      String? param = ""}) async {
    try {
      AnimateLoading().showLoading(context);
      Singleton.instance.dioBearerSecondTokenInitialize();

      final res = await Singleton.instance.dio
          .get(
        Domain.domain +
            "${ApiEndPoint.couponInvoiceExport}?from_date=${date}&to_date=${date}&file_type=${fileType}&type=daily&${param}",
        options: Options(
            headers: {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
              'Access-Control-Allow-Headers':
                  'Origin, Content-Type, X-Auth-Token'
            },
            responseType: ResponseType.bytes,
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 501;
            }),
      )
          .catchError((err) {
        Navigator.pop(context);
        PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
            success: 0);
      });

      Navigator.of(context, rootNavigator: true).pop();
      return res.data;
    } catch (err) {
      return null;
    }
  }

  Future<ResponseRes<Token, Token>> userLogin(
      BuildContext context, Map<String, dynamic> body,
      {bool noLoading = false}) async {
    Singleton.instance.dioBearerFirstTokenInitialize();
    if (!noLoading) AnimateLoading().showLoading(context);
    final res = await Singleton.instance.dio
        .post(
      Domain.domain + ApiEndPoint.login,
      options: Options(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 501;
          }),
      data: body,
    )
        .catchError((err) {
      if (!noLoading) Navigator.of(context, rootNavigator: true).pop();
      PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
          success: 0);
    });
    if (!noLoading) Navigator.of(context, rootNavigator: true).pop();

    return ResponseRes<Token, Token>.fromJson(res.data,
        deserialize: (e) => Token.fromJson(e));
  }

  Future<ResponseRes<UserModel, UserModel>> userRegister(
      BuildContext context, Map<String, dynamic> body,
      {bool noLoading = false}) async {
    Singleton.instance.dioBearerFirstTokenInitialize();
    if (!noLoading) AnimateLoading().showLoading(context);
    final res = await Singleton.instance.dio
        .post(
      Domain.domain + ApiEndPoint.register,
      options: Options(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 501;
          }),
      data: body,
    )
        .catchError((err) {
      if (!noLoading) Navigator.of(context, rootNavigator: true).pop();
      PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
          success: 0);
    });
    if (!noLoading) Navigator.of(context, rootNavigator: true).pop();

    return ResponseRes<UserModel, UserModel>.fromJson(res.data,
        deserialize: (e) => UserModel.fromJson(e));
  }

  Future<ResponseRes> postChangePassword(
      BuildContext context, Map<String, dynamic> body,
      {bool noLoading = false}) async {
    Singleton.instance.dioBearerSecondTokenInitialize();
    if (!noLoading) AnimateLoading().showLoading(context);
    final res = await Singleton.instance.dio
        .post(
      Domain.domain + ApiEndPoint.changePassword,
      options: Options(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 501;
          }),
      data: body,
    )
        .catchError((err) {
      if (!noLoading) Navigator.of(context, rootNavigator: true).pop();
      PopupDialog.showPopup(context, "Message.OperationFailed".tr(),
          success: 0);
    });
    if (!noLoading) Navigator.of(context, rootNavigator: true).pop();
    print(res.data);
    return ResponseRes.fromJson(res.data);
  }
}
