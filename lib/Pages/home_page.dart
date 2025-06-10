import 'package:flutter/material.dart';
import '../Utilities/colors.dart';
import '../Utilities/custom_widgets.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({super.key,required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

      appBar: AppBar(title: Text(headlineText),),

      bottomNavigationBar: NavigationBar(
        height: 64,
        onDestinationSelected: (int index){
          setState(() {
            bottomIndex = index;
            headlineText = headlineList[index];
          });
        },
          indicatorColor: AppThemeColor,
          selectedIndex: bottomIndex,
        destinations: const<Widget>[
          NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          NavigationDestination(
              icon: Icon(Icons.add),
              label: "Attendance"
          ),
          NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: "Calendar"
          ),
          NavigationDestination(
              icon: Icon(Icons.person),
              label: "Profile"
          ),
        ]
      ),
      body: Builder(
        builder: (context) =>
          ProperSizer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight/18,),

                //profile and welcome image
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: Scaffold.of(context).openDrawer,
                //       child: Row(
                //         children: [
                //           const CircleAvatar(
                //             radius: 28,
                //             child: Icon(
                //               Icons.person,
                //               size: 42,
                //             ),
                //           ),
                //           const SizedBox(width: 15,),
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const Text("Welcome,"),
                //               Text(
                //                 widget.name,
                //                 style: const TextStyle(
                //                     fontWeight: FontWeight.w600
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Spacer(),
                //     Stack(
                //       children: [
                //         const Icon(
                //           Icons.notifications_none_rounded,
                //           size: 32,
                //         ),
                //         newNotification ? const Positioned(
                //               right: 6,
                //               top: 6,
                //               child: CircleAvatar(
                //                 backgroundColor: Color(0xfffed8f7),
                //                 radius: 4,
                //                 child: CircleAvatar(
                //                   backgroundColor: Colors.red,
                //                   radius: 2.5,
                //                 ),
                //               )
                //           ) : const SizedBox(),
                //       ]
                //     )
                //   ],
                // )

              ],
            ),
          ),
      ),

      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradient1,
            )
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight/3.4,
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              ),
              DrawerTiles(tileName: "Notifications",icon: Icon(Icons.notifications_none_rounded,size: 24,color: Colors.black,)),
              DrawerTiles(
                tileName: "Grade",
                icon: Image.asset("assets/icons/grade.png",height: 24),
              ),
              DrawerTiles(
                tileName: "Attendance",
                icon: Image.asset("assets/icons/attendance_icon.png",height: 24),
              )
            ],
          ),
        )
      )
    );
  }

}

class DrawerTiles extends StatelessWidget {
  final String tileName;
  final icon;
  const DrawerTiles({super.key,required this.tileName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 2.5),
      child: TextButton(
        onPressed: () {},
        child: Container(
          alignment: const Alignment(0, 0),
          width: double.infinity,
          height: 50,
          // decoration: BoxDecoration(
          //   border: Border.all(),
          //   borderRadius: BorderRadius.circular(15)
          // ),
          child: Row(
            children: [
              icon,
              SizedBox(width: 18,),
              Text(
                tileName,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
