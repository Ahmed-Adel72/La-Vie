import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/presentation_layer/models/get_my_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notification',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 19,color: Colors.black,fontWeight: FontWeight.w500),
        ),
        titleSpacing: 120,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          width: double.infinity,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => notifications(context,index),
            separatorBuilder:(context, index) => const Divider(indent: 20,endIndent: 10,thickness: 1,),
            itemCount:GetMyDataModel.getLengthOfNotification(),
          ),
        ),
      ),
    );
  }
}
Widget notifications(BuildContext context,index)=> Padding(
  padding: const EdgeInsets.all(12.0),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Text(
        GetMyDataModel.getMessageOfNotification(index),
        style: Theme.of(context).textTheme.bodyText2!.
        copyWith(color:const Color(0xff1A1F36),fontSize: 15,fontWeight: FontWeight.w500,fontFamily:'Poppins' ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 5,),
      Text(
        GetMyDataModel.getCreatedAt(index),
        style: Theme.of(context).textTheme.bodyText2!.copyWith(color:const Color(0xffA5ACB8),fontSize: 14,fontWeight: FontWeight.w500),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
);
