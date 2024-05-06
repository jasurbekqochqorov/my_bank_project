import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/auth/auth_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_state.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/screen/routes.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile screen"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context,RouteNames.updateProfile);
          }, icon:Icon(Icons.edit,size: 25.w,))
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Padding(
            padding:EdgeInsets.symmetric(horizontal: 24.w,vertical:24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 100.w,
                  ),
                ),
                SizedBox(height: 20.h,),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal:8.w,vertical:4.w),
                  decoration: BoxDecoration(
                    color: AppColors.c_1A72DD,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 3.w,color: AppColors.black.withOpacity(0.4))
                  ),
                  child:Text(
                    "name:${state.userModel.username}",
                    style: AppTextStyle.interBold
                        .copyWith(color: AppColors.black, fontSize: 24.w),
                  ),
                ),
                SizedBox(height: 20.h,),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal:8.w,vertical:4.w),
                  decoration: BoxDecoration(
                      color: AppColors.c_1A72DD,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 3.w,color: AppColors.black.withOpacity(0.4))
                  ),
                  child:Text(
                    "last name:${state.userModel.lastname}",
                    style: AppTextStyle.interBold
                        .copyWith(color: AppColors.black, fontSize: 24.w),
                  ),
                ),
                SizedBox(height: 20.h,),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal:8.w,vertical:4.w),
                  decoration: BoxDecoration(
                      color: AppColors.c_1A72DD,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 3.w,color: AppColors.black.withOpacity(0.4))
                  ),
                  child:Text(
                    "email:${state.userModel.email}",
                    style: AppTextStyle.interBold
                        .copyWith(color: AppColors.black, fontSize: 24.w),
                  ),
                ),
                SizedBox(height: 20.h,),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal:8.w,vertical:4.w),
                  decoration: BoxDecoration(
                      color: AppColors.c_1A72DD,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 3.w,color: AppColors.black.withOpacity(0.4))
                  ),
                  child:Text(
                    "phone:${state.userModel.phoneNumber}",
                    style: AppTextStyle.interBold
                        .copyWith(color: AppColors.black, fontSize: 24.w),
                  ),
                ),
                SizedBox(height: 20.h,),
                InkWell(onTap: (){
                  Navigator.pushNamed(context,RouteNames.securityRoute);
                },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal:8.w,vertical:4.w),
                    decoration: BoxDecoration(
                        color: AppColors.c_1A72DD,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 3.w,color: AppColors.black.withOpacity(0.4))
                    ),
                    child:Text(
                      "Security",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.interBold
                          .copyWith(color: AppColors.black, fontSize: 24.w),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == FormsStatus.unauthenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.authRoute, (route) => false);
                    }
                  },
                  child: Center(
                    child: TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogOutUserEvent());
                        },
                        child: Text(
                          "Log out",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.interBold
                              .copyWith(color: Colors.red, fontSize: 20.w),
                        )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
