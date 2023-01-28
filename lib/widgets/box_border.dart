import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/constant_style.dart';

class BoxBorderDefault extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  BoxBorderDefault({
    @required this.child,
    this.backgroundColor
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Utils.colorFromHex('#EBEEF7')),
        color: backgroundColor != null ? backgroundColor : Colors.white
      ),
      child: child,
    );
  }
}
