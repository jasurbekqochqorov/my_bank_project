import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';

class ExpireDate extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const ExpireDate({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<ExpireDate> createState() => _ExpireDateState();
}

class _ExpireDateState extends State<ExpireDate> {
  bool obscure = false;

  var maskFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  _validateExpireDate(String dateText){

    int currentMonth=DateTime.now().month;
    int currentYear=DateTime.now().year%100;

    List<String> list=dateText.split('/');
    int monthNumber=int.parse(list[0]);
    int yearNumber=int.parse(list[1]);

    if(yearNumber<currentYear){
      widget.controller.clear();
      return;
    }
    if((monthNumber<currentMonth || monthNumber>12) && currentYear==yearNumber){
      widget.controller.clear();
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText:  obscure,
      focusNode: widget.focusNode,
      controller: widget.controller,
      inputFormatters: [maskFormatter],
      onChanged: (v) {
        if (v.replaceAll(" ", "").length ==5) {
          _validateExpireDate(v);
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
          icon: const Icon(Icons.clear,color: AppColors.white,),
        )
            : null,
        contentPadding:
        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        hintText: "Expire date",
        hintStyle:  TextStyle(color: AppColors.white, fontSize: 16.w),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.c_858BE9),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.c_858BE9),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style:  TextStyle(
        fontSize: 16.w,
        color: Colors.white,
      ),
      keyboardType: TextInputType.number,
      // maxLines: ,
      textAlign: TextAlign.start,
    );
  }
}
