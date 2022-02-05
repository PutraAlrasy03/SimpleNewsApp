import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_mine/constants/components.dart';
import 'package:news_api_mine/constants/constants.dart';
import 'package:news_api_mine/layout/cubit/cubit.dart';
import 'package:news_api_mine/layout/cubit/states.dart';
import 'package:news_api_mine/main.dart';
import 'package:news_api_mine/moduels/search_screen.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(NewsInitialState())..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: ( context, state) {  },
        builder: ( context, state) {
          var cubit =  NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   onPressed: () {
              //     NewsCubit.get(context).onAppModeChange();
              //   },
              //   icon: Icon(Icons.brightness_4),
              // ),
              title: const Text('News App'),
              actions: [
                IconButton(onPressed: () {
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search),)
              ],
            ),
            body: cubit.screens[cubit.navIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.navIndex,
              onTap:(index) {
                cubit.onChangeNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
