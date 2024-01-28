part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ConnectZohoCRMEvent extends SettingsEvent{
  final String url;

  const ConnectZohoCRMEvent({required this.url});
}

class ConnectHubspotEvent extends SettingsEvent{
  final String url;

  const ConnectHubspotEvent({required this.url});
}