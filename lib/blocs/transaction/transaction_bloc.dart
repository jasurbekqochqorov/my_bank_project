import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/transaction/transaction_event.dart';
import 'package:my_bank_project/blocs/transaction/transaction_state.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/data/repositories/cards_repositroy.dart';

import '../../data/models/card_model.dart';
import '../../data/models/network.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.cardsRepository})
      : super(TransactionState(
          status: FormsStatus.pure,
          errorMessage: '',
          statusMessage: '',
          amount: 0,
          receiverCard:CardModel.initial(),
          senderCard:CardModel.initial(),
        )
  ) {
    on<SetAmountEvent> (_setAmount);
    on<SetReceiverCardEvent> (_setReceiverCard);
    on<SetSenderCardEvent> (_setSendCard);
    on<CheckValidationEvent>(_checkValidation);
  }

  final CardsRepository cardsRepository;
  _setAmount(SetAmountEvent event,emit){
    emit(state.copyWith(amount: event.amount));
  }

  _setReceiverCard(SetReceiverCardEvent event,emit){
    emit(state.copyWith(receiverCard: event.cardModel));
  }

  _setSendCard(SetSenderCardEvent event, emit){
    emit(state.copyWith(senderCard: event.cardModel));
  }

  _checkValidation(CheckValidationEvent event, emit) {

    debugPrint("RECEIVER CARD : ${state.receiverCard.cardNumber}");
    debugPrint("SENDER CARD : ${state.senderCard.cardNumber}");
    debugPrint("AMOUNT : ${state.amount}");

    if (state.amount < 1000 ||
        state.receiverCard.cardNumber.length != 16 ||
        state.senderCard.balance < 1000 ||
        state.senderCard.balance < state.amount) {
      emit(state.copyWith(statusMessage: "not_validated"));
      return;
    }
    emit(state.copyWith(statusMessage: "validated"));
    add(RunTransactionEvent());
  }

  _runTransactionEvent(RunTransactionEvent event,emit)async{
    CardModel cardSender=state.senderCard;
    CardModel cardReceiver=state.receiverCard;
    cardReceiver=cardReceiver.copyWith(
      balance:cardReceiver.balance+state.amount
    );
    cardSender=cardSender.copyWith(
      balance: cardSender.balance-state.amount
    );

    bool isUpdate1=await updateCard(cardSender);
    bool isUpdate2=await updateCard(cardReceiver);

    if(isUpdate2 && isUpdate1){
      emit(
        state.copyWith(
          statusMessage: "Transaction_success",
          status: FormsStatus.success
        )
      );
    }
  }

updateCard(CardModel cardModel)async{
  NetworkResponse networkResponse=await cardsRepository.updateCard(cardModel);
  if(networkResponse.errorText.isNotEmpty){
  }
  else{}
}

}
