import 'dart:async';


import '../../../common/bases/base_event.dart';
import '../../../data/datasources/models/cart_model.dart';
import '../../../data/datasources/models/product_model.dart';
import '../../../data/repositories/cart_repository.dart';
import '../../../presentation/features/cart/cart_event.dart';

import '../../../common/bases/base_bloc.dart';

class CartBloc extends BaseBloc {
  StreamController<CartModel> cart = StreamController();
  StreamController<String> message = StreamController();
  late CartRepository _cartRepository;

  void setRepository({required CartRepository cartRepository}) {
    _cartRepository = cartRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is FetchCartEvent) {
      fetchCart();
    } else if (event is UpdateCartEvent) {
      updateCart(event);
    } else if (event is CartConform) {
      conform(event);
    }
  }

  void fetchCart() {
    loadingSink.add(true);
    _cartRepository.fetchCart().then((cartData) {
      cart.sink.add(CartModel(
          cartData.id,
          cartData.products?.map((data) {
            return ProductModel(data.id, data.name, data.address, data.price,
                data.img, data.quantity, data.gallery);
          }).toList(),
          cartData.price));
    }).catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  void updateCart(UpdateCartEvent event) {
    loadingSink.add(true);
    _cartRepository.updateCart(event.idCart, event.quantity, event.idProduct).then((cartData) {
      cart.sink.add(CartModel(
          cartData.id,
          cartData.products?.map((data) {
            return ProductModel(data.id, data.name, data.address, data.price,
                data.img, data.quantity, data.gallery);
          }).toList(),
          cartData.price));
    }).catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  void conform(CartConform event) {
    loadingSink.add(true);
    _cartRepository.confirm(event.idCart).then((cartData) {
      cart.sink.add(CartModel("", [], -1));
    }).catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  @override
  void dispose() {
    super.dispose();
    cart.close();
    message.close();
  }
}
