import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/common/route/route_generator.dart';
import 'package:fake_store/common/route/routes.dart';

class App extends StatelessWidget {
  final Env env;
  App({Key key, @required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Env>(
            create: (context) => env,
            lazy: true,
          ),
          RepositoryProvider<ApiProvider>(
            create: (context) => ApiProvider(),
            lazy: true,
          )
        ],
        child: MaterialApp(
          title: 'Fake Store',
          onGenerateRoute: RouterGenerator.generateRouter,
          initialRoute: Routes.productList,
        ));
  }
}
