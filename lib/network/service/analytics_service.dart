import 'package:bizcard_app/network/api_client.dart';

class AnalyticsService {

  Future<dynamic> userAnalytics({bool loader = false})async{
    ApiClient client = ApiClient('/user-analytics');
    return await client.gets();
  }

}