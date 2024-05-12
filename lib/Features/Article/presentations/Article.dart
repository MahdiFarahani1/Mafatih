import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/Click_article.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                GetRoute.route(const Clickarticle());
              },
              child: Container(
                width: EsaySize.width(context),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Center(child: Text("index $index")),
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
          itemCount: 10),
    );
  }
}
