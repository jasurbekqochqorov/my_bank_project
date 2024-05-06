import 'package:flutter/material.dart';
import 'package:my_bank_project/data/local/storage_repository.dart';
import 'package:my_bank_project/services/boimetric_auth_service.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';
import '../../../utils/colors/app_colors.dart';
import '../../routes.dart';

class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 34.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint,size: 150.w),
              SizedBox(height: 10.h,),
            SizedBox(
              width: width,
              child: TextButton(onPressed:enabledBio,
                  style: TextButton.styleFrom(
                    backgroundColor:AppColors.c_2A3256,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                  child: Text("Biometric auth",style: AppTextStyle.interBold.copyWith(
                    color: AppColors.white,fontSize: 19.w
                  ),)),
            ),
              SizedBox(height: 10.h,),
              SizedBox(
                width: width,
                child: TextButton(onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
                },
                    style: TextButton.styleFrom(
                        backgroundColor:AppColors.c_2A3256,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                    ),child:Text("Skip",style: AppTextStyle.interBold.copyWith(
                        color: AppColors.white,fontSize: 19.w
                    ))),
              )
          ],),
        ),
      ),
    );
  }
  Future<void> enabledBio()async{
    bool authenticated=await BiometricAuthService.authenticate();
    if(authenticated){
      await StorageRepository.setBool(key: 'biometrics', value:true);
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biometrics saved"))
      );
    }
    else{
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biometrics Error"))
      );
    }
    if(!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
  }
}
