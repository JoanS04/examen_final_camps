import 'dart:convert';


//Classe per mapejar la resposta de l'api

class Tree {
    String? id;
    String nom;
    String varietat;
    String tipus;
    bool autocton;
    String foto;
    String detall;

    Tree({
        required this.nom,
        required this.varietat,
        required this.tipus,
        required this.autocton,
        required this.foto,
        required this.detall,
    });

    factory Tree.fromRawJson(String str) => Tree.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Tree.fromJson(String str) => Tree.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tree.fromMap(Map<String, dynamic> json) => Tree(
        nom: json["nom"],
        varietat: json["varietat"],
        tipus: json["tipus"],
        autocton: json["autocton"],
        foto: json["foto"],
        detall: json["detall"],
    
    );

    Map<String, dynamic> toMap() => {
        "nom": nom,
        "varietat": varietat,
        "tipus": tipus,
        "autocton": autocton,
        "foto": foto,
        "detall": detall,
        };

  Tree copy() {
    var tree = Tree(
      nom: this.nom,
      varietat: this.varietat,
      tipus: this.tipus,
      autocton: this.autocton,
      foto: this.foto,
      detall: this.detall,
    );
    tree.id = this.id;
    return tree;
  }
}
