import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

Widget cardForums()=>ListView.separated(
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
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1660834534~exp=1660835134~hmac=d21ad1da5fa1f3744b79e92168b9f5ebf4a7bb64d2e19c4c5201e4e8a49a8226'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'Ahmed Adel',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),
                  ),
                  Text(
                    'a month ago',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[500],fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'How To treat plants',
              style: Theme.of(context).textTheme.bodyText2!
                  .copyWith(color: primaryColor,fontSize: 16,fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'it is a long established fact that a reader will be distracted.',
              style: Theme.of(context).textTheme.bodyText1!
                  .copyWith(color: Colors.grey,fontSize: 12),
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1660834534~exp=1660835134~hmac=d21ad1da5fa1f3744b79e92168b9f5ebf4a7bb64d2e19c4c5201e4e8a49a8226'),
                fit: BoxFit.cover,
              ),

            ),
          ),
          Row(
            children:
            [
              IconButton(
                onPressed: (){},
                icon: Icon(IconlyLight.heart),
                color: Colors.grey,
              ),
              Text(
                '0 Likes',
                style: Theme.of(context).textTheme.bodyText1!
                    .copyWith(color: Colors.grey[600],fontSize: 14,fontWeight: FontWeight.w400),
              ),
              const SizedBox(width: 30,),
              Text(
                '2 Replies',
                style: Theme.of(context).textTheme.bodyText1!
                    .copyWith(color: Colors.grey[600],fontSize: 14,fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
  separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
  itemCount: 10,
);