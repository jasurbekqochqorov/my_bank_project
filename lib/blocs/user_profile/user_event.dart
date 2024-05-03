

import 'package:equatable/equatable.dart';
import 'package:my_bank_project/data/models/user_model.dart';

abstract class UserEvent extends Equatable{
@override
List<Object?>get props=>[];}



class AddUserEvent extends UserEvent{
  final UserModel userModel;
  AddUserEvent({required this.userModel});
  @override
  List<Object?>get props=>[
    userModel
  ];
}

class UpdateUserEvent extends UserEvent{
  final UserModel userModel;
  UpdateUserEvent({required this.userModel});
  @override
  List<Object?>get props=>[
    userModel
  ];
}


class DeleteUserEvent extends UserEvent{
  final UserModel userModel;
  DeleteUserEvent({required this.userModel});
  @override
  List<Object?>get props=>[
    userModel
  ];
}

class GetUserByDocIdEvent extends UserEvent{
  final String docId;
  GetUserByDocIdEvent({required this.docId});
  @override
  List<Object?>get props=>[
  docId
    ];
}
class GetUserByUIDEvent extends UserEvent{

  final String uid;
  GetUserByUIDEvent({required this.uid});
  @override
  List<Object?>get props=>[
  ];
}




