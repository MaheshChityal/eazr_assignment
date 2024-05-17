import 'package:flutter/material.dart';
import 'package:news_app/screens/article.dart';
import '../apiServices/api_service.dart';
import '../model/article_model.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> articles = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  void fetchArticles() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Article> fetchedNewsArticles =
          await ApiService.getArticlesByCategory(widget.category);
      setState(() {
        articles.addAll(fetchedNewsArticles);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching articles: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                Article article = articles[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleScreen(article: article),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article.urlToImage.isNotEmpty)
                          Image.network(
                            article.urlToImage,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.asset('assets/images/dummy.jpg'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.description ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            CircularProgressIndicator(),
        ],
      ),
    );
  }
}
