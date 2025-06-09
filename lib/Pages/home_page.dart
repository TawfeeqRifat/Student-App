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
  int pageIndex = 0;

  final List<Widget> pages = [
    Container(),
    Container(),
    Container(),
  ];

  bool new_notification = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      bottomNavigationBar: NavBar(context),
      body: Builder(
        builder: (context) =>
          ProperSizer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight/18,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: Scaffold.of(context).openDrawer,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            child: Icon(
                              Icons.person,
                              size: 42,
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Welcome,"),
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        const Icon(
                          Icons.notifications_none_rounded,
                          size: 32,
                        ),
                        new_notification ? const Positioned(
                              right: 6,
                              top: 6,
                              child: CircleAvatar(
                                backgroundColor: Color(0xfffed8f7),
                                radius: 4,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 2.5,
                                ),
                              )
                          ) : const SizedBox(),
                      ]
                    )
                  ],
                )

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
              drawerTiles(tileName: "Notifications",icon: Icon(Icons.notifications_none_rounded,size: 24,color: Colors.black,)),
              drawerTiles(
                tileName: "Grade",
                icon: Image.asset("assets/icons/grade.png",height: 24),
              ),
              drawerTiles(
                tileName: "Attendance",
                icon: Image.asset("assets/icons/attendance_icon.png",height: 24),
              )
            ],
          ),
        )
      )
    );
  }

  Container NavBar(BuildContext context){
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon:
            pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon:
            pageIndex == 1
                ? const Icon(
              Icons.widgets,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.widgets_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon:
            pageIndex == 3
                ? const Icon(Icons.person, color: Colors.white, size: 35)
                : const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class drawerTiles extends StatelessWidget {
  final String tileName;
  final icon;
  const drawerTiles({super.key,required this.tileName, required this.icon});

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
