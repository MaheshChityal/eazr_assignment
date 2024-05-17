import 'package:flutter/material.dart';

import '../model/article_model.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )else Image.asset('assets/images/dummy.jpg'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                article.description,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
