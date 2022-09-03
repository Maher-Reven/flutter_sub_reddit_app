import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:flutter_assignment/presentation/widgets/article_card.dart';

typedef LoadMore = Function(String type);

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({
    required this.dataModels,
    required this.loadMore,
    required this.articlesType,
    required this.isLoading,
    Key? key,
  }) : super(key: key);
  final List<DataModel> dataModels;
  final LoadMore loadMore;
  final String articlesType;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (ScrollUpdateNotification notification) {
              if (notification.metrics.pixels /
                      notification.metrics.maxScrollExtent >=
                  0.8) {
                loadMore(articlesType);
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (context, index) => ArticleCard(
                dataModel: dataModels[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: dataModels.length,
            ),
          ),
        ),
        if (isLoading) const CircularProgressIndicator(),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
