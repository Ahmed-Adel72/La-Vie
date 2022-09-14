import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

List<String> category=
['All', 'Plants', 'Seeds', 'Tools',];

List<String> categoryOfBlog=
['Plants', 'Seeds', 'Tools',];

List<String> categoryOfForums=
['All forums', 'My forums',];

Widget selectCategory()=>ListView.separated(
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) => Row(
    children: [
      InkWell(
        onTap: ()
        {
          GeneralCubit.get(context).changeSelectIndex(index);
          // GeneralCubit.get(context).getInMyCart(index);
        },
        child: Container(
          height: 30.0,
          width: 80.0,
          decoration: BoxDecoration(
            color:GeneralCubit.get(context).selectIndex==index?Colors.grey[100]: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
            border:GeneralCubit.get(context).selectIndex==index? Border.all(color: primaryColor)
                :Border.all(color: Colors.white),
          ),
          child: Center(
              child: Text(
                category[index],
                style:GeneralCubit.get(context).selectIndex==index? Theme.of(context).textTheme.bodyText2!.copyWith(color: primaryColor)
                    :Theme.of(context).textTheme.bodyText2!,
              )),
        ),
      ),
    ],
  ),
  separatorBuilder: (context, index) => const SizedBox(
    width: 10.0,
  ),
  itemCount: 4,
);

Widget selectCategoryOfBlog()=>ListView.separated(
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) => Row(
    children: [
      InkWell(
        onTap: ()
        {
          GeneralCubit.get(context).changeSelectIndexOfBlog(index);
          // GeneralCubit.get(context).getInMyCart(index);
        },
        child: Container(
          height: 30.0,
          width: 80.0,
          decoration: BoxDecoration(
            color:GeneralCubit.get(context).selectIndexOfBlog==index?Colors.grey[100]: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
            border:GeneralCubit.get(context).selectIndexOfBlog==index? Border.all(color: primaryColor)
                :Border.all(color: Colors.white),
          ),
          child: Center(
              child: Text(
                categoryOfBlog[index],
                style:GeneralCubit.get(context).selectIndexOfBlog==index? Theme.of(context).textTheme.bodyText2!.copyWith(color: primaryColor)
                    :Theme.of(context).textTheme.bodyText2!,
              )),
        ),
      ),
    ],
  ),
  separatorBuilder: (context, index) => const SizedBox(
    width: 10.0,
  ),
  itemCount: 3,
);

Widget selectCategoryOfForums()=>ListView.separated(
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) => Row(
    children: [
      InkWell(
        onTap: ()
        {
          GeneralCubit.get(context).changeSelectIndexOfForums(index);
          // GeneralCubit.get(context).getInMyCart(index);
        },
        child: Container(
          height: 30.0,
          width: 110.0,
          decoration: BoxDecoration(
            color:GeneralCubit.get(context).selectIndexOfForums==index?primaryColor: Colors.grey[100],
            borderRadius: BorderRadius.circular(5.0),
            border:GeneralCubit.get(context).selectIndexOfForums==index? Border.all(color: primaryColor)
                :Border.all(color: Colors.grey),
          ),
          child: Center(
              child: Text(
                categoryOfForums[index],
                style:GeneralCubit.get(context).selectIndexOfForums==index? Theme.of(context).textTheme.bodyText2!.copyWith(fontSize:12,fontWeight:FontWeight.w500,color: Colors.white)
                    :Theme.of(context).textTheme.bodyText2!.copyWith(fontSize:12,fontWeight:FontWeight.w500,),
              )),
        ),
      ),
    ],
  ),
  separatorBuilder: (context, index) => const SizedBox(
    width: 10.0,
  ),
  itemCount: 2,
);
