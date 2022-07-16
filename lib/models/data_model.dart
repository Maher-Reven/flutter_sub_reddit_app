class Category {
  Category({
    required this.kind,
    required this.data,
  });
  final String kind;
  final CategoryData data;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        kind: json["kind"],
        data: CategoryData.fromJson(json["data"]),
      );
}

class CategoryData {
  CategoryData({
    required this.children,
  });
  final List<Article> children;
  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        children: List<Article>.from(
            json["children"].map((x) => Article.fromJson(x))),
      );
}

class Article {
  Article({
    required this.kind,
    required this.data,
  });

  final String kind;
  final DataModel data;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        kind: json["kind"],
        data: DataModel.fromServerMap(json["data"]),
      );
}

class DataModel {
  final String title;
  final String body;
  final String url;
  // final DateTime creationTime;

  DataModel({
    required this.title,
    required this.body,
    required this.url,
    // required this.creationTime,
  });

  factory DataModel.fromServerMap(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'] ?? '',
      body: json['selftext'] ?? '',
      url: json['url'] ?? '',
      // creationTime: DateTime.parse(json['created_utc']),
    );
  }
}
