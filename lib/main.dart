import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:equilibra_mobile/di/controllers/data_controller.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart' as Router;
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'di/controllers/room_controller.dart';
import 'di/controllers/user_controller.dart';
import 'di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = new MyHttpOverrides();
  await init();
  runApp(
    MyApp(),
  );
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<DataController>(create: (_) => DataController()),
        ChangeNotifierProvider<RoomController>(create: (_) => RoomController())
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: 'Equilibra',
          theme: ThemeData(
            fontFamily: 'Soleil',
            primaryColor: Pallet.primaryColor,
            accentColor: Pallet.accentColor,
          ),
          builder: BotToastInit(), //1. call BotToastInit
          navigatorObservers: [BotToastNavigatorObserver()],
          navigatorKey: getIt<NavigationService>().navigatorKey,
          initialRoute: Router.Routes.splashScreen,
          onGenerateRoute: Router.Router().onGenerateRoute,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
