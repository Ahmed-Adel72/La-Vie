import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

Widget myFavoriteCard(context,index) => Column(
  children:
  [

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children:
          [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 120,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Image(
                  image: NetworkImage(GeneralCubit.get(context).favorites![index]['photo']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  width:146,
                  child: Text(
                    '${GeneralCubit.get(context).favorites![index]['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2!
                        .copyWith(fontSize:16,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 11.0,),
                Text(
                  '${GeneralCubit.get(context).favorites![index]['price']} EGP',
                  style: Theme.of(context).textTheme.bodyText2!
                      .copyWith(fontSize:15,color: primaryColor),
                ),
                const SizedBox(height: 17.0,),
                Container(
                  height: 25,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: Row(
                    children:
                    [
                      Container(
                        width:28,
                        child: IconButton(
                          onPressed: ()
                          {
                            GeneralCubit.get(context).changeCounterMyCardMinus(index: index,context: context);
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: primaryColor,
                            size: 17,
                          ),
                        ),
                      ),
                      Text(
                        '${GeneralCubit.get(context).favorites![index]['amount']}',
                        style:const TextStyle(color: Colors.black),
                      ),
                      Container(
                        width: 28,
                        child: IconButton(
                          onPressed: ()
                          {
                            GeneralCubit.get(context).changeCounterMyCardPlus(index: index,context: context);
                          },
                          icon: const Icon(
                            Icons.add,
                            color: primaryColor,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: IconButton(
                onPressed: ()
                {
                  GeneralCubit.get(context)
                      .deleteDataFromDataBase(id: GeneralCubit.get(context).favorites![index]['id'])
                      .then((value)
                  {
                    GeneralCubit.get(context).updateTotalFromDataBase(total: GeneralCubit.get(context).favorites![0]['total']-GeneralCubit.get(context).favorites![index]['amount']*GeneralCubit.get(context).favorites![index]['price']);
                  })
                  //     .then((value)
                  // {
                  //   GeneralCubit.get(context).changeInMyCartButton(index: index);
                  // })
                  ;
                },
                icon: const Icon(
                  Icons.delete,
                  color: primaryColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);