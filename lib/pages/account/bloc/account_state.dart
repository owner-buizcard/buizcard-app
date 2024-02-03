part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();
  
  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

class Loading extends AccountState {}

class UserUpdated extends AccountState {}

class Failure extends AccountState {}
