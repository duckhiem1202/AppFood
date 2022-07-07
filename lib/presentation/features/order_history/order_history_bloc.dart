import 'dart:async';

import '../../../common/bases/base_bloc.dart';
import '../../../common/bases/base_event.dart';
import '../../../data/datasources/models/order_model.dart';
import '../../../data/datasources/models/product_model.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../presentation/features/order_history/order_history_event.dart';

class OrderHistoryBloc extends BaseBloc {
  StreamController<List<OrderModel>> listOrder = StreamController();
  StreamController<String> message = StreamController();
  late OrderRepository _repository;

  void setOrderRepository({required OrderRepository orderRepository}) {
    _repository = orderRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is FetchOrderHistoryEvent) {
      fetchOrderHistory(event);
    }
  }

  void fetchOrderHistory(FetchOrderHistoryEvent event) {
    loadingSink.add(true);
    _repository.fetchOrderHistory().then((orderListsData) {
      listOrder.sink.add(orderListsData.map((order) {
        return OrderModel(
            order.id,
            order.products
                ?.map((productResponse) => ProductModel(
                productResponse.id,
                productResponse.name,
                productResponse.address,
                productResponse.price,
                productResponse.img,
                productResponse.quantity,
                productResponse.gallery))
                .toList(),
            order.price,
            order.status,
            order.date_created);
      }).toList());
    }).catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  @override
  void dispose() {
    super.dispose();
    listOrder.close();
    message.close();
  }
}
