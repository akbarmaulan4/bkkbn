import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class PullRefreshWidget extends StatefulWidget {
  Widget child;
  Function onRefresh;
  PullRefreshWidget({
    this.child,
    this.onRefresh
  });
  @override
  _PullRefreshWidgetState createState() => _PullRefreshWidgetState();
}

class _PullRefreshWidgetState extends State<PullRefreshWidget> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  // ScrollController _scrollController;
  // static int refreshNum = 10; // number that changes when refreshed
  // Stream<int> counterStream =
  // Stream<int>.periodic(Duration(seconds: 3), (x) => refreshNum);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    // Timer(const Duration(seconds: 3), () {
    completer.complete();
    // });
    return completer.future.then<void>((_) {
      return widget.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: true,
        color: Utils.colorFromHex(ColorCode.lightBlueDark),
        backgroundColor: Utils.colorFromHex(ColorCode.blueSecondary),
        child: widget.child,
      ),
    );
  }
}
