import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/utils/string_util.dart';
import 'package:my_webschool_sec/views/welcome/widgets/about.dart';

import '../../../models/news_model.dart';
import '../../../utils/constants_util.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../utils/screem_util.dart';

class NewsCard extends StatelessWidget {
  final NewsModel d;
  final heroTag;

  const NewsCard({Key? key, required this.d, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxLine = isDeviceTablet(context) ? 11 : 4;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ]),
          child:
              //  Column(
              //   children: [
              //     Container(
              //       height: 5,
              //       color: Colors.blue,
              //     ),
              //     Expanded(
              //       child:
              //           LayoutBuilder(
              //             builder: (context, constraints) {
              //               return Container(
              //                 constraints: BoxConstraints(
              //                   maxHeight: constraints.maxHeight,
              //                 ),
              //                 child: SingleChildScrollView(
              //                   child: Text(
              //                     'Your Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very  long text here. Your long text here. Your long text here. Your long text here. Your long text here. Your long text here.',
              //                     maxLines: 4,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                       fontSize: 20,
              //                       color: Colors.greenAccent,
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //     ),
              //     Container(
              //       height: 50,
              //       color: Colors.green,
              //     ),
              //   ],
              // ),

              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: hexToColor(d.color!).withOpacity(0.7)),
                  child: RichText(
                      text: TextSpan(
                    text: d.categorie!.toCapitalized(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: RichText(
                                  text: TextSpan(
                                text: d.message!,
                                style: const TextStyle(
                                  color: kColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                // maxLines: maxLine,
                                // overflow: TextOverflow.ellipsis,
                              ))),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.person,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: d.sender!,
                                  style: TextStyle(
                                      fontSize: 16, color: kColorPrimary)))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.time,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: timeAgoSinceDate(d.timestamp!),
                                  style: const TextStyle(
                                      fontSize: 13, color: kColorDark)))
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
      onTap: () => {
        // showModal(
        //   context: context,
        //   builder: (context) => FluidDialog(
        //     // Use a custom curve for the alignment transition
        //     alignmentCurve: Curves.easeInOutCubicEmphasized,
        //     // Setting custom durations for all animations.
        //     sizeDuration: const Duration(milliseconds: 300),
        //     alignmentDuration: const Duration(milliseconds: 600),
        //     transitionDuration: const Duration(milliseconds: 300),
        //     reverseTransitionDuration: const Duration(milliseconds: 50),
        //     // Here we use another animation from the animations package instead of the default one.
        //     transitionBuilder: (child, animation) => FadeScaleTransition(
        //       animation: animation,
        //       child: child,
        //     ),
        //     // Configuring how the dialog looks.
        //     defaultDecoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.surface,
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //     // Setting the first dialog page.
        //     rootPage: FluidDialogPage(
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(0),
        //         color: Colors.white,
        //       ),
        //       builder: (context) => AboutPage(
        //         d: d,
        //       ),
        //     ),
        //   ),
        // )
        //  Navigator.push(context, MaterialPageRoute(
        // builder: (context) => ArticleDetails(data: article, tag: heroTag,)),
        // );
        showModalBottomSheet(
            context: context,
            elevation: 5,
            isScrollControlled: true,
            builder: (_) => Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  // top: 15,
                  // left: 15,
                  // right: 15
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(top: 5, bottom: 5),
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(5),
                            color: hexToColor(d.color!).withOpacity(0.7)),
                        child: RichText(
                            text: TextSpan(
                          text: d.categorie!.toCapitalized(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: RichText(
                              text: TextSpan(
                            text: d.message!,
                            style: const TextStyle(
                              color: kColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            // maxLines: 3,
                            // overflow: TextOverflow.ellipsis,
                          )),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        hexToColor(d.color!).withOpacity(0.7)),
                              ),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'fermer'.tr(),
                                      style: const TextStyle(fontSize: 16))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ]),
                    ])))
      },
    );
  }
}
