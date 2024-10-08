import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_app/api.dart';
import 'package:new_app/configs/colors.dart';
import 'package:new_app/configs/move.dart';
import 'package:new_app/modelApi/querymodel.dart';
import 'package:new_app/pages/newspage.dart';

class SearchNews extends StatefulWidget {
  const SearchNews({super.key});

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  List<Articles> articles = [];
  bool isLoading = false;
  String errorMessage = '';


  void _fetchNews(String q) async {
    setState(() {
      isLoading = true;
      errorMessage = ''; 
    });

    try {
      QueryNewsModel? newsModel = await querynews(q); 
      setState(() {
        articles = newsModel!.articles ?? []; 
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString(); 
      });
    } finally {
      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.whiteColor,
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
            ModernSearchField(hintText: "Search", onSubmittted: (value) {
             _fetchNews(value);
            }), 

                if(isLoading) Center(heightFactor: 10, child: LoadingAnimationWidget.fourRotatingDots(color: Appcolor.greenColor, size: 60)),
                if(errorMessage.isNotEmpty) Center(child: Text(errorMessage, style: const TextStyle(fontSize: 20,),)),
                Expanded(
                  child:ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: (){gonext(NewsPage(article: articles[index]), context);},
                          child: Card(
                            color: Appcolor.whiteColor,
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(articles[index].urlToImage != null) Image.network(articles[index].urlToImage! ,semanticLabel: "No Image",),
                                  const SizedBox(height: 10,),
                                  Text(articles[index].title ?? "No Title",
                                    style: const TextStyle(fontSize:18, fontWeight:  FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                   Text(articles[index].source!.name ?? "Unknow Source",
                                    style: const TextStyle(fontSize:15, fontWeight:  FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                  Text("${articles[index].publishedAt!.substring(0, 10)}      ${articles[index].publishedAt!.substring(11, 16)}",
                                      style: const TextStyle(fontWeight: FontWeight.bold),),
                              
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }) 
                )
              
            ]
            
          ),
        )
      ),
    );
  }
}



class ModernSearchField extends StatelessWidget {
  final String hintText;
  final Function(String)? onSubmittted;

  const ModernSearchField({
    super.key,
    this.hintText = "Search...",
    this.onSubmittted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Appcolor.whiteColor,
        elevation: 20,
        child: TextField(
          onSubmitted: onSubmittted,
          decoration: InputDecoration(
              hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 95, 95, 95)), // Placeholder color
            filled: true,
            fillColor: Appcolor.whiteColor, // Background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
              borderSide: BorderSide.none, // Remove border lines
            ),
           
            contentPadding: const EdgeInsets.all(16.0), // Padding inside the field
          ),
        ),
      ),
    );
  }
}
