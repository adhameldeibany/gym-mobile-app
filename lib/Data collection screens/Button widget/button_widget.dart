import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(minimumSize: Size(100, 50), backgroundColor: lightyellow),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 8.w),
        Text(
          'Set your birthday',
          style: TextStyle(fontSize: 20.sp, color: darkgrey),
        ),
      ],
    ),
    onPressed: onClicked,
  );
}