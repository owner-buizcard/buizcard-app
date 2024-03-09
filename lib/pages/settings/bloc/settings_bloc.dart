import 'package:bizcard_app/models/app_analytics.dart';
import 'package:bizcard_app/network/service/analytics_service.dart';
import 'package:bizcard_app/network/service/auth_service.dart';
import 'package:bizcard_app/network/service/integration_service.dart';
import 'package:bizcard_app/network/service/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<IntegrateEvent>(_onIntegrate);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<FeedbackEvent>(_onFeedbackEvent);
    on<GetMyAnalyticsEvent>(_onGetMyAnalyticsEvent);
    on<SendVerificationEmail>(_onSendVerificationEmail);
  }

  final service = IntegrationService();

  _onSendVerificationEmail(SendVerificationEmail event, Emitter emit)async{
    emit(Sending());
    try{
      emit(Sending());
      await UserService().sendVerificationMail();
      emit(SentSuccess());
    }catch(error){
      print(error);
      emit(Failure());
    }
  }

  _onGetMyAnalyticsEvent(GetMyAnalyticsEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var data = await AnalyticsService().userAnalytics();
      emit(MyAnalyticsFetched(analytics: AppAnalytics.fromJson(data)));
    }catch(error){
      emit(Failure());
    }
  }

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
