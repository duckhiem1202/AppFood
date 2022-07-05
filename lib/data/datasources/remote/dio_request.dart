import 'package:dio/dio.dart';
import 'package:myappappsa/commons/constants/api_constant.dart';
import 'package:myappappsa/commons/constants/variable_constant.dart';
import 'package:myappappsa/data/datasources/local/cache/app_cache.dart';

class DioRequest {
  Dio? _dio;
  static BaseOptions _options = new BaseOptions(
    baseUrl: ApiConstant.BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static final DioRequest instance = DioRequest._internal();

  DioRequest._internal() {
    if (_dio == null){
      _dio = Dio(_options);
      _dio!.interceptors.add(LogInterceptor(requestBody: true));
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          var token =  AppCache.getString(VariableConstant.TOKEN);
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer " + token;
          }
          return handler.next(options);
        },
        onResponse: (e, handler) {
          return handler.next(e);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ));
    }
  }

  Dio get dio => _dio!;
}