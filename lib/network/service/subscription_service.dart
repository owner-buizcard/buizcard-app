import 'package:bizcard_app/network/api_client.dart';

class SubscriptionService {

  Future<dynamic> createOrder({required String amount})async{
    ApiClient client = ApiClient('/order');
    return await client.post({ 'amount': amount });
  }

  Future<dynamic> subscribe({required Map data})async{
    ApiClient client = ApiClient('/subscribe');
    return await client.post(data);
  }
}