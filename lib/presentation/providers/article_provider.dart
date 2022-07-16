import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:flutter_assignment/repositories/data_repository.dart';

class ArticleProvider extends ChangeNotifier {
  final List<DataModel> _hotArticles = [];
  final List<DataModel> _newArticles = [];
  final List<DataModel> _risingArticles = [];
  bool _isLoadingHotArticles = true;
  bool _isLoadingNewArticles = true;
  bool _isLoadingRisingArticles = true;

  // Getters encapsulated so they cannot be modified from outside.
  List<DataModel> get hotArticles => List<DataModel>.from(_hotArticles);
  List<DataModel> get newArticles => List<DataModel>.from(_newArticles);
  List<DataModel> get risingArticles => List<DataModel>.from(_risingArticles);

  bool get isLoadingHotArticles => _isLoadingHotArticles;
  bool get isLoadingNewArticles => _isLoadingNewArticles;
  bool get isLoadingRisingArticles => _isLoadingRisingArticles;

  Future<void> fetchHotArticles() async {
    final DataRepository dataRepository = DataRepository();
    final hotArticles = await dataRepository.getData('hot');
    _hotArticles.addAll(hotArticles);
    _isLoadingHotArticles = false;
    notifyListeners();
  }

  Future<void> fetchNewArticles() async {
    final DataRepository dataRepository = DataRepository();
    final newArticles = await dataRepository.getData('new');
    _newArticles.addAll(newArticles);
    _isLoadingNewArticles = false;
    notifyListeners();
  }

  Future<void> fetchRisingArticles() async {
    final DataRepository dataRepository = DataRepository();
    final risingArticles = await dataRepository.getData('rising');
    _risingArticles.addAll(risingArticles);
    _isLoadingRisingArticles = false;
    notifyListeners();
  }

  void initModels() {
    fetchHotArticles();
    fetchNewArticles();
    fetchRisingArticles();
  }

  void refresh() {
    _isLoadingHotArticles = true;
    _isLoadingNewArticles = true;
    _isLoadingRisingArticles = true;
    notifyListeners();
    fetchHotArticles();
    fetchNewArticles();
    fetchRisingArticles();
  }
}
