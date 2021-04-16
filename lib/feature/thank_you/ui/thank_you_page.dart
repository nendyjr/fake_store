import 'package:fake_store/common/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThankYouPage extends StatefulWidget {
  String totalPay;
  ThankYouPage(this.totalPay);
  @override
  State<ThankYouPage> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              size: 50.0,
            ),
            Text(
              'ORDER RECEIVED\n(PAYMENT TAKEN)',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black12,
              height: 100.0,
              width: MediaQuery.of(context).size.width - 20.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ID:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('#as53234'),
                    Text(
                      'Payment Method:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Credit Card')
                  ],
                ),
              ),
            ),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black))),
          ],
        ),
      ),
    );
  }
}
