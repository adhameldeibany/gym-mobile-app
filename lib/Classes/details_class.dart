import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/ClassesBack/ClassesMethods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DetailsclassScreen extends StatefulWidget {
  const DetailsclassScreen({super.key});

  @override
  State<DetailsclassScreen> createState() => _DetailsclassScreenState();
}

List<ClassModel> searchval = [];
List<ClassModel> classe = [];
List<ClassModel> allclasse = [];
DatabaseReference ref = FirebaseDatabase.instance.ref("classes/");
TextEditingController searchcontroller = new TextEditingController();
class _DetailsclassScreenState extends State<DetailsclassScreen> {

  Scaffold MakeStream(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
              classe.clear();
              allclasse.clear();
              classes.forEach((key, value) {
                final classelement = Map<String, dynamic>.from(value);
                classe.add(
                    ClassModel(
                      id: classelement['id'],
                      name: classelement['name'],
                      startsat: classelement['startsat'],
                      timesaweek: classelement['timesaweek'],
                      coachid: classelement['coachid'],
                      coachname: classelement['coachname'],
                      daysandtimeandlength: classelement['daysandtimeandlength'],
                      imgurl: classelement['imgurl'],
                    )
                );
                allclasse.add(
                    ClassModel(
                      id: classelement['id'],
                      name: classelement['name'],
                      startsat: classelement['startsat'],
                      timesaweek: classelement['timesaweek'],
                      coachid: classelement['coachid'],
                      coachname: classelement['coachname'],
                      daysandtimeandlength: classelement['daysandtimeandlength'],
                      imgurl: classelement['imgurl'],
                    )
                );
              });
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  leading: BackButton(
                    color: Colors.white,
                  ),
                  title: Text("Classes",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                  ],
                ),
                body: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Center(
                      child: Container(
                        height: 45,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: silverdark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: searchcontroller,
                            onChanged: onSearchTextChanged,
                            style: TextStyle(color: lightyellow),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: searchval.isEmpty?GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 310.h,
                            ),
                            itemCount: allclasse.length,
                            itemBuilder: (_,index){
                              final cls = allclasse[index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      context.go("/Class/offer",extra: cls);
                                    },
                                    child: Card(
                                      elevation: 7,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 100.w,
                                                  child: Text(cls.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 100.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height:120.h,
                                                  width: 141.w,
                                                  child: Image(
                                                    image: NetworkImage(cls.imgurl),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ):GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 310.h,
                            ),
                            itemCount: searchval.length,
                            itemBuilder: (_,index){
                              final cls = searchval[index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      context.go("/Class/offer",extra: cls);
                                    },
                                    child: Card(
                                      elevation: 7,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 100.w,
                                                  child: Text(cls.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 100.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height:120.h,
                                                  width: 141.w,
                                                  child: Image(
                                                    image: NetworkImage(cls.imgurl),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return LoadingScreen();
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MakeStream(context);
  }

  onSearchTextChanged(String text) async {
    searchval.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    allclasse.forEach((service) {
      if (service.name.toLowerCase().contains(text.toLowerCase()))
        searchval.add(service);
    });
    setState(() {
      searchcontroller.text = text;
    });
  }

}
