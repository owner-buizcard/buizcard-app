import 'package:bizcard_app/models/user.dart';
import 'package:bizcard_app/network/service/user_service.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<UpdateUserEvent>(_onUserUpdate);
  }

  _onUserUpdate(UpdateUserEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var data = await UserService().update(event.data);
      Global.user = User.fromJson(data);
      emit(UserUpdated());
    }catch(_){
      emit(Failure());
    }

  }
}
