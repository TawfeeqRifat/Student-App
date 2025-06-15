import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_app/Pages/auth_pages/login_page.dart';
import '../Utilities/colors.dart';
import '../Utilities/custom_widgets.dart';
import '../custom_icons.dart';
import '../student_info.dart';

class HomeSkeleton extends StatefulWidget {
  final String name;
  const HomeSkeleton({super.key,required this.name});

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton> {

  int bottomIndex = 0;
  late List<Widget> pages;
  List<String> headlineList = ['Home',"Attendance",'Calendar','Profile'];
  String headlineText = 'Home';

  @override
  void initState(){
    super.initState();

    pages = <Widget>[
      Container(),
      Container(),
      Container(),
      Container(),
    ];
  }

  bool newNotification = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black87,
        backgroundColor: Colors.white,
        //headline
        title: Text(
          headlineText,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [

          //profile dropdown
          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                context: context,
                builder: (BuildContext context){
                  return SwitchProfile();
                }
              );
            },
            child: Container(
              height: 38,
              width: 64,
              decoration: BoxDecoration(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/009/354/850/non_2x/male-portrait-people-profile-perfect-for-social-media-and-business-presentations-user-interface-ux-graphic-and-web-design-applications-and-interfaces-illustration-vector.jpg"),
                  ),
                  // Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ),
          ),
          SizedBox(width: 8,),
        ],
      ),

      body: pages.elementAt(bottomIndex),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        onTap: (index){
          setState(() {
            bottomIndex = index;
            headlineText = headlineList[index];
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppThemeColor,
        showSelectedLabels: true,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400
        ),
        enableFeedback: true,
        selectedIconTheme: IconThemeData(
          size: 24
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: Colors.blueGrey
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:ImageIcon(AssetImage("assets/icons/home_icon.png")),
              label: "Home",
          ),
          const BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/notification_icon.png")),
              label: "Attendance"
          ),
          const BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/calendar_icon.png")),
              label: "Calendar"
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile"
          ),
        ]
      ),


      drawer: SafeArea(
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32),bottomRight: Radius.circular(32)),
            side: BorderSide(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              //profile box
              SizedBox(
                height: screenHeight/5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/009/354/850/non_2x/male-portrait-people-profile-perfect-for-social-media-and-business-presentations-user-interface-ux-graphic-and-web-design-applications-and-interfaces-illustration-vector.jpg"),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700
                                )
                              ),
                              Text(
                                "Class IX",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey
                                )
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: (){
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(thickness: 1.5,),
        
        
              //drawer buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerTiles(tileName: "Dashboard", icon: CustomIcons.dashboard, onPressed: () {  },),
                    DrawerTiles(tileName: "TimeTable", icon: CustomIcons.timetable, onPressed: () {  },),
                    DrawerTiles(tileName: "Attendance", icon: CustomIcons.attendance, onPressed: () {  },),
                    DrawerTiles(tileName: "Announcements", icon: CustomIcons.announcements, onPressed: () {  },),
                    DrawerTiles(tileName: "Notifications", icon: Icons.notifications_none_rounded, onPressed: () {  },),
                    DrawerTiles(tileName: "Study Material", icon: CustomIcons.study, onPressed: () {  }, iconSize: 22,),
                    DrawerTiles(tileName: "Contact Information", icon: Icons.phone_outlined, onPressed: () {  },)
                  ],
                ),
              ),
        
              Spacer(),
              Divider(thickness: 1.5,),
        
              //preferences tab
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Text(
                        "Preferences",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),
                      ),
                    ),
                    DrawerTiles(tileName: "Settings", icon: Icons.settings, onPressed: () {  },),
                    DrawerTiles(tileName: "Help", icon: Icons.help_outline, onPressed: () {  },),
                    DrawerTiles(tileName: "Logout", icon: Icons.logout, iconColor: Colors.redAccent, fontColor: Colors.redAccent,
                      onPressed: () {
                        Get.offAll(LoginPage());
                      },
                    ),
                    SizedBox(height: 8,)
                  ],
                ),
              )
            ],
          )
        ),
      )
    );
  }

}

class DrawerTiles extends StatelessWidget {
  final String tileName;
  final IconData icon;
  final Color? iconColor;
  final Color? fontColor;
  final Function() onPressed;
  final double? iconSize;
  const DrawerTiles({super.key,required this.tileName, required this.icon, this.iconColor, this.fontColor,required this.onPressed, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      ),
      onPressed: onPressed,

      child: SizedBox(
        width: double.infinity,
        height: 32,
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize ?? 24,
              color: iconColor ?? Color(0xff262E3D),
            ),
            SizedBox(width: 18,),
            Text(
              tileName,
              style: TextStyle(
                fontSize: 14,
                color: fontColor ?? Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        )
      ),
    );
  }
}



class SwitchProfile extends StatelessWidget {
  const SwitchProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),

      ),
      child: Column(
        children: [
          SizedBox(height: 4,),
          SizedBox(
            width: 40,
            child: Divider(
              thickness: 4,
              radius: BorderRadius.circular(16),
            ),
          ),
          Divider(thickness: 0.5, height: 2,endIndent: 3,),
          SizedBox(height: 8,),
          Container(
            height: 54,
            width: double.infinity,
            color: Colors.white60,
            alignment: Alignment.center,
            child: const Text(
              "Switch Profile",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            )
          ),
          SizedBox(
            height: 220,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context,int index){
                return ProfileView(
                    name: details[index]!['name'] ?? "",
                    std: details[index]!['std'] ?? "",
                    imageUrl: details[index]!['profileUrl'] ?? ""
                );
              },
              separatorBuilder: (context, index){
                return Divider(
                  height: 0,
                  thickness: 0.5,

                );
              },
            ),
          ),
          SizedBox(height: 8,)
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final String name;
  final String std;
  final String imageUrl;
  const ProfileView({super.key, required this.name, required this.std, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Class $std",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
