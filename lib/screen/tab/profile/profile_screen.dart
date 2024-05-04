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
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Icon(
                  Icons.account_circle_rounded,
                  size: 100.w,
                ),
                Text(
                  "${state.userModel.username} ${state.userModel.lastname}",
                  style: AppTextStyle.interBold
                      .copyWith(color: AppColors.black, fontSize: 24.w),
                ),
                Text(state.userModel.email,style: AppTextStyle.interMedium.copyWith(
                  color: AppColors.black,fontSize: 14.w
                ),),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == FormsStatus.unauthenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.authRoute, (route) => false);
                    }
                  },
                  child: TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogOutUserEvent());
                      },
                      child: Text(
                        "Log out",
                        style: AppTextStyle.interBold
                            .copyWith(color: Colors.red, fontSize: 16),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
