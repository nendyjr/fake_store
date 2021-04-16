import 'package:fake_store/feature/cart/model/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fake_store/feature/invoice/ui/invoice_page.dart';
import 'package:fake_store/feature/product_list/ui/product_list_page.dart';
import 'package:fake_store/feature/product_detail/ui/product_detail_page.dart';
import 'package:fake_store/feature/cart/ui/cart_page.dart';
import 'package:fake_store/feature/checkout/ui/checkout_page.dart';
import 'package:fake_store/feature/payment/ui/payment_page.dart';
import 'package:fake_store/feature/thank_you/ui/thank_you_page.dart';
import 'routes.dart';

class RouterGenerator {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.invoice:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Invoice'),
                  ),
                  body: InvoicePage(),
                ));
        break;
      case Routes.productList:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Fake Store'),
                  ),
                  body: ProductListPage(),
                ));
        break;

      case Routes.productDetail:
        int index = -1;
        if (args is Map) {
          index = args['index'] as int;
        }
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Product Detail'),
                  ),
                  body: ProductDetailPage(productId: index),
                ));
        break;

      case Routes.cart:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Cart'),
                  ),
                  body: CartPage(),
                ));
        break;

      case Routes.checkout:
        List<Cart> carts = args as List<Cart>;
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Checkout'),
                  ),
                  body: CheckoutPage(carts),
                ));
        break;

      case Routes.payment:
        String totalPay = args as String;
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Payment'),
                  ),
                  body: PaymentPage(totalPay),
                ));
        break;

      case Routes.thankYou:
        String totalPay = args as String;
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('Thank You'),
                  ),
                  body: ThankYouPage(totalPay),
                ));
        break;
    }
  }
}
