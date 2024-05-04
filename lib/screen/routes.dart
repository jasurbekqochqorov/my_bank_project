import 'package:flutter/material.dart';
import 'package:my_bank_project/screen/local_auth/method_one/confirm_pin_screen.dart';
import 'package:my_bank_project/screen/local_auth/method_one/entry_screen.dart';
import 'package:my_bank_project/screen/local_auth/method_one/set_pin_screen.dart';
import 'package:my_bank_project/screen/local_auth/method_two/touch_id_screen.dart';
import 'package:my_bank_project/screen/payment/payment_screen.dart';
import 'package:my_bank_project/screen/splash/splash_screen.dart';
import 'package:my_bank_project/screen/tab/tab_screen.dart';
import 'package:my_bank_project/screen/transfer/transfer_screen.dart';
import 'package:my_bank_project/screen/update_profile/update_profile_screen.dart';
import 'auth/register/register_screen.dart';
import 'auth/singIn/auth_screen.dart';
import 'no_internet/no_internet_screen.dart';
import 'on_boarding/on_boarding_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.noInternetRoute:
        return navigate(NoInternetScreen(
            onInternetComeBack: settings.arguments as VoidCallback));

      case RouteNames.transferRoute:
        return navigate(const TransferScreen());
      case RouteNames.paymentRoute:
        return navigate(const PaymentScreen());
      case RouteNames.authRoute:
        return navigate(const AuthScreen());
      case RouteNames.register:
        return navigate(const RegisterScreen());
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
      case RouteNames.confirmPinRoute:
        return navigate(const ConfirmPinScreen());
      case RouteNames.entryRoute:
        return navigate(const EntryScreen());
      case RouteNames.setPinRoute:
        return navigate(const SetPinScreen());
      case RouteNames.touchIdRoute:
        return navigate(const TouchIdScreen());
      case RouteNames.updateProfile:
        return navigate(const UpdateProfileScreen());
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String authRoute = "/auth_route";
  static const String register = "/register_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String setPinRoute = "/set_pin_route";
  static const String confirmPinRoute = "/confirm_pin_route";
  static const String entryRoute = "/entry_route";
  static const String updateProfile = "/update_profile_route";
  static const String touchIdRoute = "/touch_id_route";
}
