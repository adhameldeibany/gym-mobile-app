import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/NotificationModel.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

enum Actions {delete}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

DatabaseReference ref = FirebaseDatabase.instance.ref("notifications/"+FirebaseAuth.instance.currentUser!.uid+"/");

class _NotificationsScreenState extends State<NotificationsScreen> {

  bool x = false;
  bool y = false;
  bool z = true;
  List<NotificationModel> storeitems = [];
  List<NotificationModel> allitems = [];
  List<NotificationModel> _searchval = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Updates",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: (){
                context.go('/home/Profile');
              },
              child: Container(
                width: 40.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: darkgrey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(prefs.getString('imgurl').toString()),
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 12),
          //   child: IconButton(
          //       onPressed: (){
          //         context.go('/home/Profile');
          //       },
          //       icon: Icon(Icons.notifications_active_outlined, color: darkgrey, size: 35,),
          //   ),
          // )
        ],
      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value !=  null) {
            storeitems.clear();
            allitems.clear();
            final storeitem = Map<dynamic, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>);
            storeitem.forEach((key, value) {
              final storeelement = Map<String, dynamic>.from(value);
              storeitems.add(
                NotificationModel(
                    id: storeelement['id'],
                    uid: storeelement['uid'],
                    state: storeelement['state'],
                    title: storeelement['title'],
                    subtitle: storeelement['subtitle'],
                    time: storeelement['time'],
                )
              );
            });
            allitems.addAll(storeitems);
            return Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (x == false) {
                              x = true;
                              y = false;
                              z = false;
                              filter("new");
                            } else if (x == true) {
                              x = false;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                              color: x ? lightyellow : Colors.black,
                              border: Border.all(color: silverdark)),
                          child: Center(
                              child: Text(
                                'New',
                                style: TextStyle(
                                    color: x ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (y == false) {
                              y = true;
                              x = false;
                              z = false;
                              filter("event");
                            } else if (y == true) {
                              y = false;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              color: y ? lightyellow : Colors.black,
                              border: Border.all(color: silverdark)),
                          child: Center(
                              child: Text(
                                'Events',
                                style: TextStyle(
                                    color: y ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (z == false) {
                              z = true;
                              x = false;
                              y = false;
                              filter("");
                            } else if (z == true) {
                              z = false;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                              color: z ? lightyellow : Colors.black,
                              border: Border.all(color: silverdark)),
                          child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                    color: z ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ]
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: _searchval.length != 0?ListView.builder(
                      itemCount: _searchval.length,
                      itemBuilder: (context, index) {
                        final notification = _searchval[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: BehindMotion(),
                            dismissible: DismissiblePane(onDismissed: () => _onDismissed(index, Actions.delete),),
                            children: [
                              SlidableAction(
                                onPressed: (context) => _onDismissed(index, Actions.delete),
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Card(
                              color: Color(0xFF191919),
                              shadowColor: silverdark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.circle, color: notification.state=="new" ? lightyellow : silverdark, size: 15,),
                                        SizedBox(width: 5.w,),
                                        Text(notification.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(notification.time,
                                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(notification.subtitle,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(color: lightyellow),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ):ListView.builder(
                      itemCount: storeitems.length,
                      itemBuilder: (context, index) {
                        final notification = storeitems[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: BehindMotion(),
                            dismissible: DismissiblePane(onDismissed: () => _onDismissed(index, Actions.delete),),
                            children: [
                              SlidableAction(
                                onPressed: (context) => _onDismissed(index, Actions.delete),
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Card(
                              color: Color(0xFF191919),
                              shadowColor: silverdark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.circle, color: notification.state=="new" ? lightyellow : silverdark, size: 15,),
                                        SizedBox(width: 5.w,),
                                        Text(notification.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(notification.time,
                                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(notification.subtitle,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(color: lightyellow),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          }
          else if (!snapshot.hasData && snapshot.data == null){
            storeitems.clear();
            allitems.clear();
            return Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (x == false) {
                              x = true;
                              y = false;
                              z = false;
                              filter("new");
                            } else if (x == true) {
                              x = false;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                              color: x ? lightyellow : Colors.black,
                              border: Border.all(color: silverdark)),
                          child: Center(
                              child: Text(
                                'New',
                                style: TextStyle(
                                    color: x ? Colors.black : silverdark,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (y == false) {
                              y = true;
                              x = false;
                              z = false;
                              filter("event");
                            } else if (y == true) {
                              y = false;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              color: y ? lightyellow : Colors.black,
                              border: Border.all(color: silverdark)),
                          child: Center(
                              child: Text(
                                'Events',
                                style: TextStyle(
                                    color: y ? Colors.black : silverdark,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (z == false) {
                              z = true;
                              x = false;
                              y = false;
                              filter("");
                            } else if (z == true) {
                              z = false;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                              color: z ? lightyellow : Colors.black,
                              border: Border.all(color: silverdark)),
                          child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                    color: z ? Colors.black : silverdark,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ]
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: _searchval.length != 0?ListView.builder(
                      itemCount: _searchval.length,
                      itemBuilder: (context, index) {
                        final notification = _searchval[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: BehindMotion(),
                            dismissible: DismissiblePane(onDismissed: () => _onDismissed(index, Actions.delete),),
                            children: [
                              SlidableAction(
                                onPressed: (context) => _onDismissed(index, Actions.delete),
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Card(
                              color: Colors.black,
                              shadowColor: silverdark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.circle, color: notification.state=="new" ? lightyellow : silverdark, size: 15,),
                                        SizedBox(width: 5.w,),
                                        Text(notification.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(notification.time,
                                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(notification.subtitle,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(color: lightyellow),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ):ListView.builder(
                      itemCount: storeitems.length,
                      itemBuilder: (context, index) {
                        final notification = storeitems[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: BehindMotion(),
                            dismissible: DismissiblePane(onDismissed: () => _onDismissed(index, Actions.delete),),
                            children: [
                              SlidableAction(
                                onPressed: (context) => _onDismissed(index, Actions.delete),
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Card(
                              color: darkgrey,
                              shadowColor: silverdark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.circle, color: notification.state=="new" ? lightyellow : silverdark, size: 15,),
                                        SizedBox(width: 5.w,),
                                        Text(notification.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Text(notification.time,
                                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(notification.subtitle,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(color: lightyellow),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          }
          else{
            return LoadingScreen();
          }
        },
      ),
    );

  }
  void _onDismissed(int index, Actions action){}
  filter(String text) async {
    _searchval.clear();
    if (text.trim().toString().length == 0) {
      setState(() {});
    }else{
      allitems.forEach((service) {
        if (service.state.toLowerCase().contains(text.toLowerCase()))
          _searchval.add(service);
      });
    }


    setState(() {
    });
  }
}
