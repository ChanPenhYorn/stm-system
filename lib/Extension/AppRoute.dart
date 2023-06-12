import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Widget/Authentication/ChangePassword.dart';
import 'package:stm_report_app/Widget/Authentication/Login.dart';
import 'package:stm_report_app/Widget/Home/Web/Dashboard_Web.dart';
import 'package:stm_report_app/Widget/Language/SelectLanguage.dart';
import 'package:stm_report_app/Widget/PriceList/PriceList.dart';
import 'package:stm_report_app/Widget/Setting/AdminSetting.dart';
import 'package:stm_report_app/Widget/Setting/Company/Company.dart';
import 'package:stm_report_app/Widget/Setting/Customer/Customer.dart';
import 'package:stm_report_app/Widget/Setting/Product/Product.dart';
import 'package:stm_report_app/Widget/Setting/Role/Role.dart';
import 'package:stm_report_app/Widget/Setting/User/User.dart';
import 'package:stm_report_app/Widget/Setting/User/UserProfileView.dart';
import 'package:stm_report_app/Widget/Setting/UserApproval/UserApproval.dart';
import 'package:stm_report_app/Widget/Setting/Zone/Zone.dart';
import 'package:stm_report_app/Widget/SplashScreen/SplashScreen.dart';

class AppRoute {
  static const splashScreen = "/";
  static const login = "/login";
  static const dashboardRoute = "/dashboard";
  static const selectLanguage = "/select-language";
  static const adminSetting = "/setting";
  static const userProfile = "/user-profile";
  static const changePassword = "/change-password";
  static const role = "/role";
  static const user = "/user";
  static const approval = "/approval";
  static const priceList = "/price_list";
  static const company = "/company";
  static const customer = "/customer";
  static const product = "/product";
  static const zone = "/zone";

  static final GoRouter routes = GoRouter(routes: <GoRoute>[
    GoRoute(
      path: splashScreen,
      builder: (BuildContext context, state) => SplashScreen(),
    ),
    GoRoute(
      path: login,
      builder: (BuildContext context, state) => Login(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: dashboardRoute,
      builder: (BuildContext context, state) => Dashboard(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: selectLanguage,
      builder: (BuildContext context, state) => SelectLanguage(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: adminSetting,
      builder: (BuildContext context, state) => AdminSetting(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: userProfile,
      builder: (BuildContext context, state) =>
          UserProfileView(userModel: state.extra as UserModel),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: changePassword,
      builder: (BuildContext context, state) => ChangePassword(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: role,
      builder: (BuildContext context, state) => Role(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: user,
      builder: (BuildContext context, state) => User(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: approval,
      builder: (BuildContext context, state) => UserApproval(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: priceList,
      builder: (BuildContext context, state) => PriceList(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: company,
      builder: (BuildContext context, state) => Company(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: customer,
      builder: (BuildContext context, state) => Customer(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: product,
      builder: (BuildContext context, state) => Product(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: zone,
      builder: (BuildContext context, state) => Zone(),
      redirect: (context, state) => _redirect(context),
    ),
  ]);

  static Future<String?> _redirect(BuildContext context) async {
    var token = await Singleton.instance.readLoginToken();
    print('res=${token}');
    return token == true ? null : "/login";
  }
}
