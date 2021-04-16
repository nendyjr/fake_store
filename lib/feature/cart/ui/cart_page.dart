import 'package:fake_store/common/route/routes.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'package:fake_store/feature/cart/resources/cart_repository.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/feature/cart/bloc/index.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/common/constant/env.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartState();
}

class _CartState extends State<CartPage> {
  CartBloc _cartBloc;
  List<Cart> _carts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc = CartBloc(
        cartRepository: CartRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            env: RepositoryProvider.of<Env>(context)));
    _cartBloc.add(Fetch(3));
    _carts = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
          bloc: _cartBloc,
          builder: (context, state) {
            if (state is CartFetch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              if (_carts == null) {
                _carts = state.carts;
              }
              return Column(
                children: [
                  Container(
                    height: 500.0,
                    child: ListView.builder(
                      itemCount: _carts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Text(
                                  'Cart ID :${_carts[index].id}',
                                  textAlign: TextAlign.left,
                                ),
                                for (var i = 0;
                                    i < _carts[index].realProducts.length;
                                    i++)
                                  Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                          height: 100.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              AspectRatio(
                                                  aspectRatio: 1 / 1,
                                                  child: Image.network(
                                                      _carts[index]
                                                          .realProducts[i]
                                                          .image)),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      200.0,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        '${_carts[index].realProducts[i].title}',
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                          '\$${_carts[index].realProducts[i].price}'),
                                                      Text(
                                                          'Qty: ${_carts[index].products[i].quantity}'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.delete_forever),
                                                  onPressed: () {
                                                    final productId =
                                                        _carts[index]
                                                            .realProducts[i]
                                                            .id;
                                                    final cartId =
                                                        _carts[index].id;
                                                    List<Cart> newCart = [];
                                                    for (var cart in _carts) {
                                                      if (cart.id == cartId) {
                                                        List<Product>
                                                            newRealProd = [];
                                                        List<ProductCart>
                                                            newProd = [];
                                                        for (var i = 0;
                                                            i <
                                                                cart.realProducts
                                                                    .length;
                                                            i++) {
                                                          if (cart
                                                                  .realProducts[
                                                                      i]
                                                                  .id !=
                                                              productId) {
                                                            newRealProd.add(cart
                                                                .realProducts[i]);
                                                            newProd.add(cart
                                                                .products[i]);
                                                          }
                                                        }
                                                        cart.realProducts =
                                                            newRealProd;
                                                        cart.products = newProd;
                                                        if (newRealProd.length >
                                                            0) {
                                                          newCart.add(cart);
                                                        }
                                                      } else {
                                                        newCart.add(cart);
                                                      }
                                                    }
                                                    setState(() {
                                                      _carts = newCart;
                                                    });
                                                    print(
                                                        'Product ${productId}, cart ${cartId}');
                                                  })
                                              // Text('${_carts[index].realProducts.quantity}'),
                                            ],
                                          )),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Text('Grand Total : \$ ${_grandTotal()}'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.checkout,
                              arguments: _carts);
                        },
                        child: Text('Checkout',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                      )
                    ],
                  )
                ],
              );
            }

            return Center(
              child: Text('Cart Page'),
            );
          }),
    );
  }

  String _grandTotal() {
    num total = 0;
    if (_carts != null) {
      for (var cart in _carts) {
        for (var i = 0; i < cart.products.length; i++) {
          final price = cart.realProducts[i].price;
          final qty = cart.products[i].quantity;
          total = total + (price * qty);
        }
      }
    }
    return total.toStringAsFixed(2);
  }
}
