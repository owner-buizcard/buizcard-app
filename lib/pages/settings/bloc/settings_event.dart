part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class IntegrateEvent extends SettingsEvent{
  final String url;

  const IntegrateEvent({required this.url});
}

class DeleteAccountEvent extends SettingsEvent{}

class GetMyAnalyticsEvent extends SettingsEvent{}

class FeedbackEvent extends SettingsEvent{
  final String text;
  final String type;

  const FeedbackEvent({required this.text, required this.type});
}