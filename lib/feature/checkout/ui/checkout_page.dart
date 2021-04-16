import 'package:fake_store/common/route/routes.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  List<Cart> carts;
  CheckoutPage(this.carts);

  @override
  State<CheckoutPage> createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutPage> {
  List<Cart> _carts;
  bool _agreed = false;
  String _pay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carts = widget.carts;
    _agreed = false;
    _pay = _grandTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                              border: Border.all(color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                height: 100.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Image.network(_carts[index]
                                            .realProducts[i]
                                            .image)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200.0,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${_carts[index].realProducts[i].title}',
                                              softWrap: true,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                                '\$${_carts[index].realProducts[i].price}'),
                                            Text(
                                                'Qty: ${_carts[index].products[i].quantity}'),
                                          ],
                                        ),
                                      ),
                                    ),
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
            Text('Grand Total : \$ $_pay'),
            Row(
              children: [
                Checkbox(
                  value: this._agreed,
                  onChanged: (value) {
                    setState(() {
                      this._agreed = value;
                    });
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  child: Text(
                      "I have read and agreed to Fake Store's Returns & Refunds policy."),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                if (!this._agreed) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Please agree to our Returns and Refunds policy")));
                } else {
                  Navigator.pushNamed(context, Routes.payment, arguments: _pay);
                }
              },
              child: Text('Confirm & Pay',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
            )
          ],
        )
      ],
    )

        // Column(
        //   children: [
        //     Text('Checkout '),
        //     TextButton(
        //         onPressed: () {
        //           Navigator.pushNamed(context, Routes.thankYou);
        //         },
        //         child: Text('go thank you'))
        //   ],
        // ),
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
