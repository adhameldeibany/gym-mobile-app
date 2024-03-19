import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/KCalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  List<String> meals = ['1 meal', '2 meals', '3 meals', '4 meals'];
  List<String> cals = ['250 calories', '500 calories', '750 calories', '1000 calories', '1250 calories', '1500 calories'];
  String selected = '3 meals';
  String calsselc = '1000 calories';

  late List<String>ListChoosing;

  DatabaseReference ref = FirebaseDatabase.instance.ref("foodplan/");
  late List<KcalModel> kcalmodels;

  bool _isAnythingSelected = false;
  bool _isvegSelected = false;
  bool _isMedSelected = false;
  bool _isPaleoSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      appBar: AppBar(
        backgroundColor: darkgrey,
        title: Text('Kcal Calculate', style: TextStyle(color: lightyellow),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          kcalmodels = [];
          ListChoosing = [];
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            kcalmodels.clear();
            final kcals = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            kcals.forEach((key, value) {
              final kcalelement = Map<String, dynamic>.from(value);
              var kmodel = KcalModel(
                  calories: kcalelement['calories'],
                  carbs: kcalelement['carbs'],
                  description: kcalelement['description'],
                  fat: kcalelement['fat'],
                  id: kcalelement['id'],
                  imgurl: kcalelement['imgurl'],
                  link: kcalelement['link'],
                  name: kcalelement['name'],
                  preptime: kcalelement['preptime'],
                  protien: kcalelement['protien'],
                  type: kcalelement['type']);
              kcalmodels.add(kmodel);
              ListChoosing.add(kmodel.id.toString());
            });
            return Scaffold(
              backgroundColor: darkgrey,
              body: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 20.0,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Let us know your diet',
                          style: TextStyle(
                            color: lightyellow,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 340.h,
                          child: GridView(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                            ),
                            children: <Widget>[
                              Container(
                                child: FoodTypeCard(
                                  image: 'assets/sandwich.png',
                                  title: 'Anything',
                                  isSelected: _isAnythingSelected,
                                  onPress: () {
                                    setState(() {
                                      _isAnythingSelected = !_isAnythingSelected;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: FoodTypeCard(
                                  image: 'assets/diet.png',
                                  title: 'Vegetarian',
                                  isSelected: _isvegSelected,
                                  onPress: () {
                                    setState(() {
                                      _isvegSelected = !_isvegSelected;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: FoodTypeCard(
                                  image: 'assets/bruschetta.png',
                                  title: 'Meditarranean',
                                  isSelected: _isMedSelected,
                                  onPress: () {
                                    setState(() {
                                      _isMedSelected = !_isMedSelected;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: FoodTypeCard(
                                  image: 'assets/turkey.png',
                                  title: 'Paleo',
                                  isSelected: _isPaleoSelected,
                                  onPress: () {
                                    setState(() {
                                      _isPaleoSelected = !_isPaleoSelected;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'I want to eat',
                              style: TextStyle(
                                color: lightyellow,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 4.0,
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox.shrink(),
                                  value: calsselc,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      calsselc = value!;
                                    });
                                  },
                                  items: cals.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              'in how many meals ?',
                              style: TextStyle(
                                color: lightyellow,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 4.0,
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox.shrink(),
                                  value: selected,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      selected = value!;
                                    });
                                  },
                                  items: meals.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(right: 30.0, left: 30.0, bottom: 20.0),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  color: lightyellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    // if (_isAnythingSelected) {
                    //
                    // }else if(_isvegSelected) {
                    //
                    // }else if(_isMedSelected){
                    //
                    // }else if (_isPaleoSelected) {
                    //
                    // }

                    // List<String> cals = ['250 calories', '500 calories', '750 calories', '1000 calories', '1250 calories', '1500 calories'];
                    // String calsselc = '1000 calories';

                    if (selected == '1 meal') {
                      if (calsselc == '250 calories') {
                        print('254 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                      }else if (calsselc == '500 calories') {
                        print('497 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg22')].name.toString());
                      }else if (calsselc == '750 calories') {
                        print('746 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg21')].name.toString());
                      }else if (calsselc == '1000 calories') {
                        print('970 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg23')].name.toString());
                      }else if (calsselc == '1250 calories') {
                        print('1278 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg17')].name.toString());
                      }else if (calsselc == '1500 calories') {
                        print('1458 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg20')].name.toString());
                      }
                    }
                    else if (selected == '2 meals') {
                      if (calsselc == '250 calories') {
                        print('258 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg5')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg6')].name.toString());
                      }else if (calsselc == '500 calories') {
                        print('512 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg3')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                      }else if (calsselc == '750 calories') {
                        print('758 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg18')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg19')].name.toString());
                      }else if (calsselc == '1000 calories') {
                        print('1000 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg21')].name.toString());
                      }else if (calsselc == '1250 calories') {
                        print('1255 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg23')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg11')].name.toString());
                      }else if (calsselc == '1500 calories') {
                        print('1504 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg1')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg17')].name.toString());
                      }
                    }
                    else if (selected == '3 meals') {
                      if (calsselc == '250 calories') {
                        print('271 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg6')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg14')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg15')].name.toString());
                      }else if (calsselc == '500 calories') {
                        print('510 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg14')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg7')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                      }else if (calsselc == '750 calories') {
                        print('789 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg12')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg13')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                      }else if (calsselc == '1000 calories') {
                        print('1008 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg18')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg19')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg13')].name.toString());
                      }else if (calsselc == '1250 calories') {
                        print('1255 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg22')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg18')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg19')].name.toString());
                      }else if (calsselc == '1500 calories') {
                        print('1504 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg21')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg18')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg19')].name.toString());
                      }
                    }
                    else if (selected == '4 meals') {
                      if (calsselc == '250 calories') {
                        print('286 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg6')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg14')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg15')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg16')].name.toString());
                      }else if (calsselc == '500 calories') {
                        print('515 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg2')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg6')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg10')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg14')].name.toString());
                      }else if (calsselc == '750 calories') {
                        print('754 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg3')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg9')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg14')].name.toString());
                      }else if (calsselc == '1000 calories') {
                        print('1008 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg11')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg12')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg4')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg5')].name.toString());
                      }else if (calsselc == '1250 calories') {
                        print('1253 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg18')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg19')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg11')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg8')].name.toString());
                      }else if (calsselc == '1500 calories') {
                        print('1511 calories');
                        print(kcalmodels[ListChoosing.indexOf('veg23')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg14')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg11')].name.toString());
                        print(kcalmodels[ListChoosing.indexOf('veg7')].name.toString());
                      }
                    }

                  },
                  child: Text(
                    'Generate',
                    style: TextStyle(
                      color: darkgrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
            );
          }else{
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Lottie.asset('assets/gym.json'),
              ),
            );
          }
        },
      )
    );
  }
}

class FoodTypeCard extends StatelessWidget {
  const FoodTypeCard({required this.image, required this.title, required this.isSelected, required this.onPress});

  final String image;
  final String title;
  final bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPress();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF83D6C1) : Colors.grey[200],
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 10.0,
              top: 10.0,
              child: isSelected
                  ? Icon(
                Icons.check_circle_outline,
                color: Colors.black.withOpacity(0.2),
              )
                  : SizedBox.shrink(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image(
                    image: AssetImage(
                      image,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color:
                      isSelected ? Colors.blueGrey[800] : Colors.grey[500],
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
