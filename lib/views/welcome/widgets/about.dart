import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/models/news_model.dart';

class AboutPage extends StatelessWidget {
  final NewsModel d;
  const AboutPage({Key? key, required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   onPressed: () => DialogNavigator.of(context).pop(),
                //   icon: const Icon(Icons.arrow_back),
                //   color: Theme.of(context).colorScheme.onSurface,
                // ),
                IconButton(
                  // Close the dialog completely.
                  onPressed: () => DialogNavigator.of(context).close(),
                  icon: const Icon(Icons.close),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            Text(
              'Fluid Dialog Demo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(d.message ?? "")
          ],
        ),
      ),
    );
  }
}
