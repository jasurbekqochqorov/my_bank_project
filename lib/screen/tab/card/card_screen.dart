import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/card/card_bloc.dart';
import 'package:my_bank_project/blocs/card/card_state.dart';
import 'package:my_bank_project/data/models/card_model.dart';
import 'package:my_bank_project/screen/routes.dart';
import 'package:my_bank_project/screen/tab/card/widgets/card_item_view.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
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
                Expanded(
                  child: ListView(children:List.generate(state.userCards.length, (index){
                    CardModel cardModel=state.userCards[index];
                    return CardItemView(cardModel:cardModel, cardNumber:cardModel.cardNumber,isSender: false,);
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
