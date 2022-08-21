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
                child: Column(
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 50,
                        width: 290,
                        decoration: const BoxDecoration(
                          color: Color(0xffF3FEF1),
                       ),
                        child: Row(
                          children:
                           [
                            Image(image: AssetImage('assets/images/star.png')),
                            const SizedBox(width: 10,),
                            Text(
                                'You have 30 points',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                       padding: const EdgeInsets.only(left: 30.0,top: 20),
                       child: Container(
                         alignment: AlignmentDirectional.topStart,
                         child: Text(
                          'Edit Profile',
                            style: Theme.of(context).textTheme.bodyText2!.
                            copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                       ),
                     ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children:
                        [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Color(0xff1D592C),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                              'Change Name',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xff2F2E2E),fontSize: 17),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: ()
                            {
                            },
                            icon:const Icon(
                              IconlyLight.arrow_right,color: Color(0xff1D592C),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children:
                        [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Color(0xff1D592C),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Change Email',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xff2F2E2E),fontSize: 17),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: ()
                            {
                            },
                            icon:const Icon(
                              IconlyLight.arrow_right,color: Color(0xff1D592C),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),



                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
