import 'package:equatable/equatable.dart';
import 'package:my_bank_project/data/models/form_status.dart';

import '../../data/models/card_model.dart';

class CardState extends Equatable {
  final List<CardModel> userCards;
  final FormsStatus formsStatus;
  final String errorMessage;
  final String statusMessage;

   CardState({
    required this.formsStatus,
    required this.statusMessage,
    required this.errorMessage,
    required this.userCards,
  });

  CardState copyWith({
    List<CardModel>? userCards,
    FormsStatus? formsStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return CardState(
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      userCards: userCards ?? this.userCards,);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    userCards,
    errorMessage,
    statusMessage,
    formsStatus
  ];

}