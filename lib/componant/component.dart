import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

//extract TextFormField as reusable widget in flutter
Widget defaultFormField({
  required TextEditingController controller,
  Function? onTap,
  Function(String)? onSubmitted,
  String? Function(String?)? validate,
  Function? suffixPressed,
  Function(String)? onChanged,
  TextInputType? type,
  bool isPassword = false,
  String? label,
  String? hintText,
  double radius = 5,
  int? minLines=1,
  int? maxLines=1,
  IconData? prefixIcon,
  IconData? suffixIcon,
}) => TextFormField(
  minLines: minLines,
  maxLines: maxLines,
  controller: controller,
  obscureText: isPassword,
  keyboardType: type,
  validator: validate,
  onTap: () {
    if (onTap != null) onTap();
  },
  onChanged: onChanged,
  onFieldSubmitted: onSubmitted,
  decoration: InputDecoration(
    label: label != null ? Text(label) : null,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    suffixIcon:
        suffixIcon != null
            ? IconButton(
              icon: Icon(suffixIcon),
              onPressed: () {
                if (suffixPressed != null) suffixPressed();
              },
            )
            : null,
    hintText: hintText,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
  ),
);

Widget txt({
  String? txt,
  double? size,
  FontWeight? weight,
  Color? color,
  int? maxLine,
}) => Text(
  '$txt',
  style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  maxLines: maxLine,
  overflow: TextOverflow.ellipsis,
);

void navigatePush(context, {required Widget widget}) {
  Navigator.push(
    context,
    MaterialPageRoute(allowSnapshotting: true, builder: (context) => widget),
  );
}

void navigatePushAndRemove(BuildContext? context, {required Widget widget}) {
  Navigator.pushAndRemoveUntil(
    context!,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

Widget buildPage({
  required String title,
  double? sizeTitle,
  FontWeight? weightTitle,
  Color? color,
  int? maxLine,
  required String urlImage,
  double? heightImage,
}) => Container(
  child: Column(
    children: [
      Text(
        '$title',
        style: TextStyle(
          fontSize: sizeTitle,
          fontWeight: weightTitle,
          color: color,
        ),
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 15),
      Expanded(
        child: Image.asset('$urlImage', height: heightImage, fit: BoxFit.cover),
      ),
    ],
  ),
);

Widget defaultButton({
  Function? onPressed,
  double height = 40,
  double width = double.infinity,
  double radius = 15,
  double elevate = 0,
  Widget? child,
  Color? textColor = Colors.white,
  Color? btnColor = Colors.blue,
}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius), // 👈 التحكم في الـ radius
    ),
    onPressed: () {
      onPressed!();
    },
    minWidth: width,
    height: height,
    elevation: elevate,
    textColor: textColor,
    color: btnColor,
    child: child,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.ERROR:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.amber;
  }
}

void showToast({required String text, required ToastStates states}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(states),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

String formatDate(String date) {
  DateTime parsed = DateTime.parse(date);
  return DateFormat('yyyy/MM/dd •• hh:mm a').format(parsed);
}
