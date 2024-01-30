import 'package:bizcard_app/network/api_client.dart';

class AuthService {

  Future<Map> login({required String email, required String password})async{
    ApiClient client = ApiClient('/auth/login');
    return await client.post({'email': email, 'password': password});
  }

  Future<String> signup({required datamap})async{
    ApiClient client = ApiClient('/auth/signup');
    return await client.post(datamap);
  }

  Future<bool?> forgotPassword({required String email})async{
    ApiClient client = ApiClient('/auth/password/forgot');
    var data = await client.post({'email': email});
    return data;
  }

  Future<bool?> resetPassword({required String password})async{
    ApiClient client = ApiClient('/auth/password/reset');
    var data = await client.put({'newPassword': password});
    return data;
  }

  Future<dynamic> deleteAccount()async{
    ApiClient client = ApiClient('/me');
    var data = await client.delete();
    return data;
  }

}