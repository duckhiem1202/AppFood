import 'dart:async';

import 'package:dio/dio.dart';
import 'package:myappappsa/commons/constants/api_constant.dart';
import 'package:myappappsa/data/datasources/remote/app_response.dart';
import 'package:myappappsa/data/datasources/remote/cart_response.dart';
import 'package:myappappsa/data/datasources/remote/dio_request.dart';

class CartRepository {
  late Dio _dio;

  CartRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<CartResponse> fetchCart() {
    Completer<CartResponse> completer = Completer();
    _dio.get(ApiConstant.CART_API).then((response){
      AppResponse<CartResponse> dataResponse = AppResponse.fromJson(response.data, CartResponse.parseJson);
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

  Future<CartResponse> addCart(String idProduct) {
    Completer<CartResponse> completer = Completer();
    _dio.post(ApiConstant.ADD_CART,data: {
      "id_product": idProduct
    })
        .then((response){
      AppResponse<CartResponse> dataResponse = AppResponse.fromJson(response.data, CartResponse.parseJson);
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