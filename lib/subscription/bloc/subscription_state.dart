part of 'subscription_bloc.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();
  
  @override
  List<Object> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

final class Loading extends SubscriptionState {}

final class SubscriptionSuccess extends SubscriptionState {}

final class OrderCreated extends SubscriptionState {
  final String orderId;

  const OrderCreated({required this.orderId});
}

class Error extends SubscriptionState {}