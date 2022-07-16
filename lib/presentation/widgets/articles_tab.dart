import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:flutter_assignment/presentation/widgets/article_card.dart';

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({
    required this.dataModels,
    Key? key,
  }) : super(key: key);
  final List<DataModel> dataModels;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemBuilder: (context, index) => ArticleCard(
              dataModel: dataModels[index],
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: dataModels.length);
  }
}
