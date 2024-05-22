import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool cheker = true;
  Future<List<Map<String, dynamic>>>? articles;
  DBhelper dbHelper = DBhelper();
  int lastParentId = 0;
  @override
  void initState() {
    super.initState();
    loadArticleNames();
  }

  void loadArticleNames() {
    articles = dbHelper.getAllsave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.appbar(true, context),
      body: buildListView(),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> buildListView() {
    return FutureBuilder(
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      NameCat.nameCategory = snapshot.data?[index]['title'];
                      lastParentId = snapshot.data?[index]['groupId'];

                      articles = dbHelper.getArticle(lastParentId);
                      GetRoute.route(const ArticleMain(),
                          arg: snapshot.data?[index]['id']);
                    },
                    child: Container(
                      width: EsaySize.width(context),
                      height: 50,
                      decoration: CustomGr.dec(context),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      child: Center(
                          child: FittedBox(
                        child: Text(
                          snapshot.data?[index]["title"],
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  );
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
