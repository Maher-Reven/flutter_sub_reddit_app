import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:flutter_assignment/repositories/data_repository.dart';

enum LoadingState { loadMore, loading, loaded }

class ArticleProvider extends ChangeNotifier {
  final List<DataModel> _hotArticles = [];
  final List<DataModel> _newArticles = [];
  final List<DataModel> _risingArticles = [];
  LoadingState _hotArticlesLoadingState = LoadingState.loading;
  LoadingState _newArticlesLoadingState = LoadingState.loading;
  LoadingState _risingArticlesLoadingState = LoadingState.loading;
  String _afterHot = '';
  String _afterNew = '';
  String _afterRising = '';

  // Getters encapsulated so they cannot be modified from outside.
  List<DataModel> get hotArticles => List<DataModel>.from(_hotArticles);
  List<DataModel> get newArticles => List<DataModel>.from(_newArticles);
  List<DataModel> get risingArticles => List<DataModel>.from(_risingArticles);

  LoadingState get hotArticlesLoadingState => _hotArticlesLoadingState;
  LoadingState get newArticlesLoadingState => _newArticlesLoadingState;
  LoadingState get risingArticlesLoadingState => _risingArticlesLoadingState;

  Future<void> fetchHotArticles() async {
    final DataRepository dataRepository = DataRepository();
    final hotArticles =
        await dataRepository.getData('hot', afterValue: _afterHot);
    _hotArticles.addAll(hotArticles);
    _hotArticlesLoadingState = LoadingState.loaded;
    _afterHot = hotArticles.last.after;
    notifyListeners();
  }

  Future<void> fetchNewArticles() async {
    final DataRepository dataRepository = DataRepository();
    final newArticles =
        await dataRepository.getData('new', afterValue: _afterNew);
    _newArticles.addAll(newArticles);
    _newArticlesLoadingState = LoadingState.loaded;
    _afterNew = newArticles.last.after;
    notifyListeners();
  }

  Future<void> fetchRisingArticles() async {
    final DataRepository dataRepository = DataRepository();

    final risingArticles =
        await dataRepository.getData('rising', afterValue: _afterRising);
    _risingArticles.addAll(risingArticles);
    _risingArticlesLoadingState = LoadingState.loaded;
    _afterRising = risingArticles.last.after;
    notifyListeners();
  }

  void initModels() {
    fetchHotArticles();
    fetchNewArticles();
    fetchRisingArticles();
  }

  void refresh() {
    _hotArticlesLoadingState = LoadingState.loading;
    _newArticlesLoadingState = LoadingState.loading;
    _risingArticlesLoadingState = LoadingState.loading;
    notifyListeners();
    fetchHotArticles();
    fetchNewArticles();
    fetchRisingArticles();
  }

  Future<void> loadMoreHotArticles() async {
    _hotArticlesLoadingState = LoadingState.loadMore;
    notifyListeners();
    await fetchHotArticles();
  }

  Future<void> loadMoreNewArticles() async {
    _newArticlesLoadingState = LoadingState.loadMore;
    notifyListeners();
    await fetchNewArticles();
  }

  Future<void> loadMoreRisingArticles() async {
    _risingArticlesLoadingState = LoadingState.loadMore;
    notifyListeners();
    await fetchRisingArticles();
  }
}
