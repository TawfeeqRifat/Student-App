import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Pages/auth_pages/login_page.dart';
import 'package:student_app/Pages/profile_page.dart';
import '../API/api.dart';
import '../Utilities/colors.dart';
import '../custom_icons.dart';
import '../student_info.dart';

class HomeSkeleton extends StatefulWidget {
  final int index;
  const HomeSkeleton({super.key,required this.index});

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton> {

  int bottomIndex = 0;
  late List<Widget> pages;
  List<String> headlineList = ['Home',"Attendance",'Calendar','Profile'];
  String headlineText = 'Home';

  //for holding the user data from the details
  late Data _currentData;

  @override
  void initState(){
    super.initState();

    //setting the user data
    _currentData = details[widget.index]!;

    pages = <Widget>[
      Container(),
      Container(),
      Container(),
      ProfilePage(data: _currentData,),
    ];

  }

  //to change the account
  void changeAccount(int index){
    setState(() {
      _currentData = details[index]!;
    });
  }

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
                  return SwitchProfile(changeAccount: changeAccount, currentIndex: widget.index,);
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
                    backgroundImage: NetworkImage(_currentData.profileUrl),
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
                        backgroundImage: NetworkImage(_currentData.profileUrl),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentData.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700
                                )
                              ),
                              Text(
                                "Class ${_currentData.std}",
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



class SwitchProfile extends StatefulWidget {
  final Function(int) changeAccount;
  final int currentIndex;
  const SwitchProfile({super.key, required this.changeAccount, required this.currentIndex});

  @override
  State<SwitchProfile> createState() => _SwitchProfileState();
}

class _SwitchProfileState extends State<SwitchProfile> {

  late int _selectedIndex;


  @override
  void initState(){
    _selectedIndex = widget.currentIndex;
  }
  // on account changed
  void accountChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
    widget.changeAccount(index);
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 360,
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
          SizedBox(
            height: 54,
            width: double.infinity,
            child: Center(
              child: const Text(
                "Switch Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            )
          ),

          SizedBox(
            height: 270,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: details.length,

              itemBuilder: (BuildContext context,int index){
                return ProfileView(
                  name: details[index]!.name,
                  std: details[index]!.std,
                  imageUrl: details[index]!.profileUrl,
                  selectedIndex: _selectedIndex,
                  currentIndex: index,
                  onTap: (){
                    accountChanged(index);
                  },
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
          SizedBox(height: 4,)
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final String name;
  final String std;
  final String imageUrl;
  final int selectedIndex;
  final int currentIndex;
  final Function() onTap;
  const ProfileView({super.key, required this.name, required this.std, required this.imageUrl,required this.selectedIndex, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selectedIndex == currentIndex? AppThemeColor.withValues(alpha: 0.3): Colors.transparent,
            border: Border.all(
                width: 4,
                color: selectedIndex == currentIndex? AppThemeColor.withValues(alpha: 0.001 ): Colors.transparent,
            ),
          ),
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
        ),
      ),
    );
  }
}
