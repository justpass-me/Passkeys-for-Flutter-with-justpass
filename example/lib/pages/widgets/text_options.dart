import 'package:flutter/material.dart';

class ApplyTextOptions extends StatelessWidget {
  const ApplyTextOptions({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const textDirection = TextDirection.ltr;
    const textScaleFactor = 1.0;

    Widget widget = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: textScaleFactor,
      ),
      child: child,
    );
    return textDirection == null
        ? widget
        : Directionality(
      textDirection: textDirection,
      child: widget,
    );
  }
}
