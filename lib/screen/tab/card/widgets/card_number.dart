import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';

class CardNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSender;

  const CardNumberInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isSender,
  });

  @override
  State<CardNumberInput> createState() => _CardNumberInputState();
}

class _CardNumberInputState extends State<CardNumberInput> {
  bool obscure = false;

  var maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      focusNode: widget.focusNode,
      controller: widget.controller,
      inputFormatters: [maskFormatter],
      onChanged: (v) {
        if (v.replaceAll(" ", "").length == 16) {
          widget.focusNode.unfocus();
        }
        setState(() {});
      },
      decoration: InputDecoration(
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
          onPressed: () {
            widget.controller.clear();
          },
          icon:Icon(Icons.clear,color:(widget.isSender)?AppColors.black:AppColors.white,),
        )
            : null,
        contentPadding:
        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        hintText: "Enter card number",
        hintStyle:  TextStyle(color:(widget.isSender)?AppColors.black.withOpacity(0.3):AppColors.white, fontSize: 16.w),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:BorderSide(color:(widget.isSender)?AppColors.black:AppColors.c_858BE9),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(color:(widget.isSender)?AppColors.black:AppColors.c_858BE9),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style:  TextStyle(
        fontSize: 16.w,
        color: (widget.isSender)?AppColors.black:Colors.white,
      ),
      keyboardType: TextInputType.number,
      // maxLines: ,
      textAlign: TextAlign.start,
    );
  }
}
