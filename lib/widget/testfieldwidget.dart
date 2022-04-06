import 'package:flutter/material.dart';
import 'package:task_manager/utils/color_consrants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.texttype,
    this.maxlines,
    required this.hinttext,
    this.borderradius = 20,
  }) : super(key: key);

  final TextEditingController texttype;
  final int? maxlines;
  final String hinttext;
  final double? borderradius;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxlines,
      controller: texttype,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textholder,
        hintText: hinttext,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius!),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius!),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
      ),
    );
  }
}
