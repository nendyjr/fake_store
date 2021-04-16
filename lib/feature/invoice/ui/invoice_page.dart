import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/feature/invoice/bloc/index.dart';
import 'package:fake_store/feature/invoice/resource/invoice_repository.dart';

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => InvoiceBloc(
              invoiceRepository: InvoiceRepository(
                  env: RepositoryProvider.of<Env>(context),
                  apiProvider: RepositoryProvider.of<ApiProvider>(context))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Amount",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Desciption"),
                ),
                TextButton(child: Text("Submit"))
              ],
            ),
          )),
    );
  }
}
