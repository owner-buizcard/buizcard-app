import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/subscription/bloc/subscription_bloc.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlansViewModel extends BaseViewModel {
  
  late ValueNotifier<int> selected;
  late ValueNotifier<bool> isMonthly;
  late Razorpay razorpay;
  late BuildContext context;

  PlansViewModel(BuildContext ctx){
    context = ctx;
    selected = ValueNotifier(0);
    isMonthly = ValueNotifier(true);
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  _handlePaymentSuccess(PaymentSuccessResponse e){
    context.read<SubscriptionBloc>().add(
      SubscribeEvent(
        data: {
          'razorpay_order_id': e.orderId, 
          'razorpay_payment_id': e.paymentId, 
          'razorpay_signature': e.signature,
          'plan': {
            'id': Global.plans[selected.value].id,
            'type': isMonthly.value ? "m": "y"
          }
        }
      ));
  }

  _handlePaymentError(PaymentFailureResponse e){}

  _handleExternalWallet(ExternalWalletResponse e){}

  void createOrder(bool isMonthly) {
    var price = Global.plans[selected.value].price;
    var amount = isMonthly ? price['m']['amount'] : price['y']['amount'];

    context.read<SubscriptionBloc>().add(CreateOrderEvent(amount: amount));
  }

  void startPayment(String orderId) {

    var plan = Global.plans[selected.value];
    var user = Global.user!;

    var options = {
      'key': Global.razorpayKey,
      'amount': 100,
      'name': 'Bizcard',
      'currency': 'INR',
      'description': plan.name,
      'order_id': orderId,
      'prefill': {'contact': '${user.phoneNumber}', 'email': '${user.email}'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    razorpay.clear();
  }
}