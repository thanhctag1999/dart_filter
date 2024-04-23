import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback doSomething;
  final Widget children;
  final List<Color> myColors;

  const CustomButtom(
      {super.key,
      required this.doSomething,
      required this.children,
      required this.myColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(4, 2),
            )
          ]),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(onTap: doSomething, child: children),
        ),
      ),
    );
  }
}
