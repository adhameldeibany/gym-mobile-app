import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pedometer/pedometer.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class ChallengeScreen extends StatefulWidget {

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'stopped', _steps = '0';

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkgrey,
        title: Text('Your steps', style: TextStyle(color: lightyellow),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps Taken',
              style: TextStyle(fontSize: 28.sp, color: lightyellow),
            ),
            Text(
              _steps,
              style: TextStyle(fontSize: 60.sp, color: Colors.white),
            ),
            Divider(
              height: 130.h,
              thickness: 1,
              color: lightyellow,
            ),
            Text(
              'Pedestrian Status',
              style: TextStyle(fontSize: 28.sp, color: lightyellow),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                  ? Icons.accessibility_new
                  : Icons.error,
              color: Colors.white,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 25.sp, color: lightyellow)
                    : TextStyle(fontSize: 22.sp, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
