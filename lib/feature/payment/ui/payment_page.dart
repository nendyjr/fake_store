import 'package:fake_store/common/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  String totalPay;
  PaymentPage(this.totalPay);
  @override
  State<PaymentPage> createState() => _PaymentState();
}

class _PaymentState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Total : \$ ${widget.totalPay} '),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Credit Card Number',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cardholder Name',
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expiry Date',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Security Code',
                ),
                maxLength: 4,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.thankYou,
                        arguments: widget.totalPay);
                  },
                  child: Text('PAY'))
            ],
          ),
        ),
      ),
    );
  }
}
