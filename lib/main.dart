import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/app/app.dart';
import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/bloc/bloc_delegate.dart';

void main() {
  Bloc.observer = BlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(App(env: EnvValue.development));
  }, (error, stackTrace) async {});
}
