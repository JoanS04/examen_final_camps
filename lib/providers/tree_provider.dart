import 'dart:convert';
import 'package:examen_final_camps/models/tree.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//calsse per obtenir la llista de trees de la base de dades

class TreeService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String _baseUrl =
      "practica-examen-abafc-default-rtdb.europe-west1.firebasedatabase.app";
  List<Tree> trees = [];
  late Tree tempTree;
  Tree? newTree;

  TreeService() {
    this.loadUsers();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //obtenim la llista d'arbres
  loadUsers() async {
    trees.clear();
    final url = Uri.https(_baseUrl, 'trees.json');
    final response = await http.get(url);
    final Map<String, dynamic> usersMap = json.decode(response.body) ?? {};

    // Mapejam la resposta del servidor, per cada arbre, el convertim a la classe i l'afegim a la llista
    usersMap.forEach((key, value) {
      final auxUser = Tree.fromMap(value);
      auxUser.id = key;
      trees.add(auxUser);
    });

    trees.forEach((element) {
      print(element.id);
    });

    notifyListeners();
  }

  //depenent de si l'usuari existeix o no, cridam a la funció per crear o actualitzar l'arbre
  Future saveOrCreateUser() async {
    if (tempTree.id == null) {
      //Cream l'usuari
      await this.createUser();
    } else {
      //Actualitzam l'usuari
      await this.updateUser();
    }
    loadUsers();
  }

  //funció per actualitzar l'arbre
  updateUser() async {
    final url = Uri.https(_baseUrl, 'trees/${tempTree.id}.json');
    final response = await http.put(url, body: tempTree.toJson());
    final decodedData = response.body;
  }

  //funció per crear l'arbre
  createUser() async {
    print(tempTree.toJson());
    final url = Uri.https(_baseUrl, 'trees.json');
    final response = await http.post(url, body: tempTree.toJson());
    final decodedData = json.decode(response.body);
    print(decodedData);
  }

  //funció per eliminar l'arbre
  deleteUser(Tree tree) async {
    final url = Uri.https(_baseUrl, 'trees/${tree.id}.json');
    final response = await http.delete(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    loadUsers();
  }

  //funció per canviar 'autocton' de l'arbre
  updateBoolean() {
    tempTree.autocton = !tempTree.autocton;
    notifyListeners();
  }

  
}
