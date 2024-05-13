import 'package:equatable/equatable.dart';
import 'package:my_bank_project/data/models/form_status.dart';

import '../../data/models/card_model.dart';

class CardState extends Equatable {
  final List<CardModel> userCards;
  final List<CardModel> cardsDb;
  final List<CardModel> activeCards;
  final FormsStatus formsStatus;
  final String errorMessage;
  final String statusMessage;

   const CardState({
     required this.cardsDb,
     required this.activeCards,
    required this.formsStatus,
    required this.statusMessage,
    required this.errorMessage,
    required this.userCards,
  });

  CardState copyWith({
    List<CardModel>? userCards,
    List<CardModel>? cardsDb,
    List<CardModel>? activeCards,
    FormsStatus? formsStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return CardState(
      activeCards: activeCards ?? this.activeCards,
      cardsDb: cardsDb ?? this.cardsDb,
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      userCards: userCards ?? this.userCards,);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    userCards,
    activeCards,
    cardsDb,
    errorMessage,
    statusMessage,
    formsStatus
  ];

}