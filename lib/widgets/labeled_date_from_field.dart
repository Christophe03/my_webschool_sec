import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/constants_util.dart';

class LabeledDateFormField extends StatelessWidget {
  final String title;
  final double padding;
  final String? error;
  final int? initialValue;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  const LabeledDateFormField({
    super.key,
    required this.title,
    this.padding = 20,
    this.error,
    this.initialValue,
    this.validator,
    this.onTap,
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
          InkWell(
              onTap: onTap,
              child: Text(
                initialValue != 0
                    ? DateFormat('dd/MM/yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(initialValue!))
                    : '00/00/0000',
              )),
        ],
      ),
    );
  }
}
