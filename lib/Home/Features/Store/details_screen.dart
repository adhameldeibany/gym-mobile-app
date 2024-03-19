import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flockergym/Methods/BackendMethods/Backend.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/StoreItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

  late StoreItem item;
class DetailsScreen extends StatefulWidget {

  DetailsScreen({required StoreItem storeItem}){
    item = storeItem;
  }

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var selectedCard = 'WEIGHT';
  int items = 1;
  double total = double.parse(item.price);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        backgroundColor: darkgrey,
        body: ListView(
            children: [
              SingleChildScrollView(
                child: Stack(
                    children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent),
                  Positioned(
                      top: 75.0,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.0),
                                topRight: Radius.circular(45.0),
                              ),
                              color: Colors.white
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Container(
                        height: 200.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(item.imgurl),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 250.h,
                      left: 25.w,
                      right: 25.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.name,
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(item.price,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.grey
                                  ),
                              ),
                              Container(height: 25.h, color: Colors.grey, width: 1.w),
                              Container(
                                width: 140.w,
                                height: 45.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17.0),
                                    color: lightyellow
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (items !=1) {
                                              items--;
                                              total -= double.parse(item.price);
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7.0),
                                              color: darkgrey,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: lightyellow,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(items.toString(),
                                        style: TextStyle(
                                            color: darkgrey,
                                            fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                              items++;
                                              total += double.parse(item.price);
                                          });
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7.0),
                                              color: darkgrey,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: lightyellow,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Container(
                              height: 150.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  item.type !="clothes"?_buildInfoCard('WEIGHT', item.weight.substring(0,item.weight.length-3), 'Gm')
                                      :
                                  _buildInfoCard('MATERIAL', item.weight.substring(0,item.weight.length-3),""),
                                  SizedBox(width: 10.0),
                                  item.type !="clothes"?_buildInfoCard('CALORIES', item.calories.substring(0,item.calories.length-3), 'CAL')
                                      :
                                  _buildInfoCard('Color', "Black",""),
                                  SizedBox(width: 10.0),
                                  item.type !="clothes"?_buildInfoCard('Protien', item.vitamins.substring(0,item.vitamins.length-3), 'Gm')
                                      :
                                  _buildInfoCard('Size', "One Size",""),
                                ],
                              )
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Container(
                                          height: 150.h,
                                          width: 350.w,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('You want to buy this item ?',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: darkgrey),
                                              ),
                                              SizedBox(height: 30.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height: 30.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: lightyellow),
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      child: Center(child: Text('Cancel', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                      height: 30.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                        color: lightyellow,
                                                        border: Border.all(color: lightyellow),
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      child: Center(child: Text('Buy', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                                                    ),
                                                    onTap: () async{
                                                      await BackendService().shopitem(item,items);
                                                      final snackBar = SnackBar(
                                                        duration: Duration(milliseconds: 1500,),
                                                        elevation: 0,
                                                        behavior: SnackBarBehavior.floating,
                                                        backgroundColor: Colors.transparent,
                                                        content: AwesomeSnackbarContent(
                                                          title: 'Success',
                                                          message: 'Order Successfully',
                                                          contentType: ContentType.success,
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(snackBar);
                                                      Navigator.pop(context);
                                                      // copied successfully
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  );
                                },
                                child: Container(
                                  width: 150.w,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    color: lightyellow,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Buy',
                                        style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5.w,),
                                      Icon(Icons.shopping_cart, color: darkgrey, size: 22,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),
                ]
                ),
              )
            ])),
        onWillPop: ()async{
          context.go('/home/Store');
          return false;
        });
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? darkgrey : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard ?
                  Colors.transparent :
                  Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75
              ),

            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontSize: 12.0,
                          color:
                          cardTitle == selectedCard ? Colors.white : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            ),
                        ),
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
