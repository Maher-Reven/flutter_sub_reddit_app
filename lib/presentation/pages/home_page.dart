import 'package:flutter/material.dart';
import 'package:flutter_assignment/presentation/providers/article_provider.dart';
import 'package:flutter_assignment/presentation/widgets/articles_tab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final ArticleProvider articleProvider = context.read<ArticleProvider>();

  @override
  void initState() {
    super.initState();
    articleProvider.initModels();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.black,
        title: const Text('/r/FlutterDev'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.deepPurple,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: 'Hot',
              ),
              Tab(
                text: 'New',
              ),
              Tab(
                text: 'Rising',
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ArticlesTab(
            dataModels: articleProvider.hotArticles,
          ),
          ArticlesTab(
            dataModels: articleProvider.newArticles,
          ),
          ArticlesTab(
            dataModels: articleProvider.risingArticles,
          )
        ],
      ),
    );
  }
}
