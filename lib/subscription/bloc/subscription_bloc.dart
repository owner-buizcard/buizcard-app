import 'package:bizcard_app/network/service/subscription_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<SubscribeEvent>(_onSubscribe);
  }

  _onCreateOrder(CreateOrderEvent event, Emitter emit)async{
    emit(Loading());

    try{
      var data = await SubscriptionService().createOrder(amount: event.amount);
      emit(OrderCreated(orderId: data['id']));
    }catch(error){
      emit(Error());
    }
  }

  _onSubscribe(SubscribeEvent event, Emitter emit)async{
    emit(Loading());

    try{  
      await SubscriptionService().subscribe(data: event.data);
      emit(SubscriptionSuccess());
    }catch(error){
      emit(Error());
    }
  }
}
