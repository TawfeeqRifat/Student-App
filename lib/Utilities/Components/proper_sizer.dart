import 'package:flutter/material.dart';

class ProperSizer extends StatelessWidget {
  final Widget child;
  const ProperSizer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: SizedBox(
              height: screenHeight,
              child: Center(
                child: child,
              ),
            )
        ),
      ),
    );
  }
}