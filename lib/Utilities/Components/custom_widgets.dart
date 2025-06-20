import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Utilities/colors.dart';

class CustomDesignLayout extends StatelessWidget {
  final String message;
  final Widget child;
  final bool withBackButton;
  const CustomDesignLayout({super.key, required this.message, required this.child,required this.withBackButton});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenWidth/0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppThemeColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: screenWidth/2.4,
                child: Divider(
                  thickness: 4,
                  radius: BorderRadius.circular(32),
                  color: AppThemeColor,
                ),
              ),
              SizedBox(height: 48,),
              child,
            ],
          ),
          if(withBackButton == true)
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: Get.back,
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.black,
                  size: 24,
                ),
              )
            ),
        ],
      ),
    );
  }
}

