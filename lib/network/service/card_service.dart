import 'package:bizcard_app/network/api_client.dart';

class CardService {

  Future<dynamic> saveCard({required String cardId, required Map data})async{
    ApiClient client = ApiClient('/card?cardId=$cardId');
    return await client.put(data);
  }

  Future<dynamic> saveCardSettings({required String cardId, required Map data})async{
    ApiClient client = ApiClient('/card?cardId=$cardId', loader: false);
    return await client.put(data);
  }

  Future<dynamic> getCardAnalytics({required String cardId})async{
    ApiClient client = ApiClient('/card-analytics?cardId=$cardId');
    return await client.gets();
  }

  Future<dynamic> getCard({required String cardId})async{
    ApiClient client = ApiClient('/card?cardId=$cardId');
    return await client.gets();
  }

  Future<dynamic> deleteCard(String cardId)async{
    ApiClient client = ApiClient('/card?cardId=$cardId');
    return await client.delete();
  }

  Future<dynamic> createCard({required String cardName, required bool isPublic})async{
    ApiClient client = ApiClient('/card');
    return await client.post({'cardName': cardName, 'isPublic': isPublic});
  }

}