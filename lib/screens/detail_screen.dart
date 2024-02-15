import 'package:examen_final_camps/providers/tree_provider.dart';
import 'package:examen_final_camps/utils/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../ui/input_decorations.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<TreeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: _UserForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userForm.isValidForm()) {
            userForm.saveOrCreateUser();
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _UserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<TreeService>(context);
    final tempUser = userForm.tempTree;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: userForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: tempUser.nom,
                onChanged: (value) => tempUser.nom = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nom és obligatori';
                },
                decoration: InputDecoration(
                  labelText: 'nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${tempUser.varietat}',
                onChanged: (value) {
                  tempUser.varietat = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'varietat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${tempUser.tipus}',
                onChanged: (value) {
                  tempUser.tipus = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'tipus',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text('Autocton'),
              Checkbox(value: tempUser.autocton, onChanged: (_) => userForm.updateBoolean()),
              SizedBox(height: 30),
              tempUser.detall != ""
                  ? ElevatedButton(onPressed: () => launchURL(context, tempUser), child: Text('Coneixne mes'))
                  : TextFormField(
                initialValue: '${tempUser.detall}',
                onChanged: (value) {
                  tempUser.detall = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'detall',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ),
              SizedBox(height: 30),
              tempUser.foto != ""
                  ?
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.network(tempUser.foto.contains('http') ? tempUser.foto : 'https://th.bing.com/th/id/OIG.MxQxUggA0RKmKdTjwAqw'),
                )
                  : TextFormField(
                initialValue: '${tempUser.foto}',
                onChanged: (value) {
                  tempUser.foto = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'URL de la foto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
