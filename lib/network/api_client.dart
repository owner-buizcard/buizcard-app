import 'package:bizcard_app/database/local_db.dart';
import 'package:dio/dio.dart';

import '../constants/urls_const.dart';
import '../utils/toast.dart';

class ApiClient {
  late Dio dio;

  final String path;
  final bool loader;
  final bool errToast;

  final Map<String, String>? additionalHeaders;

  ApiClient(this.path, {this.loader=true, this.errToast=true,this.additionalHeaders}){
    dio = Dio();
    dio.options.baseUrl = UrlsConst.apiHost;
    dio.options.contentType = 'application/json'; 
    dio.interceptors.add(ApiInterceptors(
      dio: dio, 
      additionalHeaders: additionalHeaders,
      loader: loader,
      errToast: errToast
    ));
  }

  Future<dynamic> gets([Map<String, dynamic>? query]) async {
    var result = await dio.get<Map>(path);
    return _process(result);
  }

  Future<dynamic> post([dynamic data = const {}, Map<String, dynamic>? query]) async {
    var result = await dio.post<Map>(path, data: data);
    return _process(result);
  }

  Future<dynamic> put([dynamic data = const {}, Map<String, dynamic>? query]) async {
    return _process(await dio.put<Map>(path, data: data));
  }

  Future<dynamic> delete([dynamic data = const {}, Map<String, dynamic>? query]) async {
    return _process(await dio.delete<Map>(path, data: data));
  }

  _process(Response response){
    return response.data['data'];
  }
}

class ApiInterceptors extends Interceptor {
  final Dio dio;
  final Map<String, String>? additionalHeaders;
  final bool loader;
  final bool errToast;

  ApiInterceptors({
    required this.dio,
    required this.additionalHeaders,
    required this.errToast,
    required this.loader  
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{

    if (loader) showLoader();

    // if(FirebaseAuth.instance.currentUser==null){
    //   getit.Get.offAndToNamed(Routes.splash);
    // }
    
    // var idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    var accessToken = LocalDB.getAccessToken();

    print(accessToken);

    options.headers["Authorization"] = "Bearer $accessToken";
    options.headers["Content-Type"] = "application/json";

    if (additionalHeaders != null){
      for (var element in additionalHeaders!.keys) { 
        options.headers[element] = additionalHeaders![element];
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{
    if (loader) hideLoader();

    if (err.response?.data is Map && err.response!.data.containsKey('message')) {
      if (errToast) toast(err.response?.data['message'], success: false);
    } else {
      if (errToast) toast('Something went wrong !', success: false);
    }

    if(err.response?.statusCode==401){
      return;
    }else {
      return handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    if (loader) hideLoader();

    if(response.data!=null){
      if(response.data['status']=='success'){
        var data = response.data['data'];

        if(data!=null && data is Map && data['token']!=null){
          LocalDB.saveToken(data['token']);
        }

        return handler.next(response);
      }
    }
  }

}