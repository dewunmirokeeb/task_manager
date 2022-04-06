import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    required this.icon,
    required this.backgroundcolorcolor,
    required this.align,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final Color backgroundcolorcolor;
  final Alignment align;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: align,
      color: backgroundcolorcolor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
