import 'package:flutter/material.dart';

double Height (BuildContext context, double elementHeight){
  double percent = elementHeight/800;
  return MediaQuery.of(context).size.height*percent;}

double Width (BuildContext context, double elementWidth){
  double percent = elementWidth/360;
  return MediaQuery.of(context).size.width*percent;}
