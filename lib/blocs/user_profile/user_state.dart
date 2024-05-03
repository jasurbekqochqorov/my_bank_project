import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/data/models/user_model.dart';

class UserState extends Equatable {

  final UserModel userModel;
  final FormsStatus formsStatus;
  final String errorMessage;
  final String statusMessage;


  const UserState({
    required this.formsStatus,
    required this.userModel,
    required this.statusMessage,
    required this.errorMessage
  });

  UserState copyWith({
    UserModel? userModel,
    FormsStatus? formsStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserState(
      formsStatus: formsStatus ?? this.formsStatus,
      userModel: userModel ?? this.userModel,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        userModel,
        errorMessage,
        formsStatus,
        statusMessage,
      ];
}
