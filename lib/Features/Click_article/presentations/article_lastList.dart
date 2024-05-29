import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Features/Article/presentations/widget/box.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      onTap: () async {
                        NameCat.nameCategory = snapshot.data?[index]['title'];
                        lastParentId = snapshot.data?[index]['id'];
                        articles = dbHelper.getNewContent(lastParentId);
                        await articles!.then(
                          (value) {
                            GetRoute.route(const ArticleMain(),
                                arg: lastParentId, context: context);
                          },
                        );
                      },
                      child: CommonBox.txt(
                          snapshot.data?[index]['title'], context),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      endIndent: 60,
                      indent: 60,
                      color: BlocProvider.of<ThemeCubit>(context).state.Col0,
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
