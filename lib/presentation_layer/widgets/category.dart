import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

Widget selectCategory()=>ListView.separated(
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) => Row(
    children: [
      InkWell(
        onTap: ()
        {
          GeneralCubit.get(context).changeSelectIndex(index);
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

List<String> category=
[
  'All',
  'Plants',
  'Seeds',
  'Tools',
];