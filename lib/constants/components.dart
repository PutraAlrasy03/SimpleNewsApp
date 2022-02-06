import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_mine/layout/cubit/cubit.dart';
import 'package:news_api_mine/layout/cubit/states.dart';
import 'package:news_api_mine/moduels/webview_screen.dart';
import 'package:share/share.dart';


Widget buildNewsItem(artical) {
  return BlocProvider(
    create: (BuildContext context) => NewsCubit(NewsInitialState()),
    child: BlocConsumer<NewsCubit, NewsStates> (
      listener: (context, states) {},
      builder: (context, states) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              navigateTo(context, WebViewScreen(artical['url']));
            },
            child: Column(
              children: [
                Material(
                  color: NewsCubit.get(context).isDark ? Colors.grey[900] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage('${artical['urlToImage']}'),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0 ,15 ,10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text('${artical['title']}',
                              style: TextStyle(
                                color: NewsCubit.get(context).isDark ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ), maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${artical['publishedAt']}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey
                                  ), maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    foregroundColor: Colors.grey,
                                    radius: 18,
                                    child: IconButton(onPressed: () {
                                      Share.share(artical['url'], subject: 'Artical URl');
                                    }, icon: Icon(Icons.share),iconSize: 18,),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    )
  );
}


Widget buildArticalSearch(artical, context) {
  return  Padding(
    padding: const EdgeInsets.all(15.0),
    child: InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(artical['url']));
      },
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${artical['urlToImage']}'),
                  fit: BoxFit.cover,
                )
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${artical['title']}',
                      style: TextStyle(
                        fontSize: 16
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('${artical['publishedAt']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}


Widget formField({
  required TextEditingController controller,
  required TextInputType type,
  final ValueChanged<String>? onChanged,
  final Function(String)? onFieldSubmitted,
  final Function()? onTap,
  required FormFieldValidator validate,
  String? label,
  String? hint,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  bool isPassword = false,
  bool isClickable = true,
}) => TextFormField(
  // cursorColor: Colors.grey,
  validator: validate,
  controller: controller,
  keyboardType: type,
  onChanged: onChanged,
  onTap: onTap,
  enabled: isClickable,
  onFieldSubmitted: onFieldSubmitted,
  obscureText: isPassword ,
  decoration: InputDecoration(
    hintText: hint,
    fillColor: Colors.white,
    focusColor: Colors.white,
    labelText: label,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: InputBorder.none,
  ),
);



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) {
    return widget;
  }),
);
