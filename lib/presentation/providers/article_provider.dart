import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:flutter_assignment/repositories/data_repository.dart';

enum LoadingState { loadMore, loading, loaded }

class ArticleProvider extends ChangeNotifier {
  final List<DataModel> _hotArticles = [];
  final List<DataModel> _newArticles = [];
  final List<DataModel> _risingArticles = [];
  LoadingState _isLoadingHotArticles = LoadingState.loading;
  LoadingState _isLoadingNewArticles = LoadingState.loading;
  LoadingState _isLoadingRisingArticles = LoadingState.loading;
  String _afterHot = '';
  String _afterNew = '';
  String _afterRising = '';

  // Getters encapsulated so they cannot be modified from outside.
  List<DataModel> get hotArticles => List<DataModel>.from(_hotArticles);
  List<DataModel> get newArticles => List<DataModel>.from(_newArticles);
  List<DataModel> get risingArticles => List<DataModel>.from(_risingArticles);

  LoadingState get isLoadingHotArticles => _isLoadingHotArticles;
  LoadingState get isLoadingNewArticles => _isLoadingNewArticles;
  LoadingState get isLoadingRisingArticles => _isLoadingRisingArticles;

  Future<void> fetchHotArticles() async {
    final DataRepository dataRepository = DataRepository();
    final hotArticles =
        await dataRepository.getData('hot', afterValue: _afterHot);
    _hotArticles.addAll(hotArticles);
    _isLoadingHotArticles = LoadingState.loaded;
    _afterHot = hotArticles.last.after;
    notifyListeners();
  }

  Future<void> fetchNewArticles() async {
    final DataRepository dataRepository = DataRepository();
    final newArticles =
        await dataRepository.getData('new', afterValue: _afterNew);
    _newArticles.addAll(newArticles);
    _isLoadingNewArticles = LoadingState.loaded;
    _afterNew = newArticles.last.after;
    notifyListeners();
  }

  Future<void> fetchRisingArticles() async {
    final DataRepository dataRepository = DataRepository();
    final risingArticles =
        await dataRepository.getData('rising', afterValue: _afterRising);
    _risingArticles.addAll(risingArticles);
    _isLoadingRisingArticles = LoadingState.loaded;
    _afterRising = risingArticles.last.after;
    notifyListeners();
  }

  void initModels() {
    fetchHotArticles();
    fetchNewArticles();
    fetchRisingArticles();
  }

  void refresh() {
    _isLoadingHotArticles = LoadingState.loading;
    _isLoadingNewArticles = LoadingState.loading;
    _isLoadingRisingArticles = LoadingState.loading;
    notifyListeners();
    fetchHotArticles();
    fetchNewArticles();
    fetchRisingArticles();
  }
}
