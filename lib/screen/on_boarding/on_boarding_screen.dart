import 'package:flutter/material.dart';
import 'package:my_bank_project/screen/on_boarding/pages/boarding_page_one.dart';
import 'package:my_bank_project/screen/on_boarding/pages/boarding_page_three.dart';
import 'package:my_bank_project/screen/on_boarding/pages/boarding_page_two.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

import '../../data/local/storage_repository.dart';
import '../routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(children: [
              TextButton(onPressed: (){
                setState(() {});
                if(activeIndex!=0){
                  activeIndex-=1;
                  controller.animateToPage(
                    activeIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                }
              }, child:Text("Back",style: AppTextStyle.interMedium.copyWith(
                  color: AppColors.c_151940,fontSize: 16.w
              ),)),
              const Spacer(),
              TextButton(onPressed: (){
                Navigator.pushReplacementNamed(
                    context, RouteNames.authRoute);
              }, child:Text("Skip",style: AppTextStyle.interMedium.copyWith(
                  color: AppColors.c_151940,fontSize: 16.w
              ))),
            ],),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {},
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                BoardingPageOne(),
                BoardingPageTwo(),
                BoardingPageThree(),
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal:33.w),
            child: Row(children: [
              Text('${activeIndex+1}/3',style: AppTextStyle.interRegular.copyWith(
                color: AppColors.c_151940,fontSize:16.w
              ),),
              const Spacer(),
              TextButton(
                onPressed: () {
                  if (activeIndex == 2) {
                    StorageRepository.setBool(
                      key: "is_new_user",
                      value: true,
                    ).then(
                          (value) {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.authRoute);
                      },
                    );
                  } else {
                    activeIndex += 1;
                    controller.animateToPage(
                      activeIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                    setState(() {});
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.c_151940,
                    padding: EdgeInsets.symmetric(horizontal:22.w,vertical:30.h)
                ),
                child: Text("Next",style: AppTextStyle.interBold.copyWith(
                    color: AppColors.white,fontSize: 18.w
                ),),
              ),
            ],),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
