import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/styles/app_text_style.dart';


class BoardingPageThree extends StatelessWidget {
  const BoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 25.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.img3,width: 279.w,height: 204.h,),
            SizedBox(height: 62.h,),
            Text('Your Comprehensive Resource for Financial Success',textAlign: TextAlign.center,style: AppTextStyle.interBold.copyWith(
              color: AppColors.c_151940,fontSize: 25.w,
            ),),
            SizedBox(height: 24.h,),
            Text('Choosing the Right Bank for Your Financial Goals',textAlign: TextAlign.center,style: AppTextStyle.interRegular.copyWith(
                color: AppColors.c_151940,fontSize: 16.w
            ),),
            const SizedBox(height: 20,),
          ],),
      ),
    );
  }
}
