import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/card/card_event.dart';
import 'package:my_bank_project/blocs/card/card_state.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/data/models/network.dart';
import 'package:my_bank_project/data/repositories/cards_repositroy.dart';

import '../../data/models/card_model.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc({required this.cardsRepository}) :super(
      const CardState(
        cardsDb: [],
        formsStatus: FormsStatus.pure,
        statusMessage: '',
        errorMessage: '',
        userCards: [],)
  ){
    on<AddCardEvent>(addCard);
    on<UpdateCardEvent>(updateCard);
    on<DeleteCardEvent>(deleteCard);
    on<GetCardByUserIdEvent>(listenCard);
    on<GetCardsDatabaseEvent>(listenCardDatabase);
  }

  final CardsRepository cardsRepository;

  addCard(AddCardEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=await cardsRepository.addCard(event.cardModel);
    if(networkResponse.errorText.isNotEmpty){
      emit(state.copyWith(formsStatus: FormsStatus.success,statusMessage: "added"));
    }
    else{
      emit(
        state.copyWith(
          formsStatus: FormsStatus.error,
          errorMessage: networkResponse.errorText
        )
      );
    }
  }
  updateCard(UpdateCardEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=await cardsRepository.updateCard(event.cardModel);
    if(networkResponse.errorText.isNotEmpty){
      emit(state.copyWith(formsStatus: FormsStatus.success));
    }
    else{
      emit(
          state.copyWith(
              formsStatus: FormsStatus.error,
              errorMessage: networkResponse.errorText
          )
      );
    }
  }
  deleteCard(DeleteCardEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=await cardsRepository.deleteCard(event.cardDocId);
    if(networkResponse.errorText.isNotEmpty){
      emit(state.copyWith(formsStatus: FormsStatus.success));
    }
    else{
      emit(
          state.copyWith(
              formsStatus: FormsStatus.error,
              errorMessage: networkResponse.errorText
          )
      );
    }
  }
  listenCard(GetCardByUserIdEvent event,Emitter emit)async{
    await emit.onEach(
      cardsRepository.getCardByDocID(event.userId),
      onData:(List<CardModel> userCards){
        debugPrint("USER CARDS LENGTH${userCards.length}");
        emit(state.copyWith(userCards: userCards));
        debugPrint("CARDS USERS LENGTH${state.userCards.length}");
      }
    );
  }
  listenCardDatabase(GetCardsDatabaseEvent event,Emitter emit)async{
    await emit.onEach(
        cardsRepository.getCardDatabase(),
        onData:(List<CardModel> db){
          emit(state.copyWith(cardsDb: db));
        }
    );
  }

}