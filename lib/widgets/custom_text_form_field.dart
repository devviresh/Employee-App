import 'package:flutter/material.dart';

// import '../../constants/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.label,
    required this.icon,
    this.isRequired = false,
    this.validator,
    this.controller,
  });

  final String hint;
  final String label;
  final IconData icon;
  final bool isRequired;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[300]),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              if (isRequired)
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                )
            ],
          )),
    );
  }
}
