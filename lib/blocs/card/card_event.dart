import 'package:equatable/equatable.dart';
import 'package:my_bank_project/data/models/card_model.dart';

abstract class CardEvent extends Equatable{}

class  AddCardEvent extends CardEvent{

  final CardModel cardModel;
  AddCardEvent({
    required this.cardModel
});

  @override
  // TODO: implement props
  List<Object?> get props => [
    cardModel
  ];
}

class  DeleteCardEvent extends CardEvent{

  final String cardDocId;
  DeleteCardEvent({
    required this.cardDocId
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    cardDocId
  ];
}

class  UpdateCardEvent extends CardEvent{

  final CardModel cardModel;
  UpdateCardEvent({
    required this.cardModel
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    cardModel
  ];
}

class  GetCardByUserIdEvent extends CardEvent{

  final String userId;
  GetCardByUserIdEvent({
    required this.userId
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    userId
  ];
}