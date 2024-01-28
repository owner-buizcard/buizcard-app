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