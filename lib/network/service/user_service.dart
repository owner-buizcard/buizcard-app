
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

  Future checkLinkAvailable(value)async{
    ApiClient client = ApiClient('/personalizedLink/check', loader: false);
    return await client.post({'domain': value});
  }

  Future updatePersonalizedLink(value)async{
    ApiClient client = ApiClient('/personalizedLink?value=$value', loader: false);
    return await client.put();
  }

  Future updateBranding(value)async{
    ApiClient client = ApiClient('/branding?value=$value', loader: false);
    return await client.put();
  }

  Future sendVerificationMail()async{
    ApiClient client = ApiClient('/auth/verify-email', loader: false);
    return await client.put();
  }

  Future verifyMail()async{
    ApiClient client = ApiClient('/verify-email', loader: false);
    return await client.put();
  }
}