import 'package:bizcard_app/network/api_client.dart';

class IntegrationService {

  Future<dynamic> connectZohoCRM({required String code,required String server})async{
    ApiClient client = ApiClient('/zoho/connect', loader: false);
    return await client.post({'code': code, 'server': server});
  }

  Future<dynamic> connectHubspot({required String code})async{
    ApiClient client = ApiClient('/hubspot/connect', loader: false);
    return await client.put({'code': code});
  }

}