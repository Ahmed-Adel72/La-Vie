import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/models/all_blogs.dart';

Widget cardBlogs(context,index) => Column(
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
                  image: NetworkImage('${GeneralCubit.get(context).getBlogImage(index)}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                SizedBox(
                  width:146,
                  child: Text(
                    '${GeneralCubit.get(context).getBlogName(index)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2!
                        .copyWith(fontSize:17,color: Colors.black,fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 11.0,),
                SizedBox(
                  width: 190,
                  height: 40,
                  child: Text(
                    '${GeneralCubit.get(context).getBlogDescription(index)}',
                    style: GoogleFonts.poppins(fontSize: 12,color:const Color(0xff7D7B7B),fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                GeneralCubit.get(context).selectIndexOfBlog==0?Row(
                  children:
                  [
                    Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[300],
                        ),
                        child: Image.asset('assets/images/sun.png')),
                    const SizedBox(width: 3,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Text(
                          '${AllBlogs.getBlogPlantSun(index)}',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10,color: Colors.grey[800]),
                        ),
                        Text(
                          'Sun light',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 8,color: Colors.grey[800],fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: 4,),
                    Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[300],
                        ),
                        child: Image.asset('assets/images/water.png')),
                    const SizedBox(width: 3,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Text(
                          '${AllBlogs.getBlogPlantWater(index)}',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10,color: Colors.grey[800]),
                        ),
                        Text(
                          'Water',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 8,color: Colors.grey[800],fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: 4,),
                    Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[300],
                        ),
                        child: Image.asset('assets/images/temp.png')),
                    const SizedBox(width: 3,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Text(
                          '${AllBlogs.getBlogPlantTemp(index)} c',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10,color: Colors.grey[800]),
                        ),
                        Text(
                          'Temperature',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 8,color: Colors.grey[800],fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                  ],
                ):
                const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
);