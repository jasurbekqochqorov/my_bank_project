import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_bank_project/data/models/card_model.dart';

import '../../utils/constants/app_constants.dart';
import '../models/network.dart';

class CardsRepository {
  Future<NetworkResponse> addCard(CardModel cardModel) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .add(cardModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(documentReference.id)
          .update({"cardId": documentReference.id});
      return NetworkResponse(data: 'success');
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Future<NetworkResponse> updateCard(CardModel cardModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(cardModel.cardId)
          .update(cardModel.toJsonForUpdate());
      return NetworkResponse(data: 'success');
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Future<NetworkResponse> deleteCard(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(docId)
          .delete();

      return NetworkResponse(data: 'success');
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Stream<List<CardModel>> getCardByDocID(String userId) {
    debugPrint("Kirdu");
    return FirebaseFirestore.instance
        .collection(AppConstants.cards)
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((event){
          debugPrint("EVENT:${event.docs.length}");
          return event.docs.map((doc) => CardModel.fromJson(doc.data())).toList();
    });
  }

  Stream<List<CardModel>> getCardDatabase() {
    return FirebaseFirestore.instance
        .collection(AppConstants.cardsDatabase)
        .snapshots()
        .map((event){
          return event.docs.map((doc){
            debugPrint("DATA LENGTH:${doc.data().length}");
            return CardModel.fromJson(doc.data());
          }).toList();
    });
  }
}
