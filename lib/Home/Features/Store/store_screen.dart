import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/StoreItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

DatabaseReference ref = FirebaseDatabase.instance.ref("shop/");

List<StoreItem> storeitems = [];
List<StoreItem> allitems = [];
List<StoreItem> _searchval = [];
TextEditingController controller = new TextEditingController();


class _StoreScreenState extends State<StoreScreen> {

  bool x = false;
  bool y = false;
  bool z = false;
  bool _isTap = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: darkgrey,
        appBar: AppBar(
        backgroundColor: darkgrey,
        elevation: 0,
        title: Text('STORE', style: TextStyle(color: lightyellow),),
        centerTitle: true,
      ),
        body: StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              allitems.clear();
              storeitems.clear();
              if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value !=  null) {
                final storeitem = Map<dynamic, dynamic>.from(
                    (snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>);
                storeitem.forEach((key, value) {
                  final storeelement = Map<String, dynamic>.from(value);
                  storeitems.add(
                      StoreItem(
                          name: storeelement['name'],
                          id: storeelement['id'],
                          imgurl: storeelement['imgurl'],
                          price: storeelement['price'],
                          weight: storeelement['weight'],
                          calories: storeelement['calories'],
                          vitamins: storeelement['vitamins'],
                          type: storeelement['type']
                      )
                  );
                  if (_isTap) storeitems.sort((a, b) => a.name.compareTo(b.name));
                  if (_isTap){
                    _searchval.sort((a, b) => a.name.compareTo(b.name));
                  }else{
                    _searchval.sort((a, b) => b.name.compareTo(a.name));
                  };
                });
                allitems.addAll(storeitems);
                return ListView(
                  children: <Widget>[
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (x == false) {
                                    x = true;
                                    y = false;
                                    z = false;
                                    onSearchTextChanged("food");
                                  } else if (x == true) {
                                    x = false;
                                    onSearchTextChanged("");
                                  }
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: x ? lightyellow : Colors.grey,
                                    border: Border.all(color: silverdark)),
                                child: Center(
                                    child: Text(
                                      'Food',
                                      style: TextStyle(
                                          color: x ? darkgrey : darkgrey,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (y == false) {
                                    y = true;
                                    x = false;
                                    z = false;
                                    onSearchTextChanged("Supplements");
                                  } else if (y == true) {
                                    onSearchTextChanged("");
                                    y = false;
                                  }
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: y ? lightyellow : Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: silverdark)),
                                child: Center(
                                    child: Text(
                                      'Supplements',
                                      style: TextStyle(
                                          color: y ? darkgrey : darkgrey,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (z == false) {
                                    z = true;
                                    x = false;
                                    y = false;
                                    onSearchTextChanged("Clothes");
                                  } else if (z == true) {
                                    z = false;
                                    onSearchTextChanged("");
                                  }
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: z ? lightyellow : Colors.grey,
                                    border: Border.all(color: silverdark)),
                                child: Center(
                                    child: Text(
                                      'Clothes',
                                      style: TextStyle(
                                          color: z ? darkgrey : darkgrey,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ]
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.h,
                            width: 280.w,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Center(
                                child: TextFormField(
                                  controller: controller,
                                  onChanged: onSearchTextChanged,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: lightyellow,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  _isTap =!_isTap;
                                });
                              },
                              icon: Icon(_isTap? FontAwesomeIcons.sortAmountDown : FontAwesomeIcons.sortAmountUp, color: _isTap? lightyellow : lightyellow, size: 25,)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      height: MediaQuery.of(context).size.height - 185.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: _searchval.length != 0 || controller.text.isNotEmpty?ListView.builder(
                                itemCount: _searchval.length,
                                itemBuilder: (context, index) {
                                  final item = _searchval[index];
                                  return InkWell(
                                    onTap: () {
                                      context.go('/home/Details',extra: item);
                                    },
                                    child: Card(
                                      color: darkgrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 7,
                                      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image(
                                                  width: 100.w,
                                                  height: 100.h,
                                                  image: NetworkImage(item.imgurl),
                                                ),
                                                SizedBox(width: 5.w,),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(item.name,
                                                              textAlign: TextAlign.start,
                                                              style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      Row(
                                                        children: [
                                                          Text('\E\G\P '+item.price,
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      context.go('/home/Details',extra: item);
                                                    },
                                                    child: Container(
                                                      width: 80.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        color: lightyellow,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('buy',
                                                            style: TextStyle(color: darkgrey, fontSize: 16.sp,fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ) : ListView.builder(
                                itemCount: storeitems.length,
                                itemBuilder: (context, index) {
                                  final item = storeitems[index];
                                  return InkWell(
                                    onTap: () {
                                      context.go('/home/Details',extra: item);
                                    },
                                    child: Card(
                                      color: darkgrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 7,
                                      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image(
                                                  width: 100.w,
                                                  height: 100.h,
                                                  image: NetworkImage(item.imgurl),
                                                ),
                                                SizedBox(width: 5.w,),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(item.name,
                                                              textAlign: TextAlign.start,
                                                              style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      Row(
                                                        children: [
                                                          Text('\E\G\P '+item.price,
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: (){context.go('/home/Details',extra: item);},
                                                    child: Container(
                                                      width: 80.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        color: lightyellow,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('buy',
                                                            style: TextStyle(color: darkgrey, fontSize: 16.sp,fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
              else{
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Lottie.asset('assets/gym.json'),
                  ),
                );
              }
            }
        )
    );
  }

  onSearchTextChanged(String text) async {
    _searchval.clear();
    if (text.trim().toString().length == 0) {
      setState(() {});
    }else{
      allitems.forEach((service) {
        if (service.name.toLowerCase().contains(text.toLowerCase()) || service.type.toLowerCase().contains(text.toLowerCase()))
          _searchval.add(service);
      });
    }


    setState(() {
      controller.text = text;
    });
  }

}