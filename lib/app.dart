import 'package:flutter/material.dart';
import 'package:flutter_assignment/config/theme.dart';
import 'package:flutter_assignment/presentation/pages/home_page.dart';
import 'package:flutter_assignment/presentation/providers/article_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticleProvider>(
            create: (_) => ArticleProvider()),
      ],
      child: MaterialApp(
        title: 'Lepaya Assignment',
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
