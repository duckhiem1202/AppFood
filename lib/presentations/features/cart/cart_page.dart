import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myappappsa/commons/bases/base_widget.dart';
import 'package:myappappsa/commons/constants/api_constant.dart';
import 'package:myappappsa/data/datasources/models/cart_model.dart';
import 'package:myappappsa/data/datasources/models/product_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: const [],
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      child: const CartContainer(),
    );
  }
}

class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  CartModel? _cartModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var dataReceive = ModalRoute.of(context)?.settings.arguments as Map;
    _cartModel = dataReceive["cart"];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _cartModel?.products?.length,
                itemBuilder: (lstContext, index) => _buildItem(_cartModel?.products?[index])),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                  "Tổng tiền : " +
                      NumberFormat("#,###", "en_US")
                          .format(_cartModel?.price) +
                      " đ",
                  style: const TextStyle(fontSize: 25, color: Colors.white))),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const  EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.deepOrange)),
                child: const  Text("Confirm",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              )),
        ],
      ),
    );
  }

  Widget _buildItem(ProductModel? product) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const  EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      ApiConstant.BASE_URL + (product?.img).toString(),
                      width: 150,
                      height: 120,
                      fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text((product?.name).toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(product?.price) +
                              " đ",
                          style: const TextStyle(fontSize: 12)),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const  Text("-"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text((product?.quantity).toString(),
                                style: const  TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const  Text("+"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}