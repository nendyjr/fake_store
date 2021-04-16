import 'package:fake_store/common/route/routes.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fake_store/feature/product_detail/bloc/index.dart';
import 'package:fake_store/feature/product_detail/resources/product_detail_repository.dart';
import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget {
  int productId;

  ProductDetailPage({this.productId});
  @override
  State<ProductDetailPage> createState() => _ProductDetailState(productId);
}

class _ProductDetailState extends State<ProductDetailPage> {
  int productId;
  ProductDetailBloc _productDetailBloc;
  _ProductDetailState(this.productId);
  Product _product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productDetailBloc = ProductDetailBloc(
        productDetailRepository: ProductDetailRepository(
            env: RepositoryProvider.of<Env>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context)));
    _productDetailBloc.add(Fetch(productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProductDetailBloc, ProductDetailState>(
        bloc: _productDetailBloc,
        listener: (context, state) {
          if (state is ProductDetailAddToCartSuccess) {
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: Text('Add to Cart Success'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('See In Cart'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pushNamed(context, Routes.cart);
                          },
                        ),
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ],
                    ));
          }
        },
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          bloc: _productDetailBloc,
          builder: (context, state) {
            if (state is ProductDetailLoaded) {
              _product = state.product;
            } else if (state is ProductDetailAddToCart ||
                state is ProductDetailFetch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: Column(
                children: [
                  Container(
                    child: _product == null
                        ? Container()
                        : Image.network('${_product.image}'),
                    height: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    '${_product?.title ?? ''}',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${_product?.description ?? ''}',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('\$${_product?.price ?? '0'}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                  TextButton(
                    onPressed: () {
                      _productDetailBloc.add(AddToCart(productId));
                    },
                    child: Text('Add To Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.cart);
                    },
                    child: Text('Go To Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
