import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/API/api.dart';
import 'package:student_app/Pages/auth_pages/password_verify_page.dart';
import 'package:student_app/Pages/auth_pages/password_change_page.dart';
import '../../API/custom_functions.dart';
import '../../Utilities/custom_widgets.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String number='';


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
                      isNumberController: true,
                      validate: (value){
                        number = value;
                        if(!checkIfPhoneNumber(value)){
                          return "Invalid Mobile Number";
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.phone),
                      title: "Mobile Number",
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    CustomButton(
                      onTap: (){
                        if(!checkIfPhoneNumber(number)) { return; }
                        if(isExistingUser(number)) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => PasswordVerifyPage(number: number))
                          );
                        }
                        else{
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => OtpPage(number: number,setOrReset: "set",))
                          );
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


