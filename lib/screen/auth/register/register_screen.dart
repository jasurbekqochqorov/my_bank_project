import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/auth/auth_bloc.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/data/models/user_model.dart';
import 'package:my_bank_project/screen/auth/register/widget/bottom_information.dart';
import 'package:my_bank_project/screen/auth/register/widget/register_button.dart';
import 'package:my_bank_project/screen/auth/register/widget/test_field_widget.dart';
import 'package:my_bank_project/utils/constants/app_constants.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';
import '../../tab/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool k = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    User? user = FirebaseAuth.instance.currentUser;
    Future.microtask(() {
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      }
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  isValid() {
    return AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
        AppConstants.textRegExp.hasMatch(nameController.text) &&
        AppConstants.textRegExp.hasMatch(lastnameController.text) &&
        AppConstants.phoneRegExp.hasMatch(phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppImages.top,
                  width: 150.w,
                  height: 180.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Register',
                  style: AppTextStyle.interSemiBold
                      .copyWith(color: AppColors.black, fontSize: 22.w),
                ),
                SizedBox(
                  height: 26.h,
                ),
                TextFormFieldWidgets(
                  regExp: AppConstants.textRegExp,
                  textInputType: TextInputType.name,
                  text: 'Username',
                  controller: nameController,
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormFieldWidgets(
                  regExp: AppConstants.textRegExp,
                  textInputType: TextInputType.name,
                  text: 'Lastname',
                  controller: lastnameController,
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormFieldWidgets(
                  regExp: AppConstants.phoneRegExp,
                  textInputType: TextInputType.phone,
                  text: "Phone",
                  controller: phoneController,
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormFieldWidgets(
                  regExp: AppConstants.passwordRegExp,
                  textInputType: TextInputType.text,
                  text: "Password",
                  i: true,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 35.h,
                ),
                RegisterButton(
                  title: 'Register',
                  onTap: () {
                    context.read<AuthBloc>().add(RegisterUserEvent(
                        userModel: UserModel(fcm: "",
                          authId:'',
                          username:nameController.text,
                          password:passwordController.text,
                          imageUrl: '',
                          userId: '',
                          email:"${nameController.text}@gmail.com".trim(),
                          phoneNumber: phoneController.text.trim(),
                          lastname: lastnameController.text,
                        )));

                  },
                  isReady: isValid(),
                  isLoading: state.status == FormsStatus.loading,
                ),
                SizedBox(
                  height: 13.h,
                ),
                const InformationWidgets()
              ],
            ),
          );
        }, listener: (context, state) {
          if (state.status == FormsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.statusMessage,
                style: AppTextStyle.interBold
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ));
          }
          // if (state.status == FormsStatus.authenticated) {
          //   if(state.statusMessage=='registered'){
          //     BlocProvider.of<UserBloc>(context).add(AddUserEvent(userModel: state.userModel));
          //   }
          //   Navigator.pushNamedAndRemoveUntil(
          //     context,
          //     RouteNames.setPinRoute,
          //         (route) => false,
          //   );
          // }
        }));
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
