import 'package:flutter/material.dart';
import 'package:task_manager/utils/color_consrants.dart';

class AllTaskScreenIconWidgets extends StatelessWidget {
  const AllTaskScreenIconWidgets({
    required this.onPressed,
    this.iconcolor = AppColors.secondarycolor,
    required this.icon,
    this.iconsize = 20,
    Key? key,
  }) : super(key: key);
  final Function() onPressed;
  final Color? iconcolor;
  final IconData icon;
  final double? iconsize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconcolor,
        size: iconsize,
      ),
    );
  }
}
