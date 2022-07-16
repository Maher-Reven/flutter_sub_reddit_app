import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    required this.dataModel,
    Key? key,
  }) : super(key: key);
  final DataModel dataModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dataModel.title,
        ),
        Text(dataModel.body)
      ],
    );
  }
}
