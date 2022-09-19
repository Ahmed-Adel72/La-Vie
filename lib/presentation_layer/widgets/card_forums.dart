import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/models/all_forums.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';
import 'package:la_vie/presentation_layer/widgets/comments.dart';

Widget cardForums(token,context)=>ListView.separated(
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  itemBuilder: (context, index) =>Padding(
    padding: const EdgeInsets.symmetric(horizontal:12.0),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          GeneralCubit.get(context).getUserPhotoOfForum(index)!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      GeneralCubit.get(context).getUserFirstNameOfForum(index)!+' '+GeneralCubit.get(context).getUserLastNameOfForum(index)!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   'a month ago',
                    //   style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[500],fontSize: 12),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              GeneralCubit.get(context).getTitleOfForum(index)!,
              style: Theme.of(context).textTheme.bodyText2!
                  .copyWith(color: primaryColor,fontSize: 16,fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              GeneralCubit.get(context).getDescriptionOfForum(index)!,
              style: Theme.of(context).textTheme.bodyText1!
                  .copyWith(color: Colors.grey,fontSize: 12),
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            height: 300,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: GeneralCubit.get(context).getImageOfForum(index)!,
              placeholder:(context, url) =>const Center(child:CircularProgressIndicator(color: primaryColor,)) ,
              errorWidget: (context, url, error) =>const Icon(Icons.error),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              memCacheHeight: 250,
              memCacheWidth: 250,
            ),
          ),
          Row(
            children:
            [
              IconButton(
                onPressed: ()
                {
                 GeneralCubit.get(context).changeLoveButton(index).then((value)
                 {
                   GeneralCubit.get(context).putLove(token: token, forumId: GeneralCubit.get(context).getIdOfForum(index)!, index: index);
                 });

                },
                icon:AllForums.getIsLove(index)?const Icon(IconlyLight.heart,color: Colors.red,):
                const Icon(IconlyLight.heart,),
                color: Colors.grey,
              ),
              Text(
                '${GeneralCubit.get(context).getNumberOfLikesOfForum(index)!} Loves',
                style: Theme.of(context).textTheme.bodyText1!
                    .copyWith(color: Colors.grey[600],fontSize: 14,fontWeight: FontWeight.w400),
              ),
              const SizedBox(width: 30,),
              InkWell(
                onTap: ()
                {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    isScrollControlled: true,
                    builder: (context) =>
                        modalSheetComments(context,index,token),
                  );
                },
                child: Text(
                  '${GeneralCubit.get(context).getNumberOfCommentsOfForum(index)!} Replies',
                  style: Theme.of(context).textTheme.bodyText1!
                      .copyWith(color: Colors.grey[600],fontSize: 14,fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
  separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
  itemCount:GeneralCubit.get(context).getLengthOfForum(),
);
Widget modalSheetComments(BuildContext context,int index,token) {
  return BlocConsumer<GeneralCubit, GeneralStates>(
    listener: (context, state){},
    builder: (context, state)
    {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height*0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: primaryColor,fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  comments(context, index,token),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}