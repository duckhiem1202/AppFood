import 'dart:async';
import 'package:dio/dio.dart';
import 'package:myappappsa/common/constants/api_constant.dart';
import 'package:myappappsa/data/datasources/remote/app_response.dart';
import 'package:myappappsa/data/datasources/remote/dio_request.dart';
import 'package:myappappsa/data/datasources/remote/order_response.dart';


class OrderRepository {
  late Dio _dio;

  OrderRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<List<OrderResponse>> fetchOrderHistory() {
    Completer<List<OrderResponse>> completer = Completer();
    _dio.post(ApiConstant.ORDER_HISTORY_API).then((response){
      AppResponse<List<OrderResponse>> dataResponse = AppResponse.fromJson(response.data, OrderResponse.parseJson);
      completer.complete(dataResponse.data);
    }).catchError((error) {
      if (error is DioError) {
        completer.completeError((error).response?.data["message"]);
      } else {
        completer.completeError(error);
      }
    });
    return completer.future;
  }
}