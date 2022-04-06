import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.backgroundcolor,
    required this.buttontext,
    required this.buttontextcolor,
    required this.onTapp,
    Key? key,
  }) : super(key: key);
  final Color backgroundcolor;
  final Color buttontextcolor;
  final String buttontext;
  final Function() onTapp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapp,
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(
              fontSize: 25,
              color: buttontextcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
