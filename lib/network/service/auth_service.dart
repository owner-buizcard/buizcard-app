import 'package:bizcard_app/network/api_client.dart';

class AuthService {

  Future<String> login({required String email, required String password})async{
    ApiClient client = ApiClient('/auth/login');
    var data = await client.post({'email': email, 'password': password});
    return data;
  }

}