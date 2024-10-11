import 'package:flutter/material.dart';
import 'package:my_webschool_sec/utils/constants_util.dart';

class EmptyView extends StatelessWidget {
  final IconData icon;
  final String message;
  final String message1;
  const EmptyView(
      {Key? key,
      required this.icon,
      required this.message,
      required this.message1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: message,
                  style: const TextStyle(
                    color: kColorDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: message1,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).secondaryHeaderColor),
                ))
          ],
        ),
      ),
    );
  }
}
