
import '../api_client.dart';

class UserService {

  Future<Map> update(data)async{
    ApiClient client = ApiClient('/me');
    return await client.put(data);
  }
}