import 'package:bibit_test/business%20logic/blocs/clock/bloc/clock_bloc.dart';
import 'package:bibit_test/presentation/templates/Responsive/size_config.dart';
import 'package:bibit_test/presentation/view/clock_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder:  (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(      
                primarySwatch: Colors.blue,
              ),
              home: BlocProvider<ClockBloc>(
                create: (context) => ClockBloc(),
                child: ClockPage(),
              ),
            );
          }
        );
      }
    );
  }
}