import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Article/presentations/widget/box.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Search/presentations/cubit/search_cubit.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
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
          appBar: CommonAppbar.appbar(true, context),
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Container(
                    width: EsaySize.width(context),
                    height: EsaySize.height(context) * 0.1,
                    decoration: BoxDecoration(
                        gradient: CustomGr.gradient(context),
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
                        cursorColor:
                            BlocProvider.of<ThemeCubit>(context).state.Col3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              BlocProvider.of<ThemeCubit>(context).state.Col2,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                BlocProvider.of<SearchCubit>(context)
                                    .searchData(textEditingController.text);
                              },
                              child: Icon(
                                Icons.search,
                                color: BlocProvider.of<ThemeCubit>(context)
                                    .state
                                    .Col3,
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
                  listViewWithBloc(),
                ],
              ))),
    );
  }

  BlocBuilder<SearchCubit, SearchState> listViewWithBloc() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.status is Loading) {
          return Expanded(child: CostumLoading.fadingCircle(context));
        }
        if (state.status is Error) {
          return Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Lottie.asset(Assets.lottie.animation1715784626188),
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
                      GetRoute.route(
                          ArticleMain(
                            isSearchMode: true,
                            txtSearch: textEditingController.text,
                          ),
                          arg: state.data?[index]["id"]);
                    },
                    child: CommonBox.txt(state.data?[index]['title'], context));
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
