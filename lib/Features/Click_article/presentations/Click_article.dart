import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';

class Clickarticle extends StatelessWidget {
  const Clickarticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: DropShadow(
                child: Container(
                  width: EsaySize.width(context),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Center(child: Text("index $index")),
                ),
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
          itemCount: 5),
    );
  }
}
