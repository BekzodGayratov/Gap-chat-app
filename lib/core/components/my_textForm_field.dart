import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration inputDecoration;
  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.inputDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration,
    );
  }
}