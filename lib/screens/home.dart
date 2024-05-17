import 'package:flutter/material.dart';
import 'package:news_app/screens/category.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  final List<String> categoryImages = [
    'assets/images/business.jpg',
    'assets/images/entertainment.jpg',
    'assets/images/general.jpg',
    'assets/images/health.jpg',
    'assets/images/science.jpg',
    'assets/images/sports.jpg',
    'assets/images/technology.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    category: categories[index],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      categoryImages[index],
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


