import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/news_model.dart';
import '../utils/constants_util.dart';

class NewsProvider extends ChangeNotifier {
  String _lastVisible = '';
  String get lastVisible => _lastVisible;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<NewsModel> _data = [];
  List<NewsModel> get data => _data;

  List<DocumentSnapshot> _snap = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? timestamp;
  String? cid;

  bool? _hasData;
  bool get hasData => _hasData ?? false;

  Future<Null> getData(mounted) async {
    final userHive = Hive.box(hivedb);
    _hasData = true;
    QuerySnapshot rawData;
    if (_lastVisible == '') {
      rawData = await firestore
          .collection('messages_' + userHive.get('sid'))
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();
    } else {
      rawData = await firestore
          .collection('messages_' + userHive.get('sid'))
          .orderBy('timestamp', descending: true)
          .startAfter([_lastVisible])
          .limit(10)
          .get();
    }

    if (rawData.docs.isNotEmpty) {
      _lastVisible = rawData.docs[rawData.docs.length - 1]['timestamp'];
      if (mounted) {
        _isLoading = false;
        _snap.clear();
        _snap.addAll(rawData.docs);

        _data = _snap.map((e) => NewsModel.fromFirestore(e)).toList();
      }
    } else {
      if (_lastVisible == '') {
        _isLoading = false;
        _hasData = false;
        // print('no items');
      } else {
        _isLoading = false;
        _hasData = true;
        // print('no more items');
      }
    }

    notifyListeners();
    return null;
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted) {
    _isLoading = true;
    _snap.clear();
    _data.clear();
    _lastVisible = '';
    getData(mounted);
    notifyListeners();
  }
}
