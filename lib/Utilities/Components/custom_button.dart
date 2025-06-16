import 'package:flutter/material.dart';

import '../colors.dart';class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  const CustomButton({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {

    double ScreenWidth = MediaQuery.sizeOf(context).width;

    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppThemeColor,
            shadowColor: Colors.black12,
            fixedSize: Size(
                ScreenWidth,
                60
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            )
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700
          ),
        ),
      // ),
    );
  }
}