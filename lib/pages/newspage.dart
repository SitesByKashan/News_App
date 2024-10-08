import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:new_app/configs/colors.dart';
import 'package:new_app/modelApi/querymodel.dart';

class NewsPage extends StatelessWidget {
  final Articles article;
  const NewsPage({super.key , required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.whiteColor,
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.urlToImage!,height: 300,),
            //const SizedBox(height: 10,),
            Text("${article.publishedAt!.substring(0, 10)}      ${article.publishedAt!.substring(11, 16)}",
              style:  TextStyle( color: Appcolor.greenColor, fontWeight: FontWeight.bold),),
             const SizedBox(height: 10,),
            Text(article.title ?? "No Title",
              style: const TextStyle(fontSize:22, fontWeight:  FontWeight.bold),),
             const SizedBox(height: 10,),
            Text("Source : ${article.source!.name}",
              style: const TextStyle(fontSize:20, fontWeight:  FontWeight.bold),),
             const SizedBox(height: 10,),
            InkWell(onTap:(){LinkText(article.url!);} ,child:  Text(article.url!,style: TextStyle(color: Appcolor.blueColor , fontSize: 18),)),
            const Text("Description :",
              style:  TextStyle(fontSize:20, fontWeight:  FontWeight.bold),),        
            Text(article.author ?? "No Description"),
            const SizedBox(height: 10,),
            Text(article.content!),
            ],
          ),
        ),
      ),
    );
  }
}

