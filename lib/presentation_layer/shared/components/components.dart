import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultTextFormField({
  Color? prefixIconColor,
  Color? iconColor,
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? labelText,
  double radius = 6.0,
  TextStyle? labelStyle,
  Widget? suffixIcon,
  Widget? prefixIcon,
  ValueChanged<String>? onChanged,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmit,
  bool obscureText = false,
  int maxLine = 1,
  TextDirection textDirection = TextDirection.ltr,
  required BuildContext context,
}) {
  return TextFormField(
    cursorColor: Theme.of(context).primaryColor,
    maxLines: maxLine,
    textDirection: textDirection,
    style: Theme.of(context).textTheme.bodyText1,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: const EdgeInsetsDirectional.all(20),
      labelText: labelText,
      iconColor: iconColor,
      prefixIconColor: prefixIconColor,
      labelStyle: labelStyle,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
    obscureText: obscureText,
    onChanged: onChanged,
    validator: validator,
    onFieldSubmitted: onSubmit,
  );
}

enum ToastState {success, warning,error}
Color toastColor(ToastState state){
  Color? color;

  switch(state)
  {
    case ToastState.success:
      color=Colors.green;
      break;
    case ToastState.error:
      color=Colors.red;
      break;
    case ToastState.warning:
      color=Colors.amberAccent;
      break;
  }
  return color;
}

void showToast({
  required String message,
  required ToastState toastState,
}) {
  Fluttertoast.showToast(
    msg: message,
    fontSize: 16,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: toastColor(toastState),
    textColor: Colors.white,
  );
}

void navigatePushTo({
  required BuildContext context,
  required Widget navigateTo,
}) {
  Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => navigateTo),
  );
}

void navigatePushAndFinish({
  required BuildContext context,
  required Widget navigateTo,
}) {
  Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => navigateTo,
      ),
          (route) => false);
}