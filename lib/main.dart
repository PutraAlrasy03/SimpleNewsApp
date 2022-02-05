import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_api_mine/layout/cubit/cubit.dart';
import 'package:news_api_mine/layout/cubit/states.dart';
import 'package:news_api_mine/remote/chache_helper.dart';
import 'package:news_api_mine/remote/dio_helper.dart';
import 'constants/bloc_observer.dart';
import 'constants/constants.dart';
import 'layout/home_layout.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark = CacheHelper.getBoolen(key: 'isDark');
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  @override

  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => NewsCubit(NewsInitialState())..onAppModeChange(
        fromShared: isDark,
      ),
      child: BlocConsumer<NewsCubit, NewsStates> (
        listener: (context, states)  {},
        builder: (context, states) {
          ThemeMode mode = NewsCubit.get(context).isDark ? ThemeMode.light: ThemeMode.dark;
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
              ),
              primarySwatch: Colors.deepPurple,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                    color: Colors.white
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                unselectedItemColor: Colors.grey,
              ) ,
              primarySwatch: Colors.deepPurple,
            ),
            themeMode: mode,
            home: HomeLayout(),
          );
        } ,
      ),
    );
  }
}


