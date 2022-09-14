import 'package:flutter/material.dart';
import 'package:la_vie/presentation_layer/screens/forums_screen.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children:
          [
            Text('Notification Screen'),
            Container(
              height: 45.0,
              width: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Theme.of(context).primaryColor,
              ),
              child: MaterialButton(
                onPressed: ()
                {
                  navigatePushTo(context: context, navigateTo: ForumsScreen());


                },
                child: Text(
                  'forums',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
