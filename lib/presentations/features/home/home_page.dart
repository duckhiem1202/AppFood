import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myappappsa/commons/constants/api_constant.dart';
import 'package:myappappsa/commons/widgets/loading_widget.dart';
import 'package:myappappsa/data/datasources/models/cart_model.dart';
import 'package:myappappsa/data/datasources/models/product_model.dart';
import 'package:myappappsa/data/repositories/cart_repository.dart';
import 'package:myappappsa/data/repositories/product_repository.dart';
import 'package:myappappsa/presentations/features/home/home_bloc.dart';
import 'package:provider/provider.dart';
import '../../../commons/bases/base_widget.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CartModel? _cart;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => ProductRepository()),
        Provider(create: (context) => CartRepository()),
        ProxyProvider2<ProductRepository, CartRepository,HomeBloc>(
            create: (context) => HomeBloc(),
            update: (context, productRepo, cartRepo, bloc) {
              bloc!.setRepository(productRepository: productRepo, cartRepository: cartRepo);
              return bloc;
            })
      ],
      appBar: AppBar(
        title: const Text("Product"),
        actions: [
          Consumer<HomeBloc>(
              builder: (context, bloc, child) {
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/cart",arguments: {"cart": _cart});
                  },
                  child: StreamBuilder<CartModel>(
                    initialData: null,
                    stream: bloc.cart.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError || snapshot.data == null) {
                        return Container();
                      }
                      _cart = snapshot.data;
                      String? count = snapshot.data?.products?.length.toString();
                      if (count == null || count.isEmpty || count == "0") {
                        return Container(
                          margin: const EdgeInsets.only(right: 10, top: 10),
                          child: Badge(
                            badgeContent: Text(""),
                            child:const Icon(Icons.shopping_cart_outlined),
                          ),
                        );
                      } else {
                        return Container(
                          margin:const EdgeInsets.only(right: 10, top: 10),
                          child: Badge(
                            badgeContent: Text(count),
                            child:const Icon(Icons.shopping_cart_outlined),
                          ),
                        );
                      }
                    },
                  ),
                );
              }
          ),
        ],
      ),
      child: const HomeContainer(),
    );
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late HomeBloc homeBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = context.read();
    homeBloc.fetchProducts();
    homeBloc.fetchCart();
  }
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      bloc: homeBloc,
      child: StreamBuilder<List<ProductModel>>(
          initialData: [],
          stream: homeBloc.products.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Data is error");
            } else if (snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _buildItemFood(snapshot.data?[index]);
                  });
            } else {
              return Container();
            }
          }
      ),
    );
  }

  Widget _buildItemFood(ProductModel? product) {
    print(product?.img.toString());
    if (product == null) return Container();
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(ApiConstant.BASE_URL + product.img,
                    width: 150, height: 120, fit: BoxFit.fill),
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
                        child: Text(product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(product.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(200, 240, 102, 61);
                              } else {
                                return Color.fromARGB(230, 240, 102, 61);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        child:
                        Text("Add To Cart", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}