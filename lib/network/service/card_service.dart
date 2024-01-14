import 'package:bizcard_app/network/api_client.dart';

class CardService {

  Future<String> saveCard({required String cardId, required Map data})async{
    ApiClient client = ApiClient('/card?cardId=$cardId');
    return await client.put(data);
  }

}