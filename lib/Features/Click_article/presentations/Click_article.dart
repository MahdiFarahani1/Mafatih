import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:get/get.dart';

class Clickarticle extends StatefulWidget {
  const Clickarticle({super.key});

  @override
  State<Clickarticle> createState() => _ClickarticleState();
}

class _ClickarticleState extends State<Clickarticle> {
  List<dynamic> articleNames = [];
  List<dynamic> articleId = [];

  @override
  initState() {
    super.initState();
    loadArticleNames();
  }

  void loadArticleNames() async {
    DBhelper dbHelper = DBhelper();
    List<Map<String, dynamic>> articles =
        await dbHelper.getArticle(Get.arguments);
    setState(() {
      articleNames = articles.map((article) => article['title']).toList();
      articleId = articles.map((e) => e['id']).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          NameCat.nameCategory,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                NameCat.nameTitle = articleNames[index];
                GetRoute.route(const ArticleMain(), arg: articleId[index]);
              },
              child: Container(
                constraints: const BoxConstraints(minHeight: 50),
                width: EsaySize.width(context),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("${articleNames[index]}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                )),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              endIndent: 60,
              indent: 60,
              color: Colors.blue.shade900,
            );
          },
          itemCount: articleNames.length),
    );
  }
}
