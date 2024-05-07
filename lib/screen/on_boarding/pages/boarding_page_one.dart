import 'package:flutter/material.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

import '../../../utils/images/app_images.dart';


class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 25.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(AppImages.img1,width: 279.w,height: 204.h,),
          SizedBox(height: 62.h,),
          Text('The right relationship is everything.',textAlign: TextAlign.center,style: AppTextStyle.interBold.copyWith(
            color: AppColors.c_151940,fontSize: 25.w,
          ),),
          SizedBox(height: 24.h,),
          Text('Your Trusted Partner in Financial Success',style: AppTextStyle.interRegular.copyWith(
            color: AppColors.c_151940,fontSize: 16.w
          ),),
        ],),
      ),
    );
  }
}
