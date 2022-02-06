import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_mine/constants/components.dart';
import 'package:news_api_mine/layout/cubit/cubit.dart';
import 'package:news_api_mine/layout/cubit/states.dart';
import 'package:share/share.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit(NewsInitialState()),
        child: BlocConsumer<NewsCubit, NewsStates> (
          listener: (context, states) {},
          builder: (context, states) {
            var cubit = NewsCubit.get(context);
            var list = cubit.search;
            return Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: formField(
                    controller: searchController,
                    onChanged: (value) {
                      cubit.getSearch(value);
                    },
                    onFieldSubmitted: (value) {
                      cubit.getSearch(value);
                    },
                    hint: 'Search For Articals',
                    type: TextInputType.text,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Search Address can not be empty';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              body: Column(
                children: [

                  Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildArticalSearch(list[index], context),
                          separatorBuilder: (context, index) => SizedBox(height: 0,),
                          itemCount: list.length,
                      ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
