part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

class Success extends SettingsState {}

class Failure extends SettingsState {}