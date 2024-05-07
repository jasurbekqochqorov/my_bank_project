import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/card/card_bloc.dart';
import 'package:my_bank_project/blocs/card/card_event.dart';
import 'package:my_bank_project/blocs/card/card_state.dart';
import 'package:my_bank_project/blocs/user_profile/user_bloc.dart';
import 'package:my_bank_project/data/models/card_model.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController cardController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Card Screen"),
      ),
      body: BlocConsumer<CardBloc, CardState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: Column(
              children: [
                TextField(
                  controller: cardController,
                  decoration: InputDecoration(
                      hintText: "Card Number",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 1,
                              color: AppColors.black.withOpacity(0.4))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 1,
                              color: AppColors.black.withOpacity(0.4)))),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: expireDateController,
                  decoration: InputDecoration(
                      hintText: "expire date",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 1,
                              color: AppColors.black.withOpacity(0.4))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 1,
                              color: AppColors.black.withOpacity(0.4)))),
                ),
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
