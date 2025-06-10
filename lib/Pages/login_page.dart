import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/API/api.dart';
import 'package:student_app/Pages/password_verify_page.dart';
import 'package:student_app/Pages/password_change_page.dart';
import '../API/custom_functions.dart';
import '../Utilities/custom_widgets.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  TextEditingController numberController = TextEditingController();
  String? _pnoErrorText;



  @override
  void dispose(){
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: ProperSizer(
        child: SizedBox(
          height: screenHeight/1.5,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/logo.png'),
              ),
              const SizedBox(
                height: 64,
              ),
              CustomDesignLayout(
                message: "Welcome",
                withBackButton: false,
                child: Column(
                  children: [
                    CustomTextField(
                      textController: numberController,
                      isNumberController: true,
                      ErrorText: _pnoErrorText,
                      prefixIcon: Icon(Icons.phone),
                      title: "Mobile Number",
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    CustomButton(
                      onTap: (){
                        String value = numberController.text;
                        if(!checkIfPhoneNumber(value)){
                          setState(() {
                            _pnoErrorText = "Invalid Mobile Number";
                          });
                        }
                        else if(isExistingUser(value)) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                // settings: RouteSettings(name: "/loginPage"),
                                builder: (context) => PasswordVerifyPage(number: value))
                          );
                          setState(() {
                            _pnoErrorText = null;
                          });
                        }
                        else{
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => OtpPage(number: value,setOrReset: "set",))
                          );
                          setState(() {
                            _pnoErrorText = null;
                          });
                        }
                      },
                      buttonText: "Continue",
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


