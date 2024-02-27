import 'package:bizcard_app/network/service/auth_service.dart';
import 'package:bizcard_app/network/service/integration_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<IntegrateEvent>(_onIntegrate);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<FeedbackEvent>(_onFeedbackEvent);
  }

  final service = IntegrationService();

  _onFeedbackEvent(FeedbackEvent event, Emitter emit)async{
    try{
      await AuthService().feedback(text: event.text, type: event.type);
      emit(SupportSent());
    }catch(error){
      emit(Failure());
    }
  }

  _onDeleteAccount(DeleteAccountEvent event, Emitter emit)async{
    try{
      await AuthService().deleteAccount();
      emit(AccountDeleted());
    }catch(error){
      emit(Failure());
    }
  }

  _onIntegrate(IntegrateEvent event, Emitter emit)async{
    try{
      Uri uri = Uri.parse(event.url);
      if(event.url.contains('zoho')){
        String? code = uri.queryParameters['code'];
        String? server = uri.queryParameters['accounts-server'];
        await service.connectZohoCRM(code: code!, server: server!);
      }else if(event.url.contains('hubspot')){
        String? code = uri.queryParameters['code'];
        await service.connectHubspot(code: code!);
      }else if(event.url.contains('spreadsheet')){
        
      }
      emit(Success());
    }catch(error){
      emit(Failure());
    }
  }

}
