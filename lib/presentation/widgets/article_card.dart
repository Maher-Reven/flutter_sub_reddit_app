import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    required this.dataModel,
    Key? key,
  }) : super(key: key);
  final DataModel dataModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(dataModel.url),
          mode: LaunchMode.externalApplication,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 5,
                  offset: const Offset(-2, -1),
                ),
              ]),
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).primaryColorLight,
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        dataModel.title.isEmpty
                            ? 'Post Title #'
                            : dataModel.title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      dataModel.body.isEmpty
                          ? 'Click to check the content'
                          : dataModel.body,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
