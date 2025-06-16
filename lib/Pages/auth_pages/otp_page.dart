import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Pages/auth_pages/password_change_page.dart';
import 'package:student_app/Utilities/colors.dart';
import 'package:student_app/Utilities/Components/custom_widgets.dart';
import '../../Utilities/Components/custom_button.dart';
import '../../Utilities/Components/proper_sizer.dart';

import '../../API/api.dart';

class OtpPage extends StatefulWidget {
  final setOrReset;
  final String number;
  const OtpPage({super.key,required this.number,required this.setOrReset});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {


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
                          OtpBox(
                            onOtpChanged: (value){
                              _otp = value;
                            },
                            errorMessage: otpErrorMessage,
                          ),
                          SizedBox(height: 16,),


                          //resend and timer
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
                                Get.off(() => PasswordChangePage(setOrReset: widget.setOrReset,));
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

class OtpBox extends StatefulWidget {
  final void Function(String) onOtpChanged;
  String? errorMessage;
  OtpBox({super.key, required this.onOtpChanged, this.errorMessage});

  @override
  State<OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<OtpBox> {

  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  String otp = "";

  void onChanged(){
    otp = "";
    for (var controller in _controllers) {
      otp += controller.text;
    }
    widget.onOtpChanged(otp);
  }


  @override
  void dispose(){
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index){
            return buildOtpField(index);
          }),
        ),
        if(widget.errorMessage!=null)
          Column(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  widget.errorMessage!,
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),

      ],
    );
  }

  Widget buildOtpField(int index){
    return SizedBox(
      width: 50,
      height: 50,
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,

          onChanged: (value){
            setState(() {
              widget.errorMessage = null;
            });
            if(value.isNotEmpty && index < 4){
              FocusScope.of(context).requestFocus(_focusNodes[index+1]);
            }
            else if(value.isEmpty && index > 0){
              FocusScope.of(context).requestFocus(_focusNodes[index-1]);
            }
            onChanged();
          },
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.errorMessage!=null? Colors.redAccent : _controllers[index].value.text!=''? AppThemeColor : Color(0xffE1E1E1),
                width: 2
              ),
                borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppThemeColor,width: 2),
              borderRadius: BorderRadius.circular(8),
            ),


          ),

        ),
    );
  }
}
