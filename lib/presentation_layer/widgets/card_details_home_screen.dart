import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/models/all_product.dart';

Widget cardDetailsTree(context) => Container(
      height: 425,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, int index) => Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 5, right: 5),
              child: Container(
                height: 150,
                width: 170,
                child: Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: IconButton(
                              iconSize: 18,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                              ),
                              onPressed: ()
                              {
                                GeneralCubit.get(context).changeCounterCardMinus(index: index);
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Text(
                                '${GeneralCubit.get(context).getAmountOfProduct(index)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              child: IconButton(
                                iconSize: 18,
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  GeneralCubit.get(context).changeCounterCardPlus(index: index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '${GeneralCubit.get(context).getNameOfProduct(index)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '${GeneralCubit.get(context).getPriceOfProduct(index)} EGP',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, bottom: 8, top: 5),
                        child: Container(
                          height: 28.0,
                          width: 135.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: MaterialButton(
                            onPressed: ()
                            {
                              GeneralCubit.get(context).insertToDataBase(
                                photo: GeneralCubit.get(context).getImageOfProduct(index),
                                name: GeneralCubit.get(context).getNameOfProduct(index),
                                price: GeneralCubit.get(context).getPriceOfProduct(index),
                                amount:GeneralCubit.get(context).getAmountOfProduct(index),
                                productId: GeneralCubit.get(context).getIdOfProduct(index),
                                total:GeneralCubit.get(context).getAmountOfProduct(index)!*GeneralCubit.get(context).getPriceOfProduct(index)!,
                              ).then((value)
                              {
                                GeneralCubit.get(context).favorites!.isEmpty?const SizedBox():
                                GeneralCubit.get(context).updateTotalFromDataBase(total:GeneralCubit.get(context).favorites![0]['total']+AllProductsData.getMainAmountOfCard(index)*AllProductsData.getMainPrice(index) );
                              });
                            },
                            child: Text(
                              'Add To Cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Container(
                  height: 110,
                  width: 80.0,
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: NetworkImage('${GeneralCubit.get(context).getImageOfProduct(index)}'),
                  )),
            ),
          ],
        ),
        itemCount: GeneralCubit.get(context).getLengthOfProduct(),
      ),
    );
