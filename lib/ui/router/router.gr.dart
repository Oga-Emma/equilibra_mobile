// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../model/dto/room_dto.dart';
import '../screens/auth/complete_signup/complete_signup.dart';
import '../screens/auth/landing_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/reset_password_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/room/rooms_list_screen.dart';
import '../screens/home/setting/settings/change_diaspora.dart';
import '../screens/home/setting/settings/change_password_screen.dart';
import '../screens/home/setting/settings/change_state_of_residence.dart';
import '../screens/home/setting/settings/edit_profile_screen.dart';
import '../screens/home/setting/settings_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String landingScreen = '/landing-screen';
  static const String loginScreen = '/login-screen';
  static const String resetPasswordScreen = '/reset-password-screen';
  static const String signupScreen = '/signup-screen';
  static const String homeScreen = '/home-screen';
  static const String completeSignupScreen = '/complete-signup-screen';
  static const String roomGroupsListScreen = '/room-groups-list-screen';
  static const String settingsScreen = '/settings-screen';
  static const String editProfileScreen = '/edit-profile-screen';
  static const String changeDiaspora = '/change-diaspora';
  static const String changePasswordScreen = '/change-password-screen';
  static const String changeStateOfResidence = '/change-state-of-residence';
  static const all = <String>{
    splashScreen,
    landingScreen,
    loginScreen,
    resetPasswordScreen,
    signupScreen,
    homeScreen,
    completeSignupScreen,
    roomGroupsListScreen,
    settingsScreen,
    editProfileScreen,
    changeDiaspora,
    changePasswordScreen,
    changeStateOfResidence,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.landingScreen, page: LandingScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.resetPasswordScreen, page: ResetPasswordScreen),
    RouteDef(Routes.signupScreen, page: SignupScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.completeSignupScreen, page: CompleteSignupScreen),
    RouteDef(Routes.roomGroupsListScreen, page: RoomGroupsListScreen),
    RouteDef(Routes.settingsScreen, page: SettingsScreen),
    RouteDef(Routes.editProfileScreen, page: EditProfileScreen),
    RouteDef(Routes.changeDiaspora, page: ChangeDiaspora),
    RouteDef(Routes.changePasswordScreen, page: ChangePasswordScreen),
    RouteDef(Routes.changeStateOfResidence, page: ChangeStateOfResidence),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    LandingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LandingScreen(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    ResetPasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResetPasswordScreen(),
        settings: data,
      );
    },
    SignupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    CompleteSignupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CompleteSignupScreen(),
        settings: data,
      );
    },
    RoomGroupsListScreen: (data) {
      final args = data.getArgs<RoomGroupsListScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RoomGroupsListScreen(args.group),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
        settings: data,
      );
    },
    EditProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileScreen(),
        settings: data,
      );
    },
    ChangeDiaspora: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangeDiaspora(),
        settings: data,
      );
    },
    ChangePasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangePasswordScreen(),
        settings: data,
      );
    },
    ChangeStateOfResidence: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangeStateOfResidence(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// RoomGroupsListScreen arguments holder class
class RoomGroupsListScreenArguments {
  final RoomGroupDTO group;
  RoomGroupsListScreenArguments({@required this.group});
}
