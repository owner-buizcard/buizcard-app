import 'package:bizcard_app/network/api_client.dart';

class AuthService {

  Future<String> login({required String email, required String password})async{
    ApiClient client = ApiClient('/auth/login');
    return await client.post({'email': email, 'password': password});
  }

  Future<String> signup({required datamap})async{
    ApiClient client = ApiClient('/auth/signup');
    var data = await client.post(datamap);
    return data;
  }

}