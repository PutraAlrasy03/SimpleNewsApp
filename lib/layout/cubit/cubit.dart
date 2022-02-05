import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_mine/layout/cubit/states.dart';
import 'package:news_api_mine/moduels/business_screen.dart';
import 'package:news_api_mine/moduels/science_screen.dart';
import 'package:news_api_mine/moduels/settings_screen.dart';
import 'package:news_api_mine/moduels/sports_screen.dart';
import 'package:news_api_mine/remote/chache_helper.dart';
import 'package:news_api_mine/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(initialState) : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int navIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports),  label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science),  label: 'Science'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings),  label: 'Settings'),
  ];
  void onChangeNavBar (int index) {
    navIndex = index;
    if(navIndex == 1) getSports();
    if(navIndex == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsbusinessLoading());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'us',
      'category' : 'business',
      'apiKey' : '6a1ef2cce99c47508e09c3a231f0eca2',
    }).then((value) {
      business = value?.data['articles'];
      emit(NewsbusinessSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsbusinessError(onError.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsSportsLoading());
    if(sports.length == 0) {
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'us',
        'category' : 'sports',
        'apiKey' : '6a1ef2cce99c47508e09c3a231f0eca2',
      }).then((value) {
        sports = value?.data['articles'];
        emit(NewsSportsSuccess());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsSportsError(onError.toString()));
      });
    }else {
      emit(NewsSportsSuccess());
    }

  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsScienceLoading());
    if(science.length == 0) {
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'us',
        'category' : 'science',
        'apiKey' : '6a1ef2cce99c47508e09c3a231f0eca2',
      }).then((value) {
        science = value?.data['articles'];
        print(science[0]['title']);
        emit(NewsScienceSuccess());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsScienceError(onError.toString()));
      });
    }else {
      emit(NewsScienceSuccess());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    search = [];
    emit(NewsSearchLoading());
    if(search.length == 0) {
      DioHelper.getData(url: '/v2/everything',
          query: {
        'q': value,
        'apiKey' : '6a1ef2cce99c47508e09c3a231f0eca2',
      }).then((value) {
        search = value?.data['articles'];
        emit(NewsSearchSuccess());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsSearchError(onError.toString()));
      });
    }else {
      emit(NewsSearchSuccess());
    }
  }

  bool isDark = false;
  void onAppModeChange({bool? fromShared}) {
    if(fromShared != null) {
      isDark = fromShared;
      emit(ModeStateChange());
    }
    else {
      isDark =!isDark;
      CacheHelper.putBoolen(key: 'isDark', value: isDark).then((value) {
        emit(ModeStateChange());
      } );
    }
    print( 'Dark Mode $isDark');
  }

}