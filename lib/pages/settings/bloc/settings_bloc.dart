import 'package:bizcard_app/network/service/integration_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ConnectZohoCRMEvent>(_onConnectZohoCRM);
    on<ConnectHubspotEvent>(_onConnectHubspot);
  }

  final service = IntegrationService();

  _onConnectZohoCRM(ConnectZohoCRMEvent event, Emitter emit)async{
    try{
      Uri uri = Uri.parse(event.url);
      String? code = uri.queryParameters['code'];
      String? server = uri.queryParameters['accounts-server'];
      print('Code: $code'); 
      print('Server: $server'); 
      await service.connectZohoCRM(code: code!, server: server!);
      emit(Success());
    }catch(error){
      emit(Failure());
    }
  }

  _onConnectHubspot(ConnectHubspotEvent event, Emitter emit)async{
    try{
      Uri uri = Uri.parse(event.url);
      String? code = uri.queryParameters['code'];
      print('Code: $code'); 
      await service.connectHubspot(code: code!);
      emit(Success());
    }catch(error){
      emit(Failure());
    }
  }
}
