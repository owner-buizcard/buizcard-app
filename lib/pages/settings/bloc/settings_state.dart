part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

class Success extends SettingsState {}

class Failure extends SettingsState {}

class AccountDeleted extends SettingsState {}

class SupportSent extends SettingsState {}

class Loading extends SettingsState {}

class MyAnalyticsFetched extends SettingsState {
  final AppAnalytics analytics;
  const MyAnalyticsFetched({required this.analytics});
}