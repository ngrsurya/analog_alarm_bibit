import 'package:bibit_test/presentation/templates/Responsive/size_config.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget potraitLayout;
  final Widget landscapeLayout;

  const ResponsiveWidget({
    Key key,
    @required this.potraitLayout,
    this.landscapeLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.isPotrait && SizeConfig.isMobilePotrait) {
      return potraitLayout;
    } else {
      return landscapeLayout;
    }
  }
}
