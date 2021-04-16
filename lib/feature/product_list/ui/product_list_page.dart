import 'package:fake_store/common/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/feature/product_list/bloc/index.dart';
import 'package:fake_store/feature/product_list/resources/product_list_repository.dart';
import 'package:fake_store/common/constant/env.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductListPage> {
  ProductListBloc _productListBloc;
  List<String> categories = [];
  String categorySelected = 'All';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListBloc = ProductListBloc(
        productListRepository: ProductListRepository(
            env: RepositoryProvider.of<Env>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context)));
    _productListBloc.add(FetchCategory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(Radius.circular(8.0))),
        // color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropDownCustomWidget(
              categories: categories,
              onValueSelected: (value) {
                print('value selected ${value}');
                _productListBloc.add(Fetch(value));
                setState(() {
                  categorySelected = value;
                });
              }),
        ),
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        bloc: _productListBloc,
        builder: (context, state) {
          print('builder $state');
          if (state is ProductListEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductListFetch) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductListCategoriesLoaded) {
            _productListBloc.add(Fetch(categorySelected));
            // setState(() {
            this.categories = state.categories;
            // });
          } else if (state is ProductListLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                scrollDirection: Axis.vertical,
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: InkResponse(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.productDetail,
                              arguments: {'index': state.products[index].id});
                        },
                        enableFeedback: true,
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.network(
                                    '${state.products[index].image}'),
                                height: 135.0,
                              ),
                              Expanded(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '${state.products[index].title}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  '\$${state.products[index].price}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            );
          }

          return const Center(
            child: Text('Haloo'),
          );
        },
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class DropDownCustomWidget extends StatefulWidget {
  final Function(String) onValueSelected;
  List<String> categories;

  DropDownCustomWidget({this.onValueSelected, this.categories});
  @override
  _DropDownCustomWidgetState createState() => _DropDownCustomWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownCustomWidgetState extends State<DropDownCustomWidget> {
  String dropdownValue = 'All';
  List<String> candidate = [
    'All',
    'electronics',
    'jewelery',
    'men clothing',
    'women clothing'
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.white,
      value: dropdownValue,
      icon: const Icon(Icons.filter_alt),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        widget.onValueSelected(newValue);
      },
      items: this.candidate.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
