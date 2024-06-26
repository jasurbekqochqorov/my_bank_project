import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/auth/auth_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_event.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/images/app_images.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';
import '../../data/local/storage_repository.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool hasPin=false;
  _init(bool isAuthenticated) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (!mounted) return;
    if (!isAuthenticated) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (!isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.authRoute);
      }
    } else {
      if(hasPin){
      Navigator.pushReplacementNamed(context, RouteNames.entryRoute);
      }
      else{
      Navigator.pushReplacementNamed(context, RouteNames.setPinRoute);
      }
    }
  }

  @override
  void initState() {
    hasPin=StorageRepository.getString(key: 'pin').isNotEmpty;
    debugPrint("AAA${StorageRepository.getString(key: 'pin')}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == FormsStatus.authenticated) {
              BlocProvider.of<UserBloc>(context).add(GetUserByUIDEvent(uid:FirebaseAuth.instance.currentUser!.uid),);
              _init(true);
            }
            else {
              _init(false);
            }
          }, child: Stack(
            children: [
              Image.asset(
                AppImages.splash1, width: width, height:height,fit: BoxFit.cover,),
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 25.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Text("NBU bank", style: AppTextStyle.interBold.copyWith(
                      color: AppColors.white, fontSize: 66.w,
                    ),),
                    Text('The right relationship is everything.',
                      style: AppTextStyle.interMedium.copyWith(
                          color: AppColors.white.withOpacity(0.7), fontSize: 18.w
                      ),)
                  ],),
                ),
              )
            ],),
        )
    );
  }
}
