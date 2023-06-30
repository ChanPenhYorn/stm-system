import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stm_report_app/Extension/AppRoute.dart';
import 'package:stm_report_app/Infrastructor/ProviderListener.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Singleton.instance.apiExtensionInit();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  setPathUrlStrategy();
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => ChangeNotifierProvider(
  //       create: (context) => ProviderListener(),
  //       child: EasyLocalization(
  //         supportedLocales: [
  //           Locale('km', 'KH'),
  //           Locale('en', 'US'),
  //         ],
  //         fallbackLocale: Locale('en', 'US'),
  //         startLocale: Locale('km', 'KH'),
  //         path: 'assets/langs',
  //         saveLocale: true,
  //         child: MyApp(),
  //       ),
  //     ),
  //   ),
  // );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderListener(),
      child: EasyLocalization(
        supportedLocales: [
          Locale('km', 'KH'),
          Locale('en', 'US'),
        ],
        fallbackLocale: Locale('en', 'US'),
        startLocale: Locale('km', 'KH'),
        path: 'assets/langs',
        saveLocale: true,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    // TODO: implement build
    return MaterialApp.router(
      title: 'STM Report System',
      routerConfig: AppRoute.routes,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        // useMaterial3: true,
        appBarTheme: AppBarTheme(
            color: StyleColor.appBarColor, elevation: 2, centerTitle: true),
        primaryColor: StyleColor.appBarColor,
        scaffoldBackgroundColor: Colors.white,
        focusColor: StyleColor.appBarColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: StyleColor.appBarColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.only(
            left: 10,
            top: 13,
            right: 10,
            bottom: 15,
          ),
          labelStyle: StyleColor.textStyleKhmerContent,
          errorStyle: StyleColor.textStyleKhmerContent12Grey,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: StyleColor.textStyleKhmerContentAuto(
            color: StyleColor.appBarColor,
          ),
          counterStyle: TextStyle(fontSize: 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: StyleColor.appBarColor, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Colors.pink,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
