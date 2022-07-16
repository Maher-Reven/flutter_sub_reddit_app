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
  late final ArticleProvider articleProviderStream =
      context.watch<ArticleProvider>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    articleProvider.initModels();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {});
    });
    // scrollController.addListener(() {
    //   if (scrollController.position.maxScrollExtent ==
    //       scrollController.offset) {
    //     articleProvider.initModels();
    //   }
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _tabBuilder() {
    return <Widget>[
      RefreshIndicator(
        onRefresh: refresh,
        child:
            articleProviderStream.isLoadingHotArticles == LoadingState.loading
                ? const Center(child: CircularProgressIndicator())
                : ArticlesTab(
                    dataModels: articleProvider.hotArticles,
                    loadMore: loadMore,
                    articlesType: 'Hot',
                  ),
      ),
      RefreshIndicator(
        onRefresh: refresh,
        child:
            articleProviderStream.isLoadingNewArticles == LoadingState.loading
                ? const Center(child: CircularProgressIndicator())
                : ArticlesTab(
                    dataModels: articleProvider.newArticles,
                    loadMore: loadMore,
                    articlesType: 'New',
                  ),
      ),
      RefreshIndicator(
        onRefresh: refresh,
        child: articleProviderStream.isLoadingRisingArticles ==
                LoadingState.loading
            ? const Center(child: CircularProgressIndicator())
            : ArticlesTab(
                dataModels: articleProvider.risingArticles,
                loadMore: loadMore,
                articlesType: 'Rising',
              ),
      ),
    ];
  }

  Future refresh() async {
    articleProvider.refresh();
  }

  Future<void> loadMore(String type) async {
    switch (type) {
      case 'Hot':
        if (articleProvider.isLoadingHotArticles == LoadingState.loading) {
          return;
        }
        await articleProvider.fetchHotArticles();
        return;
      case 'New':
        if (articleProvider.isLoadingNewArticles == LoadingState.loading) {
          return;
        }
        await articleProvider.fetchNewArticles();
        return;
      case 'Rising':
        if (articleProvider.isLoadingRisingArticles == LoadingState.loading) {
          return;
        }
        await articleProvider.fetchRisingArticles();
        return;
      default:
        return;
    }
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
            indicatorColor: Theme.of(context).indicatorColor,
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
        children: _tabBuilder(),
      ),
    );
  }
}
