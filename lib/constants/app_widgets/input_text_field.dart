import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextField extends ConsumerWidget {
  final TextEditingController inputController;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;

  const InputTextField({
    super.key,
    required this.inputController,
    this.onTap,
    this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      child: TextField(
        controller: inputController,
        // readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
        ),
      
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
