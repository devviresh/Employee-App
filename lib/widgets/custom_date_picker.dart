import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    Key? key,
    required this.hint,
    required this.label,
    required this.icon,
    this.controller,
    this.validator,
  }) : super(key: key);

  final String hint;
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        border: const OutlineInputBorder(),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[300]),
        labelText: label,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && controller != null) {
      controller!.text =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    }
  }
}
