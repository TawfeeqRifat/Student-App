import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_app/Pages/view_profile_page.dart';
import 'package:student_app/custom_icons.dart';

import '../API/api.dart';

class ProfilePage extends StatefulWidget {
  final Data data;
  const ProfilePage({super.key,required this.data});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16,),
              Text(
                "ABC School",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 24,),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.data.profileUrl  ),
                radius: 64,
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
              SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(-5, 5),
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    child: Column(
                      spacing: 8,
                      children: [
                        ProfileContainerItem(
                          title: "View Profile",
                          icon: Icons.person_outline_rounded,
                          onPressed: (){
                           Get.to(ViewProfilePage(data: widget.data));
                          }
                        ),
                        ProfileContainerItem(title: "Attendance",icon: CustomIcons.attendance, onPressed: () {  },),
                        ProfileContainerItem(title: "Marks", icon: Icons.bar_chart_rounded, onPressed: () {  },),
                        ProfileContainerItem(title: "Late Record", icon: CustomIcons.laterecord, onPressed: () {  },),
                        ProfileContainerItem(title: "Settings", icon: Icons.settings, onPressed: () {  },),
                        ProfileContainerItem(title: "Contact Administration", icon: Icons.phone_outlined, onPressed: () {  },),
                        ProfileContainerItem(title: "Logout", icon: Icons.logout_rounded, onPressed: () {  },)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
            ],
          )
      ),
    );
  }
}

class ProfileContainerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const ProfileContainerItem({super.key, required this.title, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black12,
              child: Icon(
                  icon
              ),
            ),
            SizedBox(width: 8,),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.black
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

