import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../network/web_view/web_view_screen.dart';
import '../style/iconBroken.dart';

Widget BuildArticleItem(article,context)=> InkWell(
      onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(context)=>WebViewScreen(article["url"])));},
  child:Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

        children: [

        Container(

        height: 140,

        width: 140,

        decoration: BoxDecoration(

        borderRadius:

        BorderRadius.circular(10.0,),

        image: DecorationImage(

        image: NetworkImage(

        "${article["image"]}"),

        fit: BoxFit.cover)),),

        const SizedBox(

        width: 20.0,

        ),

        Expanded(

        child: SizedBox(

        height: 140,

        child: Column(

        // mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.start,

        children: [

        Expanded(

        child: Text("${article["title"]}",

        maxLines: 3,

        overflow: TextOverflow.ellipsis,

        style:

        Theme.of(context).textTheme.bodySmall,),

        ),

        Text("${article["publishedAt"]}",

        style: TextStyle(

        color: Colors.grey,

        ),)

        ],

        ),

        ),

        )

        ],

        ),

        ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 0.1,
    color: Colors.grey[500],
  ),
);

Widget ConditionlBuildArticle(list,context,{isSearch=false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context)=> ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => BuildArticleItem(list[index],context),
      separatorBuilder: (BuildContext context, int index) => myDivider(),
      itemCount: 10,),
      fallback: (context)=>isSearch? Container() : const Center(child: CircularProgressIndicator())
);

// void Signout(context){
//       CacheHelper.removeData(key:"token").then((value){
//             if (value==true){
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context)=>LoginScreen()),
//                           (route) => false);} }
//       );
// }

void printFullText(String text){
      final pattern = RegExp(".{1,800}");
      pattern.allMatches(text).forEach((match) {
            print(match.group(0));
      });


}

dynamic token= " ";

void navigateTo(context,widget)=>
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget,)=>
    Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget,),
              (route) {return false;},
    );




PreferredSizeWidget defaultAppBar({
      required BuildContext context,
      String? title,
      List<Widget>? actions,}) => AppBar(
      leading: IconButton(
            onPressed: (){
                  Navigator.pop(context);
            },
            icon: const Icon(
                  IconBroken.Arrow___Left_2
            ),
      ),
      titleSpacing: 5,
      title: Text(
            "${title}"
      ),
      actions: actions,
);

















