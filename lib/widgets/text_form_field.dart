import 'package:flutter/material.dart';

import '../utils/constants_util.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final Widget? suffixIcon;
  final String? error;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.initialValue,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.suffixIcon,
    this.error,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xffbcbcbc),
          fontFamily: 'NunitoSans',
        ),
        errorText: widget.error,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    size: 15,
                  ),
                ),
              )
            : widget.suffixIcon,
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xff575757),
        fontFamily: 'NunitoSans',
      ),
      cursorColor: kColorPrimary,
      cursorWidth: 1,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
