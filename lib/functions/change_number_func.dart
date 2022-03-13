 import 'package:chatapp/core/components/valid_numbers.dart';
import 'package:chatapp/providers/numbers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
DropdownButton<String> numbersChanger(BuildContext context) {
    return DropdownButton(
        value: context.watch<PhoneNumbersProvider>().dropValue,
        items: [
          DropdownMenuItem(value: numbers[0], child: Text(numbers[0])),
          DropdownMenuItem(value: numbers[1], child: Text(numbers[1])),
          DropdownMenuItem(value: numbers[2], child: Text(numbers[2]))
        ],
        onChanged: (v) {
          context.read<PhoneNumbersProvider>().changePrefix(v.toString());
        });
  }