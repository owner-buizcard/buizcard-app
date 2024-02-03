part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends AccountEvent {
  final Map data;

  const UpdateUserEvent({required this.data});
}