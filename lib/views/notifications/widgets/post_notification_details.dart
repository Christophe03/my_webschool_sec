import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostNotificationDetails extends StatefulWidget {
  final String postID;
  const PostNotificationDetails({super.key, required this.postID});

  @override
  _PostNotificationDetailsState createState() =>
      _PostNotificationDetailsState();
}

class _PostNotificationDetailsState extends State<PostNotificationDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //late Future _fetchData;

  // Future<ConseilModel> fetchPostByPostId() async {
  //   ConseilModel? article;
  //   final docRef = _firestore.collection('contents').doc(widget.postID);
  //   await docRef.get().then((DocumentSnapshot snap) {
  //     article = ConseilModel.fromFirestore(snap);
  //   });
  //   return article!;
  // }

  @override
  void initState() {
    //_fetchData = fetchPostByPostId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: _fetchData,
  //     builder: (context, AsyncSnapshot snap) {
  //       if (snap.connectionState == ConnectionState.active ||
  //           snap.connectionState == ConnectionState.waiting) {
  //         return Scaffold(
  //           appBar: AppBar(),
  //           // body: Center(child: _LoadingIndicatorWidget()),
  //         );
  //       } else if (snap.hasError) {
  //         //print(snap.error);
  //         return Scaffold(
  //           appBar: AppBar(),
  //           body: Center(
  //             child: Text('Something is wrong. Please try again!'),
  //           ),
  //         );
  //       } else {
  //         // ConseilModel article = snap.data;
  //         //print('article: ${article.title}');
  //         // if (article.contentType == 'image'){
  //         //   return ArticleDetails(data: article, tag: null);
  //         // }else if (article.contentType == 'video'){
  //         //   return VideoArticleDetails(data: article);
  //         // }else return Scaffold(
  //         //   appBar: AppBar(),
  //         //   body: Center(child: Text('Something is wrong1. Please try again!'),),
  //         // );
  //       }
  //     },
  //   );
  // }
}

// class _LoadingIndicatorWidget extends StatelessWidget {
//   const _LoadingIndicatorWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         alignment: Alignment.center,
//         width: 45,
//         height: 60,
//         child: LoadingIndicator(
//           indicatorType: Indicator.ballBeat,
//           pathBackgroundColor: Theme.of(context).primaryColor,
//         ));
//   }
// }
