import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_bank_project/blocs/card/card_bloc.dart';
import 'package:my_bank_project/blocs/card/card_event.dart';
import 'package:my_bank_project/blocs/card/card_state.dart';
import 'package:my_bank_project/data/models/card_model.dart';
import 'package:my_bank_project/screen/tab/card/widgets/card_number.dart';
import 'package:my_bank_project/screen/tab/card/widgets/expire_date.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/images/app_images.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController cardController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
  FocusNode cardFocusNode=FocusNode();
  FocusNode expireDataFocusNode=FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_151940,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,size: 20.w,),color: AppColors.white,),
        backgroundColor: AppColors.c_151940,
        title:  Text("Add Card Screen",style: AppTextStyle.interMedium.copyWith(
          color:AppColors.white,fontSize: 24.w
        ),),
      ),
      body: BlocConsumer<CardBloc, CardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: Column(
                children: [
                  Container(
                    height: 163.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal:15.w,vertical: 16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.c_2567F9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AppImages.visa,width:25.w,height:25.h,),
                        SizedBox(height: 4.h,),
                        Text('Platinum',style: AppTextStyle.interMedium.copyWith(
                          color: AppColors.white,fontSize: 16.w
                        ),),
                        const Spacer(),
                        Text('........',style: AppTextStyle.interMedium.copyWith(
                          color: AppColors.white,fontSize: 35.w
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextField(
                    cursorColor: AppColors.white,
                    controller:nameController,
                    decoration: InputDecoration(
                        hintText: "card user",
                        hintStyle: AppTextStyle.interMedium.copyWith(
                            color: AppColors.white
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                width: 1.w,
                                color: AppColors.c_858BE9)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                width: 1.w,
                                color:AppColors.c_858BE9))),
                  ),
                  SizedBox(height: 20.h,),
                  CardNumberInput(controller:cardController, focusNode: cardFocusNode,isSender: false,),
                  SizedBox(
                    height: 20.h,
                  ),
                  ExpireDate(controller: expireDateController, focusNode: expireDataFocusNode),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: width,
                    child: TextButton(
                      onPressed: () {
                        List<CardModel> db = state.cardsDb;
                        List<CardModel> myCards = state.userCards;
                        bool isExists = false;
                        for (var element in myCards) {
                          if (element.cardNumber == cardController.text) {
                            isExists = true;
                            break;
                          }
                        }
                        CardModel? cardModel;
                        bool hasInDb = false;
                        for (var element in db) {
                          if (element.cardNumber == cardController.text) {
                            hasInDb = true;
                            cardModel = element;
                            break;
                          }
                        }
                        if ((!isExists) && hasInDb) {
                          context
                              .read<CardBloc>()
                              .add(AddCardEvent(cardModel: cardModel!));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("ERROR"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.c_304FFE,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                      ),
                      child: Text(
                        "ADD",
                        style: AppTextStyle.interSemiBold
                            .copyWith(color: AppColors.white, fontSize: 16.w),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.statusMessage == 'added') {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
