import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

class CustomKeyboardView extends StatelessWidget {
  const CustomKeyboardView({
    super.key,
    required this.number,
    required this.isBiometric,
    required this.onClearButton,
    required this.onFingerButton,
  });

  final ValueChanged<String> number;
  final bool isBiometric;
  final VoidCallback onClearButton;
  final VoidCallback onFingerButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          ...List.generate(9, (index) {
            return IconButton(
                onPressed: () {
                  number.call("${index + 1}");
                },
                icon: Text(
                  "${index + 1}",
                  style: AppTextStyle.interBold
                      .copyWith(color: AppColors.black, fontSize: 20.w),
                ));
          }),
          Visibility(
            visible: isBiometric,
              child: IconButton(
            onPressed:onFingerButton,
            icon:const Icon(Icons.fingerprint),
          )),
          IconButton(
            onPressed: () {
              number.call("0");
            },
            icon: Text(
              "0",
              style: AppTextStyle.interBold
                  .copyWith(color: AppColors.black, fontSize: 18.w),
            ),
          ),
          IconButton(onPressed: onClearButton, icon: const Icon(Icons.clear)),
        ],
      ),
    );
  }
}
