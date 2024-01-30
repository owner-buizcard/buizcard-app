import 'package:bizcard_app/network/api_client.dart';

class MainService {

  Future<Map> fetchMainData({bool loader = true})async{
    ApiClient client = ApiClient('/main', loader: loader);
    return await client.gets();
  }

}