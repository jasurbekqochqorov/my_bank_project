import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/utils/colors/app_colors.dart';
import 'package:my_bank_project/utils/styles/app_text_style.dart';
import 'package:my_utils/my_utils.dart';
import '../../blocs/card/card_bloc.dart';
import '../../blocs/card/card_state.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/transaction/transaction_event.dart';
import '../../blocs/transaction/transaction_state.dart';
import '../../data/models/card_model.dart';
import '../tab/card/widgets/amount_input.dart';
import '../tab/card/widgets/card_item_view.dart';
import '../tab/card/widgets/card_number.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int selectedCardIndex = 0;

  final TextEditingController cardNumberController = TextEditingController();
  final FocusNode cardFocusNode = FocusNode();

  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  CardModel senderCard = CardModel.initial();
  CardModel receiverCard = CardModel.initial();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    senderCard = context.read<CardBloc>().state.userCards[0];
    List<CardModel> cards = context.read<CardBloc>().state.activeCards;
    cardNumberController.addListener(
      () {
        String receiverCardNumber =
            cardNumberController.text.replaceAll(" ", "");
        if (receiverCardNumber.length == 16) {
          for (var element in cards) {
            if (element.cardNumber == receiverCardNumber &&
                senderCard.cardNumber != receiverCardNumber) {
              receiverCard = element;
              debugPrint("LLLLLLLLLLLLLLLLLLLLLL${receiverCard.cardNumber}");
              context
                  .read<TransactionBloc>()
                  .add(SetReceiverCardEvent(cardModel: receiverCard));
              context
                  .read<TransactionBloc>()
                  .add(SetSenderCardEvent(cardModel: senderCard));

              setState(() {});
              break;
            } else {
              receiverCard = CardModel.initial();
            }
          }
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Transfer screen"),
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 15,
                              blurRadius: 10,
                              offset: const Offset(10, 10),
                            )
                          ]),
                      child: CardNumberInput(
                        function:(v) {
                          if (v.replaceAll(" ", "").length == 16) {
                            cardFocusNode.unfocus();
                          }
                          setState(() {});
                        },
                        isSender: true,
                        controller: cardNumberController,
                        focusNode: cardFocusNode,
                      ),
                    ),
                    Visibility(
                      visible: cardNumberController.text.length == 19,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            receiverCard.cardHolder.isEmpty ? "User not found" : receiverCard.cardHolder,
                            style: AppTextStyle.interSemiBold.copyWith(
                              fontSize: 14.w,
                              color:(receiverCard.cardHolder.isEmpty)?Colors.red: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5.w,)
                        ],
                      ),
                    ),
                    Visibility(
                      child: AmountInput(
                        controller: amountController,
                        focusNode: amountFocusNode,
                        amount: (amount) {
                          if (amount >= 1000) {
                            context
                                .read<TransactionBloc>()
                                .add(SetAmountEvent(amount: amount));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: List.generate(
                  state.userCards.length,
                  (index) {
                    CardModel cardModel = state.userCards[index];
                    return CardItemView(
                      isSender: true,
                      cardNumber: cardModel.cardNumber,
                      cardModel: cardModel,
                    );
                  },
                ),
                options: CarouselOptions(
                  aspectRatio: 16 / 8.4,
                  viewportFraction: 0.93,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  onPageChanged: (index, reason) {
                    selectedCardIndex = index;
                    debugPrint("INDEX:$index");
                    senderCard = state.userCards[index];
                  },
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.1,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              BlocListener<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state.statusMessage == "not_validated") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Ma'lumotlar xato!"),
                        ),
                      );
                    } else if (state.statusMessage == "validated") {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<TransactionBloc>()
                            .add(CheckValidationEvent());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.c_304FFE,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        "Yuborish",
                        style: AppTextStyle.interMedium
                            .copyWith(color: AppColors.white, fontSize: 16.w),
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}
