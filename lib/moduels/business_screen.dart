import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_mine/constants/components.dart';
import 'package:news_api_mine/layout/cubit/cubit.dart';
import 'package:news_api_mine/layout/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: ( context, state) {
        var list = NewsCubit.get(context).business;
        if(list.length > 0){
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildNewsItem(list[index]),
              separatorBuilder: (context, index) => SizedBox(height: 0,),
              itemCount: 10);
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
