import 'package:flutter/material.dart';

import '../utils/constants_util.dart';

class LabeledDropdownFormField extends StatelessWidget {
  final String title;
  final double padding;
  final String? error;
  final String? initialValue;
  final List<String?>? items;
  final String? Function(String?)? validator;
  final Object? Function(Object?)? onChanged;

  const LabeledDropdownFormField({
    super.key,
    required this.title,
    this.padding = 20,
    this.error,
    this.initialValue,
    this.items,
    this.validator,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: kInputTextStyle,
          ),
          DropdownButtonFormField(
            isExpanded: true,
            value: initialValue!,
            //hint: ,
            onChanged: onChanged,
            items: items!
                .map((f) => DropdownMenuItem(
                      value: f,
                      child: Text(
                        f!,
                        style: kInputTextStyle,
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
