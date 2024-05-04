import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_event.dart';
import 'package:my_bank_project/blocs/user_profile/user_state.dart';
import 'package:my_bank_project/data/models/user_model.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.storage,
            size: 25.w,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  size: 25.w,
                ))
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          nameController.text = state.userModel.username;
          lastnameController.text = state.userModel.lastname;
          phoneController.text = state.userModel.phoneNumber;
          passwordController.text = state.userModel.password;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "Edit Profile",
                          style: AppTextStyle.interSemiBold
                              .copyWith(color: AppColors.black, fontSize: 24.w),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle_rounded,
                                size: 100.w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Name",
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16.w),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextField(
                          controller: nameController,
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 10.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Last Name",
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16.w),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextField(
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16),
                          controller: lastnameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 10.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Phone number",
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16.w),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextField(
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16),
                          controller: phoneController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 10.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Password",
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16.w),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextField(
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.black, fontSize: 16),
                          controller: passwordController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 10.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: TextButton(
                      onPressed: () {
                        UserModel user=state.userModel;
                        user=user.copyWith(
                          username: nameController.text,
                          password: passwordController.text,
                          lastname: lastnameController.text,
                          phoneNumber: phoneController.text
                        );
                        context.read<UserBloc>().add(UpdateUserEvent(userModel: user));
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppColors.c_151940,
                          padding: EdgeInsets.symmetric(vertical: 8.h)),
                      child: Text(
                        "Save Changes",
                        style: AppTextStyle.interMedium
                            .copyWith(color: AppColors.white, fontSize: 18.w),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          );
        }));
  }
}
