import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/screen/routes.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({super.key});

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('OR'),
      SizedBox(height: 1.h,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: TextButton(onPressed: (){
          context.read<AuthBloc>().add(SignInWithGoogleEvent());
        },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.white,
            side: BorderSide(width: 1.w,color: AppColors.c_1A72DD)
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.google,width: 23.w,height: 23.h,fit: BoxFit.cover,),
            SizedBox(width: 10.w,),
            const Text('Login with Google'),
          ],),),
      ),
      SizedBox(height: 19.h,),
      TextButton(
        onPressed: (){
          Navigator.pushNamed(context,RouteNames.register);
        },
        child: RichText(text:TextSpan(
            text:'Don’t have an account? ',
            style: AppTextStyle.interRegular.copyWith(
                color: AppColors.black,fontSize: 11.w
            ),
            children: [
              TextSpan(
                text: ' Register now',
                style: AppTextStyle.interRegular.copyWith(
                    color: Colors.blue,fontSize: 11.w
                ),
              )
            ]
        )),
      )
    ],);
  }
}
