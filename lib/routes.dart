import 'package:flutter/material.dart';
import 'package:gaphql_example/main.dart';
import 'package:gaphql_example/ui/views/setup/bio.dart';
import 'package:gaphql_example/ui/views/setup/profile_photo.dart';

var appRoutes = <String, WidgetBuilder>{
  //FirstScreen
  // '/': (ctx) => const MyHomePage(),
  //Setup
  BioScreen.routeName: (ctx) => const BioScreen(),
  EditPPScreen.routeName: (ctx) => const EditPPScreen(),
};
