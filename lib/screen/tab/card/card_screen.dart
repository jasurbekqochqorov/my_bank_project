import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_bank_project/blocs/card/card_bloc.dart';
import 'package:my_bank_project/blocs/card/card_state.dart';
import 'package:my_bank_project/data/models/card_model.dart';
import 'package:my_bank_project/screen/routes.dart';
import 'package:my_bank_project/screen/tab/card/widgets/card_number.dart';
import 'package:my_bank_project/screen/tab/card/widgets/expire_date.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/images/app_images.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

import '../../../blocs/card/card_event.dart';
import '../../../blocs/user_profile/user_bloc.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  TextEditingController cardController=TextEditingController();
  FocusNode cardFocusNode=FocusNode();
  @override
  void initState() {
    context.read<CardBloc>().add(GetCardByUserIdEvent(
        userId: context.read<UserBloc>().state.userModel.userId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card screen"),),
      body: BlocBuilder<CardBloc,CardState>(
        builder: (context,state){
            debugPrint("CARD STATE LENGTH${state.userCards.length}");
          return Padding(
            padding:EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
            child: Column(
              children: [
                CardNumberInput(controller:cardController, focusNode: cardFocusNode,isSender: true,),
                SizedBox(height: 26.h,),
                Text("O'tkasma summasi",style: AppTextStyle.interMedium.copyWith(
                  color: AppColors.black,fontSize: 16.w
                ),),
                SizedBox(height: 10.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 6,
                        child: SizedBox(width: 1.w,)),
                    Expanded(
                      flex:10,
                      child: TextField(
                        style: AppTextStyle.interMedium.copyWith(
                          color: AppColors.black,fontSize: 24.w
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "0 sum",
                          hintStyle: AppTextStyle.interMedium.copyWith(
                            color: AppColors.black.withOpacity(0.4),
                            fontSize: 24.w
                          ),
                          border:const OutlineInputBorder(
                            borderSide: BorderSide.none
                          )
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(width: 1.w,)),
                  ],
                ),
                SizedBox(height: 20.h,),
                Expanded(
                  child: ListView(children:List.generate(state.userCards.length, (index){
                    CardModel cardModel=state.userCards[index];
                    String cardNumber="";
                    for(int i=0; i<cardModel.cardNumber.length; i++){
                      if((i+1)%4==0){
                        cardNumber+=cardModel.cardNumber[i];
                        cardNumber+='  ';
                      }
                      else{
                        cardNumber+=cardModel.cardNumber[i];
                      }
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 26.w,vertical: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(int.parse("0xFF${cardModel.color}"))
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text(cardModel.bank,style: AppTextStyle.interBold.copyWith(
                            color: AppColors.white,fontSize: 20.w
                          ),),
                        ],),
                        SizedBox(height: 5.h,),
                          Row(children: [
                            Image.asset(AppImages.chip,width: 58.w,height: 30.h,),
                            SvgPicture.asset(AppImages.card,width: 30.w,height: 25.h,)
                          ],),
                          SizedBox(height: 10.h,),
                          Row(children: [
                            SizedBox(width: 10.w,),
                            Text(cardNumber,style: AppTextStyle.interBold.copyWith(
                                color: AppColors.white,fontSize: 22.w
                            ),),
                        ],),
                          SizedBox(height: 4.h,),
                          Center(child: Text(cardModel.expireDate,style: AppTextStyle.interBold.copyWith(
                            color: AppColors.white,fontSize:16.w
                          ),),),
                          SizedBox(height: 10.h,),
                          Row(children: [
                            SizedBox(width: 10.w,),
                            Text(cardModel.cardHolder,style: AppTextStyle.interBold.copyWith(
                              color: AppColors.white,fontSize: 16.w
                            ),),
                            const Spacer(),
                            Text('Uzcard',style: AppTextStyle.interBold.copyWith(
                              color: AppColors.white,fontSize: 15.w
                            ),)
                          ],)
                      ],)
                    );
                  }),),
                ),
                SizedBox(width: width,
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context,RouteNames.addCardRoute);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.c_304FFE,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                  ),child: Text("Add card",style:AppTextStyle.interSemiBold.copyWith(
                  color: AppColors.white,fontSize: 18.w
                ),),
                ),),
                SizedBox(height: 10.h,),
              ],
            ),
          );
        },
      ),
    );
  }
}
