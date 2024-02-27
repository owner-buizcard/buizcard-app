
import '../api_client.dart';

class UserService {

  Future<Map> update(data, {bool loader = true})async{
    ApiClient client = ApiClient('/me', loader: loader);
    return await client.put(data);
  }
}