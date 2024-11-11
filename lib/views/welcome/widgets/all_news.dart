import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_webschool_sec/models/news_model.dart';
import 'package:my_webschool_sec/providers/news_provider.dart';
import 'package:my_webschool_sec/utils/constants_util.dart';
import 'package:my_webschool_sec/views/welcome/widgets/news_card.dart';
import 'package:my_webschool_sec/widgets/app_name.dart';
import 'package:my_webschool_sec/widgets/loading_cards.dart';
import '../../../utils/screem_util.dart';

class AllNews extends StatefulWidget {
  const AllNews({Key? key}) : super(key: key);

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  bool fetching = true;
  List<NewsModel> news = [];

  void fetchData() async {
    setState(() {
      fetching = true;
    });

    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fb = context.watch<NewsProvider>();
    double w = MediaQuery.of(context).size.width;
    // double h = isDeviceTablet(context) ? 490 : 150;
    double h = isDeviceTablet(context) ? 320 : 200;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kColorPrimary,
        titleSpacing: 0,
        title: AppName(
          fontSize: 19.0,
          school: "quoi.de.neuf".tr(),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kColorLight,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Builder(builder: (BuildContext context) {
        return RefreshIndicator(
            onRefresh: () async {
              context.read<NewsProvider>().onRefresh(mounted);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: fb.data.isEmpty
                        ? fb.hasData == false
                            ? const _EmptyContent()
                            : Column(
                                children: [
                                  SizedBox(
                                      height: h,
                                      width: w,
                                      child: const LoadingFeaturedCard()),
                                  SizedBox(
                                      height: h,
                                      width: w,
                                      child: const LoadingFeaturedCard()),
                                  SizedBox(
                                      height: h,
                                      width: w,
                                      child: const LoadingFeaturedCard()),
                                ],
                              )
                        : ListView(
                            children: [
                              ...fb.data.map((e) {
                                return SizedBox(
                                  height: h,
                                  width: w,
                                  child: NewsCard(d: e, heroTag: 'news'),
                                );
                                // return Text("rdfdfdf");
                              })
                            ],
                          ))
              ],
            ));
      }),
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
      child: const Center(
        child: Text(
          "Aucun contenu trouvé",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
