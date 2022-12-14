import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

TextEditingController commentController = TextEditingController();
Widget comments(BuildContext context,int index,token)=> SizedBox(
  height: MediaQuery.of(context).size.height*0.8,
  child: Stack(
    children:
    [
      SizedBox(
        height: MediaQuery.of(context).size.height*0.72,
        child: ListView.separated(
          shrinkWrap: true,
          physics:const BouncingScrollPhysics(),
          itemBuilder: (context, indexComment)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Text(
                      GeneralCubit.get(context).getCommentOfForum(index,indexComment)!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey[700],fontSize: 14,fontWeight: FontWeight.w600),
                    ),
                ),
              ],
            ),
          ),
          separatorBuilder:(context, indexComment)=> const SizedBox(height: 10,),
          itemCount: GeneralCubit.get(context).getNumberOfCommentsOfForum(index)!,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          right: 5,
            left: 5,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children:
              [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: commentController,
                      cursorColor: primaryColor,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'write your comment...',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: primaryColor,
                  child: MaterialButton(
                      onPressed: ()
                      {
                        GeneralCubit.get(context).createComment(
                            token: token,
                            comment: commentController.text,
                            forumId: GeneralCubit.get(context).getIdOfForum(index)!,
                        ).then((value) =>
                        {
                          commentController.clear(),
                        });
                      },
                    minWidth: 1,
                    child:const Icon(
                      IconlyLight.send,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  ),
);