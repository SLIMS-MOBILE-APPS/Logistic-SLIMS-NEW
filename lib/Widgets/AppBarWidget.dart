import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  final double? height;
  final Widget? child;

  const HeaderBar({
    Key? key,
    this.height, // Optional height
    this.child, // Optional child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: height ?? size.height * 0.15, // Use provided height or default
      decoration: const BoxDecoration(
        // color: Color(0xFF0B66C3),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 11, 102, 195),
            Color.fromARGB(255, 11, 102, 195),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(16, size.height * 0.08, 16, 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(child: child),
          ]) // Display only child content
          ),
    );
  }
}
