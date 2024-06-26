import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/user_profile/user_event.dart';
import 'package:my_bank_project/blocs/user_profile/user_state.dart';
import 'package:my_bank_project/data/models/form_status.dart';
import 'package:my_bank_project/data/models/network.dart';
import 'package:my_bank_project/data/models/user_model.dart';
import 'package:my_bank_project/data/repositories/user_profile_repositroy.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userProfileRepository})
      : super(UserState(
          formsStatus: FormsStatus.pure,
          userModel:UserModel.initial(),
          statusMessage: '',
          errorMessage: '',
        )){
    on<AddUserEvent>(_addUser);
    on<DeleteUserEvent>(_deleteUser);
    on<UpdateUserEvent>(_updateUser);
    on<GetUserByDocIdEvent>(_getByDocIDUser);
    on<GetUserByUIDEvent>(_getByUIDUser);
  }
  final UserProfileRepository userProfileRepository;

  _addUser(AddUserEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=
        await userProfileRepository.addUser(event.userModel);
    if(networkResponse.errorCode.isEmpty){
      emit(state.copyWith(
        formsStatus: FormsStatus.success,
        userModel: event.userModel
      ));
    }
    else{
      emit(state.copyWith(
        formsStatus: FormsStatus.error,
        statusMessage: networkResponse.errorCode));
    }
  }
  _deleteUser(DeleteUserEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=
    await userProfileRepository.deleteUser(event.userModel.userId);
    if(networkResponse.errorCode.isEmpty){
      emit(state.copyWith(
          formsStatus: FormsStatus.success,
          userModel:networkResponse.data as UserModel
      ));
    }
    else{
      emit(state.copyWith(
        formsStatus: FormsStatus.error,
          statusMessage: networkResponse.errorCode));
    }
  }
  _getByDocIDUser(GetUserByDocIdEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=
    await userProfileRepository.getUserByDocID(event.docId);
    if(networkResponse.errorCode.isEmpty){
      emit(state.copyWith(
          formsStatus: FormsStatus.success,
          userModel:UserModel.initial()
      ));
    }
    else{
      emit(state.copyWith(
        formsStatus: FormsStatus.error,
          statusMessage: networkResponse.errorCode));
    }
  }
  _getByUIDUser(GetUserByUIDEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=
    await userProfileRepository.getUserByUID(event.uid);
    if(networkResponse.errorCode.isEmpty){
      emit(state.copyWith(
          formsStatus: FormsStatus.success,
          userModel:networkResponse.data as UserModel
      ));

      String? token = await FirebaseMessaging.instance.getToken();
      if(token!=null){
        UserModel userModel=state.userModel;
        userModel=userModel.copyWith(
          fcm: token
        );
        add(UpdateUserEvent(userModel:userModel));
      }
    }
    else{
      emit(state.copyWith(
          formsStatus: FormsStatus.error,
          statusMessage: networkResponse.errorCode));
    }
  }
  _updateUser(UpdateUserEvent event,emit)async{
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse networkResponse=
    await userProfileRepository.updateUser(event.userModel);
    if(networkResponse.errorCode.isEmpty){
      emit(state.copyWith(
          formsStatus: FormsStatus.success,
          userModel:event.userModel
      ));
    }
    else{
      emit(state.copyWith(
        formsStatus: FormsStatus.error,
          statusMessage: networkResponse.errorCode));
    }
  }
}
