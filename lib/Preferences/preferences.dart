import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _prefs;

  static String _nomUsuari = '';
  static String _contrassenya = '';
  static bool _recordar = false;

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  

  static String get nomUsuari{
    return _prefs.getString('nomUsuari') ?? _nomUsuari;
  }

  static set nomUsuari(String value){
    _nomUsuari = value;
    _prefs.setString('nomUsuari', _nomUsuari);
    print('nomUsuari: ' + value);
    print(_prefs.getString('nomUsuari'));
  }

  static String get contrassenya{
    return _prefs.getString('contrassenya') ?? _contrassenya;
  }

  static set contrassenya(String value){
    _contrassenya = value;
    _prefs.setString('contrassenya', _contrassenya);
  }

  static bool get recordar{
    return _prefs.getBool('recordar') ?? _recordar;
  }
  
  static set recordar(bool value){
    _recordar = value;
    _prefs.setBool('recordar', _recordar);
  }
}