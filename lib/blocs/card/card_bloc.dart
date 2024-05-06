import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/card/card_event.dart';
import 'package:my_bank_project/blocs/card/card_state.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/data/models/network.dart';
import 'package:my_bank_project/data/repositories/cards_repositroy.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc({required this.cardsRepository}) :super(
      CardState(formsStatus: FormsStatus.pure,
        statusMessage: '',
        errorMessage: '',
        userCards: [],)
  ){
    on<AddCardEvent>(addCard);
    on<UpdateCardEvent>(updateCard);
    on<DeleteCardEvent>(deleteCard);
    on<GetCardByUserIdEvent>(listenCard);
  }

  final CardsRepository cardsRepository;

  addCard(AddCardEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=await cardsRepository.addUser(event.cardModel);
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
  updateCard(UpdateCardEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=await cardsRepository.updateUser(event.cardModel);
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
    NetworkResponse networkResponse=await cardsRepository.deleteUser(event.cardDocId);
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
  listenCard(GetCardByUserIdEvent event,emit)async{}

}