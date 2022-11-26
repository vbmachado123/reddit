// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../page/splash/splash_page.dart';
import 'core.dart';
// import 'package:registro/helpers/permissions_helper.dart';
// import 'package:registro/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // checkAllPermission(); //Solicitando Permissões pra não dar ruim

    void _portraitModeOnly() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    _portraitModeOnly();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          focusColor: AppColors.primary_0,
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        defaultTransition: Transition.cupertinoDialog,
        getPages: [
          GetPage(
            name: "/",
            page: () => SplashPage(),
          ),
        ]);

    // return MaterialApp(
    //   title: "Registro",
    //   home: SplashPage(),
    //   //Alterar para exibir a tela desejada
    //   builder: DevicePreview.appBuilder,
    //   locale: DevicePreview.locale(context),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
