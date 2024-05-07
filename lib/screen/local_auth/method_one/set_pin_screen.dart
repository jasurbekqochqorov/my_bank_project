
import 'package:flutter/material.dart';
import 'package:my_bank_project/screen/local_auth/method_one/widget/custom_keyboard_view.dart';
import 'package:my_bank_project/screen/local_auth/method_one/widget/pin_put_view.dart';
import 'package:my_bank_project/screen/routes.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';
import 'package:pinput/pinput.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50.h,),
          Text(
            "Pin Kodni o'rnating",
            style: AppTextStyle.interSemiBold
                .copyWith(color: AppColors.black, fontSize: 18.w),
          ),
          SizedBox(height: 30.h,),
          SizedBox(
            width: width / 2,
            child: PinPutTextView(
              pinPutFocusNode: focusNode,
              pinPutController: pinController,
              isError: isError,
            ),
          ),
          SizedBox(height: 40.h,),
          CustomKeyboardView(
            number:(number){
              if(pinController.length<4){
                pinController.text+=number;
              }
              if(pinController.length==4){
                Navigator.pushNamed(context, RouteNames.confirmPinRoute,arguments: pinController.text);
                pinController.text='';
              }
            },
            isBiometric: true,
            onClearButton: (){
              if(pinController.length >0){
                pinController.text=pinController.text.substring(0,pinController.text.length-1);
              }
            },
            onFingerButton: (){

            },
          )
        ],
      ),
    );
  }
}
