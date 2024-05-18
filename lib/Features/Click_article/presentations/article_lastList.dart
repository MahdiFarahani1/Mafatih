import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:get/get.dart';

class ArticleLastList extends StatefulWidget {
  const ArticleLastList({super.key});

  @override
  State<ArticleLastList> createState() => _ArticleMainState();
}

class _ArticleMainState extends State<ArticleLastList> {
  DBhelper dbHelper = DBhelper();
  int lastParentId = 0;
  Future<List<Map<String, dynamic>>>? articles;
  @override
  initState() {
    super.initState();
    loadArticleNames();
  }

  loadArticleNames() {
    DBhelper dbHelper = DBhelper();
    articles = dbHelper.getNewContent(Get.arguments as int);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.appbar(false, context),
      body: Container(
        width: EsaySize.width(context),
        height: EsaySize.height(context),
        decoration: const BoxDecoration(color: Colors.white),
        child: buildListView(),
      ),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> buildListView() {
    return FutureBuilder(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CostumLoading.fadingCircle(context));
        } else if (snapshot.hasData) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        NameCat.nameCategory = snapshot.data?[index]['title'];
                        lastParentId = snapshot.data?[index]['id'];

                        articles = dbHelper.getNewContent(lastParentId);
                        articles!.then(
                          (value) {
                            if (value.isEmpty) {
                              GetRoute.route(const ArticleMain(),
                                  arg: lastParentId);
                            }
                          },
                        );
                      },
                      child: Container(
                        width: EsaySize.width(context),
                        height: 50,
                        decoration: CustomGr.dec(),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: Center(
                            child: Text(
                          snapshot.data?[index]["title"],
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      endIndent: 60,
                      indent: 60,
                      color: ConstColor.Col0,
                    );
                  },
                  itemCount: snapshot.data!.length));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
