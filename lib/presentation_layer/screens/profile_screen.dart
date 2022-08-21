import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:
        [
          Stack(
            children:
            [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1660834534~exp=1660835134~hmac=d21ad1da5fa1f3744b79e92168b9f5ebf4a7bb64d2e19c4c5201e4e8a49a8226'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child:  BackdropFilter(
                  filter:  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child:  Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Row(
                  children:
                  [
                    IconButton(
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      icon:const Icon(
                        IconlyLight.arrow_left,color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                      },
                      icon:const Icon(
                        Icons.more_horiz_sharp,color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    children:
                    [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1660834534~exp=1660835134~hmac=d21ad1da5fa1f3744b79e92168b9f5ebf4a7bb64d2e19c4c5201e4e8a49a8226'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'ahmed adel',
                        style:
                        Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
