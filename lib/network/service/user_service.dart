
import '../api_client.dart';

class UserService {

  Future<Map> update(data, {bool loader = true})async{
    ApiClient client = ApiClient('/me', loader: loader);
    return await client.put(data);
  }

  Future updateFollowUp(value)async{
    ApiClient client = ApiClient('/followUp?value=$value', loader: false);
    return await client.put();
  }
}