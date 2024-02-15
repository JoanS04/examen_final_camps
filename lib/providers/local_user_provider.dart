
import 'package:examen_final_camps/preferences.dart';
import 'package:flutter/foundation.dart';

class LocalUserProvider with ChangeNotifier {

  String _nomUsuari = '';
  String _contrassenya = '';
  bool _recordar = false;

  LocalUserProvider(this._nomUsuari, this._contrassenya, this._recordar);

  String get nomUsuari => _nomUsuari;
  String get contrassenya => _contrassenya;
  bool get recordar => _recordar;

  set nomUsuari(String value) {
    _nomUsuari = value;
    notifyListeners();
  }

  set contrassenya(String value) {
    _contrassenya = value;
    notifyListeners();
  }

  set recordar(bool value) {
    _recordar = value;
    notifyListeners();
  }

  void save() {
    Preferences.nomUsuari = _nomUsuari;
    Preferences.contrassenya = _contrassenya;
    Preferences.recordar = _recordar;
  }

  void clean() {
    this._nomUsuari = '';
    this._contrassenya = '';
    Preferences.nomUsuari = '';
    Preferences.contrassenya = '';
    Preferences.recordar = false;
    print('cleared');
    notifyListeners();
  }
}