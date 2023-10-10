import 'package:Ageu/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/size_config.dart';

class ShowLoading extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  const ShowLoading({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.black,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          // ignore: prefer_const_constructors
          Loading(),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spinKit = CircularProgressIndicator(
      color: ColorConstants.primaryColor,
      strokeWidth: 2,
    );
    return Center(
      child: SizedBox(
          height: SizeConfig.heightMultiplier * 8,
          width: SizeConfig.widthMultiplier * 100,
          child: Center(child: spinKit)),
    );
  }
}
