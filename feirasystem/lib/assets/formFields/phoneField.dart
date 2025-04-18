import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        PhoneInputFormatter(
          defaultCountryCode: 'BR',
          allowEndlessPhone: false,
        ),
      ],
      decoration: const InputDecoration(
        labelText: 'Celular',
      ),
    );
  }
}
