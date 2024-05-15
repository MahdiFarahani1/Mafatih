import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Search/presentations/cubit/search_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        BlocProvider.of<SearchCubit>(context).init();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Container(
                    width: EsaySize.width(context),
                    height: EsaySize.height(context) * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onSubmitted: (value) {
                          BlocProvider.of<SearchCubit>(context)
                              .searchData(value);
                        },
                        controller: textEditingController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue.shade400,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                BlocProvider.of<SearchCubit>(context)
                                    .searchData(textEditingController.text);
                              },
                              child: const Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state.status is Loading) {
                        return Expanded(
                            child: CostumLoading.fadingCircle(context));
                      }
                      if (state.status is Error) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 130),
                          child: Lottie.asset(
                              Assets.lottie.animation1715784626188),
                        );
                      }
                      if (state.status is SearchData) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  GetRoute.route(const ArticleMain(),
                                      arg: state.data?[index]["groupId"]);
                                },
                                child: Container(
                                  width: EsaySize.width(context),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  child: Center(
                                      child: Text(
                                    state.data?[index]["title"],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ))),
    );
  }
}
