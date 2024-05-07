import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/bottom/bottom_event.dart';
import 'package:my_bank_project/blocs/bottom/bottom_state.dart';
import 'package:my_bank_project/data/repositories/auth_repository.dart';



class BottomBloc extends Bloc<BottomEvent, BottomState> {
  BottomBloc({required this.authRepository})
      : super(BottomState());

  final AuthRepository authRepository;
}
