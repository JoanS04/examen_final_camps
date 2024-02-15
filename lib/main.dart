import 'package:examen_final_camps/preferences.dart';
import 'package:examen_final_camps/providers/local_user_provider.dart';
import 'package:examen_final_camps/providers/tree_provider.dart';
import 'package:examen_final_camps/screens/detail_screen.dart';
import 'package:examen_final_camps/screens/home_screen.dart';
import 'package:examen_final_camps/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LocalUserProvider(Preferences.nomUsuari, Preferences.contrassenya, Preferences.recordar)),
      ChangeNotifierProvider(create: (_) => TreeService()),
        
    ],
    child: MyApp()));
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginScreen(),
        '/home': (_) => const HomeScreen(),
        'detail': (_) => DetailScreen(),
      },
    );
  }
}