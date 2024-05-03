import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_bloc.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.storage,size: 25.w,),
        actions: [Icon(Icons.more_horiz,size: 25.w,)],
      ),
      body:Padding(
        padding:EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(children: [
          SizedBox(height: 40.h,),
          Text("Edit Profile",style: AppTextStyle.interSemiBold.copyWith(
            color:AppColors.black,fontSize: 24.w
          ),),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Icon(Icons.account_circle_rounded,size: 100.w,),
            ],),
          )
        ],),
      ),
    );
  }
}
