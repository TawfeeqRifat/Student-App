import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:student_app/Pages/create_password.dart';
import 'package:student_app/Pages/reset_password.dart';
import 'package:student_app/Utilities/colors.dart';
import 'package:student_app/Utilities/custom_widgets.dart';

import '../API/api.dart';

class OtpPage extends StatefulWidget {
  final resetORset;
  final String number;
  const OtpPage({super.key,required this.number,required this.resetORset});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  // TextEditingController otpController = TextEditingController();
  String? otpErrorMessage;

  String _otp = "";

  //resend button logic
  bool isResendEnabled = false;


  //counter logic
  static const Duration countdownDuration = Duration(seconds: 30);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(countdownDuration);
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTimer());
  }

  void addTimer(){
    final seconds = durationNotifier.value.inSeconds - 1;
    if(seconds < 0){
      timer?.cancel();
      enableReset();
    }
    else{
      durationNotifier.value = Duration(seconds: seconds);
    }
  }

  void enableReset(){
    setState(() {
      isResendEnabled = true;
    });
  }

  void reset_timer(){
    setState(() {
      isResendEnabled = false;
    });
    durationNotifier.value = countdownDuration;
    startTimer();
  }
  @override
  void initState(){
    super.initState();
    startTimer();
  }

  @override
  void dispose(){
    timer?.cancel();
    durationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return ValueListenableBuilder(
      valueListenable: durationNotifier,
      builder: (BuildContext context, Duration value, Widget? child) {
        return Scaffold(
            body: ProperSizer(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight / 8,),
                    CustomDesignLayout(
                      message: "Enter OTP",
                      withBackButton: true,
                      child: Column(
                        children: [
                          Text(
                            "Please enter the OTP sent to ${widget.number}\nValid for 5 minutes",
                            style: const TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 32,),
                          OtpTextField(
                            mainAxisAlignment: MainAxisAlignment.start,
                            numberOfFields: 5,
                            showFieldAsBox: true,
                            borderColor: Color(0xff512da8),
                            focusedBorderColor: AppThemeColor,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 64,
                            fieldWidth: 58,
                            borderWidth: 2,
                            onCodeChanged: (_){
                              setState(() {
                                otpErrorMessage = null;
                              });
                            },
                            onSubmit: (String verificationCode){
                              _otp = verificationCode;
                            },
                            margin: EdgeInsets.symmetric(horizontal: 7),
                          ),
                          if(otpErrorMessage!=null)
                            Text(
                              otpErrorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),

                          SizedBox(height: 16,),
                          Row(
                            children: [

                              //resend button
                              TextButton(
                                onPressed: (){
                                  if(isResendEnabled){
                                    print("resent otp");
                                    reset_timer();
                                  }
                                },
                                child: const Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black26
                                  ),
                                ),
                              ),
                              Spacer(),

                              //timer
                              Text(
                                "00:${durationNotifier.value.inSeconds.toString().padLeft(2,'0')}",
                                style: TextStyle(
                                  color: AppThemeColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 48,),

                          //verify otp button
                          CustomButton(
                            onTap: (){
                              if(checkOTPValidity(_otp)){
                                Navigator.of(context).pop();
                                if(widget.resetORset == "reset") {
                                  Navigator.push(context, CupertinoPageRoute(
                                    builder: (
                                        context) => const ResetPasswordPage(),));
                                }
                                else{
                                  Navigator.push(context, CupertinoPageRoute(
                                    builder: (
                                        context) => const CreatePasswordPage(),));
                                }
                              }
                              else{
                                setState(() {
                                  otpErrorMessage = "Incorrect OTP";
                                });
                              }
                            },
                            buttonText: "Verify OTP",
                          )
                        ],
                      ),
                    ),
                  ],
                )
            )
        );
      }
    );
  }
}
