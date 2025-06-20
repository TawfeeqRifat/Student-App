import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_app/Utilities/Components/proper_sizer.dart';
import 'package:student_app/Utilities/colors.dart';

import '../API/api.dart';

class ViewProfilePage extends StatefulWidget {
  final Data data;
  const ViewProfilePage({super.key,required this.data});
  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)
        ),
        title: Text(
          "View Full Profile",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppThemeColor.withValues(alpha: 0.8),
      ),

      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      height: 128,
                      decoration: BoxDecoration(
                        color: AppThemeColor.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(36),
                          bottomLeft: Radius.circular(36)
                        )
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.data.profileUrl  ),
                          radius: 72,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 16,),
              Text(
                widget.data.name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              Text(
                "${widget.data.std} - ${widget.data.section}",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey
                ),
              ),
              Text(
                "Roll No: ${widget.data.rollno}",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey
                ),
              ),

              SizedBox(height: 16,),

              InfoBox(
                title: "Personal Information",
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoContainer(title: "DOB", value: "15/7/2006",width: 150,),
                      InfoContainer(title: "Gender", value: "Male",width: 150,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoContainer(title: "Blood Group", value: "O+",width: 150,),
                      InfoContainer(title: "Nationality", value: "Indian",width: 150,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoContainer(title: "Religion", value: "Hindu",width: 150,),
                      InfoContainer(title: "Mother Tongue", value: "Hindi",width: 150,)
                    ],
                  )
                ]
              ),
              InfoBox(
                title: "Contact Information",
                  children: [
                    InfoContainer(title: "Address", value: "123, Main Street,\nNew Delhi, India"),
                    InfoContainer(title: "Phone Number", value: "+91 9876543210"),
                    InfoContainer(title: "Email", value: "aaravsharma@gmail.com")
                  ]
              ),
              InfoBox(
                title: "Academic Information",
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoContainer(title: "Class", value: "10",width: 150,),
                      InfoContainer(title: "Roll Number", value: "23",width: 150,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoContainer(title: "Admission Number", value: "12345",width: 150,),
                      InfoContainer(title: "Academic Year", value: "2023-2024",width: 150,)
                    ],
                  )
                ]
              ),
              SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const InfoBox({super.key, required this.children, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow:[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(-5, 5),
            )
          ]
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical:16  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: children,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String title;
  final String value;
  final double? width;
  const InfoContainer({super.key, required this.title, required this.value, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: AppThemeColor.withValues(alpha: 0.1)
          // color: Colors.grey.withValues(alpha: 0.2)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Divider(
                  height: 10,
                  // endIndent: 10,
                  radius: BorderRadiusGeometry.circular(8),
              ),
              SizedBox(height: 4,),
              Text(
                value,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),
              )
            ],
          ),
        )
    );
  }
}
