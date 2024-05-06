import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_bank_project/data/models/card_model.dart';
import 'package:my_bank_project/data/models/user_model.dart';

import '../../utils/constants/app_constants.dart';
import '../models/network.dart';

class CardsRepository {
  Future<NetworkResponse> addUser(CardModel cardModel) async {
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

  Future<NetworkResponse> updateUser(CardModel cardModel) async {
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

  Future<NetworkResponse> deleteUser(String docId) async {
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

  Stream<List<CardModel>> getUserByDocID(String userId) {
    return FirebaseFirestore.instance
        .collection(AppConstants.cards)
        .where("userId", isEqualTo: userId)
        .snapshots().map((event) =>
        event.docs.map((doc) => CardModel.fromJson(doc.data())).toList());
  }

}
