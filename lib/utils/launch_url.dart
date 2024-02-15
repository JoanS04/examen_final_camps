import 'package:examen_final_camps/models/tree.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, Tree tree) async{
  if(!await launch(tree.detall)) throw 'Could not launch ${tree.detall}';
}