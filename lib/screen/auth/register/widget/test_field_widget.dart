import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class TextFormFieldWidgets extends StatefulWidget {
  const TextFormFieldWidgets({
    super.key,
    required this.text,
    this.i = false,
    required this.controller,
    required this.textInputType, 
    required this.regExp,
  });
  final RegExp regExp;
  final String text;
  final bool? i;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  State<TextFormFieldWidgets> createState() => _TextFormFieldWidgetsState();
}

class _TextFormFieldWidgetsState extends State<TextFormFieldWidgets> {
  bool t = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34.w),
      child: TextFormField(
        keyboardType:widget.textInputType,
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.red),
              borderRadius: BorderRadius.circular(9),
            )),
      ),
    );
  }
}