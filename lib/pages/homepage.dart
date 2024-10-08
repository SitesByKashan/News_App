import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_text/link_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_app/api.dart';
import 'package:new_app/configs/colors.dart';
import 'package:new_app/configs/move.dart';
import 'package:new_app/modelApi/querymodel.dart';
import 'package:new_app/pages/newspage.dart';
import 'package:new_app/pages/querysearchnews.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    print(7);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News",
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Appcolor.greenColor,
          ),
        ),
        actions: [
          IconButton(onPressed: (){setState(() {
            
          });}, icon: Icon(Icons.refresh_rounded,color: Appcolor.greenColor,)),
          IconButton(
            onPressed: () {
              gonext(const SearchNews(), context);
             
            },
            icon: Icon(
              color: Appcolor.greenColor,
              Icons.search_rounded,
            ),
          ),
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top News",
              style: GoogleFonts.bitter(fontSize: 25),
            ),
            _buildTopNews(),
            const SizedBox(height: 16.0), // Spacing between the news and tabs
            _buildTabBar(),
            Expanded(
              child: _buildTabBarView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNews() {
    return FutureBuilder(
      future: topnews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: Appcolor.greenColor,
              size: 40,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed load news"));
        } else if (snapshot.hasData && snapshot.data!.articles != null && snapshot.data!.articles!.isNotEmpty) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: snapshot.data!.articles!.map((article) => ArticleCard(article: article)).toList(),
            ),
          );
        } else {
          return const Center(child: Text("No articles available"));
        }
      },
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      dividerColor: Appcolor.greenColor,
      labelColor: Appcolor.greenColor ,
      indicatorColor: Appcolor.greenColor,
      controller: _tabController,
      isScrollable: true,
      tabs: const [
        Tab(text: "General"),
        Tab(text: "Entertainment"),
        Tab(text: "Sports"),
        Tab(text: "Technology"),
        Tab(text: "Science"),
        Tab(text: "Health"),
        Tab(text: "Business"),
      ],
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      
      controller: _tabController,
      children: [
        buildCategoryNewsList("general"),
        buildCategoryNewsList("entertainment"),
        buildCategoryNewsList("sports"),
        buildCategoryNewsList("technology"),
        buildCategoryNewsList("science"),
        buildCategoryNewsList("health"),
        buildCategoryNewsList("business"),
      ],
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Articles article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: InkWell(
        onTap: () {
          gonext(NewsPage(article: article), context);
          print(article);
        },
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  article.title!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  "${article.publishedAt!.substring(0, 10)} ${article.publishedAt!.substring(11, 16)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildCategoryNewsList(String category) {
  return FutureBuilder(
    future: catagorynews(category),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: LoadingAnimationWidget.threeArchedCircle(color: Appcolor.greenColor, size: 30));
      } else if (snapshot.hasData && snapshot.data!.sources!.isNotEmpty) {
        return ListView.builder(
          itemCount: snapshot.data!.sources!.length,
          itemBuilder: (context, index) {
            final source = snapshot.data!.sources![index];
            return Card(
              elevation: 50,
              child: ListTile(
                title: Text(source.name ?? "No Name",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),), 
                subtitle: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(source.description ?? "No Description"),
                    const SizedBox(height: 6,),
                    LinkText(source.url!, textStyle: TextStyle(color: Appcolor.blueColor),)
                  ],
                ), 
              ),
            );
          },
        );
      } else {
        return const Center(child: Text("Failed to load news"));
      }
    },
  );
}
