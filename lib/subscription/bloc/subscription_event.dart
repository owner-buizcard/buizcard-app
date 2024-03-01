part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends SubscriptionEvent {
  final String amount;

  const CreateOrderEvent({
    required this.amount
  });
}

class SubscribeEvent extends SubscriptionEvent {
  final Map data;

  const SubscribeEvent({
    required this.data
  });
}

