import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/styles/app_text_style.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.icon,
    required this.text,
    this.i = false,
    required this.controller, required this.regExp,
  });

  final String icon;
  final RegExp regExp;
  final String text;
  final bool? i;
  final TextEditingController controller;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool t = false;
  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34.w),
      child: Form(
        key: key,
        child: TextFormField(
          onChanged: (v) {
            setState(() {});
          },
          validator: (v) {
            if (v != null && v.isNotEmpty && widget.regExp.hasMatch(v)) {
              return null;
            }
            return "${widget.text} error";
          },
          controller: widget.controller,
          obscureText: widget.i! ? (t ? false : true) : false,
          style: AppTextStyle.interMedium
              .copyWith(color: AppColors.black, fontSize: 16.w),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
            // prefixIcon: IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(
            //     widget.icon,
            //     width: 26.w,
            //     height: 26.h,
            //   ),
            // ),
            hintStyle: AppTextStyle.interSemiBold,
            hintText: widget.text,
            suffixIcon: (widget.i!)
                ? IconButton(
                    onPressed: () {
                      t = !t;
                      setState(() {});
                    },
                    icon: (t)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.w, color: AppColors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(9),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.w, color: AppColors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(9),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.red),
              borderRadius: BorderRadius.circular(9),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.red),
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      ),
    );
  }
}
