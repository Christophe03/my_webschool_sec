import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/news_provider.dart';
import '../../../utils/constants_util.dart';
import '../../../utils/screem_util.dart';
import '../../../widgets/loading_cards.dart';
import 'news_card.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<News> {
  int listIndex = 0;

  @override
  Widget build(BuildContext context) {
    final fb = context.watch<NewsProvider>();
    double w = MediaQuery.of(context).size.width;
    // double h = isDeviceTablet(context) ? 490 : 150;
    double h = isDeviceTablet(context) ? 320 : 200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: h,
          width: w,
          child: PageView.builder(
            controller: PageController(initialPage: 0),
            scrollDirection: Axis.horizontal,
            itemCount: fb.data.isEmpty ? 1 : fb.data.length,
            onPageChanged: (index) {
              setState(() {
                listIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              if (fb.data.isEmpty) {
                if (fb.hasData == false) {
                  return _EmptyContent();
                } else {
                  return LoadingFeaturedCard();
                }
              }
              // return Container();
              return NewsCard(d: fb.data[index], heroTag: 'news$index');
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: DotsIndicator(
            //dotsCount: fb.data.isEmpty ? 5 : fb.data.length,
            dotsCount: fb.data.isEmpty ? 1 : fb.data.length,
            position: listIndex,
            decorator: DotsDecorator(
              color: Colors.black26,
              activeColor: Theme.of(context).primaryColorDark,
              spacing: EdgeInsets.only(left: 6),
              size: const Size.square(5.0),
              activeSize: const Size(20.0, 4.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: kColorPrimary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: RichText(
          text: const TextSpan(
              text: "Aucun contenu trouvé",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
