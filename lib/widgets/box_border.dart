import 'package:flutter/material.dart';
import 'package:kua/util/constant_style.dart';

class BoxBorderDefault extends StatelessWidget {
  final Widget child;
  BoxBorderDefault({
    @required this.child
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: ConstantStyle.box_border_field,
      child: child,
    );
  }
}
