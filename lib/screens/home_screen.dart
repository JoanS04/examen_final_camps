
import 'package:examen_final_camps/models/tree.dart';
import 'package:examen_final_camps/providers/local_user_provider.dart';
import 'package:examen_final_camps/providers/tree_provider.dart';
import 'package:examen_final_camps/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TreeService treeService = Provider.of<TreeService>(context);
    

    List<Tree> usuaris = treeService.trees;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_queue),
            onPressed: () {
              Provider.of<LocalUserProvider>(context, listen: false).clean();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      ),
      body: usuaris.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: usuaris.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: GestureDetector(
                    child: UserCard(usuari: usuaris[index]),
                    onTap: () {
                      treeService.tempTree = usuaris[index].copy();
                      Navigator.of(context).pushNamed('detail');
                    },
                  ),
                  onDismissed: (direction) {
                    if (usuaris.length < 2) {
                      treeService.loadUsers();
                      // userService.loadUsers();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('No es pot esborrar tots els elements!')));
                    } else {
                      // treeService.deleteUser(usuaris[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${usuaris[index].nom} esborrat')));
                    }
                  },
                );
              }),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // scanListProvider.nouScan(User(address: "address", email: "email", name: "name", phone: "phone", photo: "photo"));
          treeService.tempTree = Tree(nom: '', varietat: '', tipus: '', autocton: false, foto: '', detall: '');
          Navigator.of(context).pushNamed('detail');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}