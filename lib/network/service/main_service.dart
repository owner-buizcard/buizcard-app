import 'package:bizcard_app/network/api_client.dart';

class MainService {

  Future<Map> fetchMainData()async{
    ApiClient client = ApiClient('/main');
    return await client.gets();
  }

}