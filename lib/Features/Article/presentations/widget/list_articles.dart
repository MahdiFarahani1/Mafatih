import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Features/Article/presentations/widget/box.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListArticles {
  static Widget list(
      {required Future<List<Map<String, dynamic>>>? articles,
      required int lastParentId,
      required DBhelper dbHelper,
      required dynamic myClass}) {
    return FutureBuilder(
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () async {
                        NameCat.nameCategory = snapshot.data?[index]['title'];
                        lastParentId = snapshot.data?[index]['id'];

                        articles = dbHelper.getArticle(lastParentId);
                        articles!.then(
                          (value) {
                            if (snapshot.data![index].containsKey("_text")) {
                              GetRoute.route(const ArticleMain(),
                                  arg: lastParentId, context: context);
                            } else {
                              GetRoute.route(myClass,
                                  arg: lastParentId, context: context);
                            }
                          },
                        );
                      },
                      child: CommonBox.txt(
                          snapshot.data?[index]['title'], context));
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    endIndent: 60,
                    indent: 60,
                    color: BlocProvider.of<ThemeCubit>(context).state.Col0,
                  );
                },
                itemCount: snapshot.data!.length);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CostumLoading.loadCircle(context);
          }
          return const SizedBox.shrink();
        });
  }
}
