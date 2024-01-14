part of 'card_bloc.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

class Loading extends CardState {}

class Success extends CardState {}

class Error extends CardState {}