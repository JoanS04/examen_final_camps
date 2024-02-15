
import 'package:examen_final_camps/models/tree.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Tree usuari;
  const UserCard({super.key, required this.usuari});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(usuari.nom)),
      title: Text(usuari.nom),
      subtitle: Text(
        "${usuari.varietat}",
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
    );
  }
}
