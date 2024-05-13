import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_bank_project/data/models/card_model.dart';
import 'package:my_utils/my_utils.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';

class CardItemView extends StatefulWidget {
  const CardItemView({super.key, required this.cardModel, required this.cardNumber,required this.isSender});
  final CardModel cardModel;
  final String cardNumber;
  final bool isSender;

  @override
  State<CardItemView> createState() => _CardItemViewState();
}

class _CardItemViewState extends State<CardItemView> {
  String card="";

  @override
  void initState() {
    widget.cardNumber.replaceAll(" ", "");
    for(int i=0; i<widget.cardNumber.length; i++){
      if((i+1)%4==0){
        card+=widget.cardNumber[i];
        card+='  ';
      }
      else{
        card+=widget.cardNumber[i];
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 26.w,vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(int.parse("0xFF${widget.cardModel.color}"))
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !widget.isSender,
                  child: Text(widget.cardModel.bank,style: AppTextStyle.interBold.copyWith(
                      color: AppColors.white,fontSize: 20.w
                  ),),
                ),
              ],),
            SizedBox(height: 5.h,),
            Row(children: [
              Image.asset(AppImages.chip,width: 58.w,height: 30.h,),
              SvgPicture.asset(AppImages.card,width: 30.w,height: 25.h,),
              const Spacer(),
              Text(
                NumberFormat.currency(locale: "uz").format(widget.cardModel.balance),
                style: AppTextStyle.interSemiBold.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],),
            SizedBox(height: 10.h,),
            Row(children: [
              SizedBox(width: 10.w,),
              Text(card,style: AppTextStyle.interBold.copyWith(
                  color: AppColors.white,fontSize: 22.w
              ),),
            ],),
            SizedBox(height: 4.h,),
            Center(child: Text(widget.cardModel.expireDate,style: AppTextStyle.interBold.copyWith(
                color: AppColors.white,fontSize:16.w
            ),),),
            Visibility(
                visible: !widget.isSender,
                child: SizedBox(height: 10.h,)),
            Row(children: [
              SizedBox(width: 10.w,),
              Text(widget.cardModel.cardHolder,style: AppTextStyle.interBold.copyWith(
                  color: AppColors.white,fontSize: 16.w
              ),),
              const Spacer(),
              Text('Uzcard',style: AppTextStyle.interBold.copyWith(
                  color: AppColors.white,fontSize: 15.w
              ),)
            ],)
          ],)
    );
  }
}
