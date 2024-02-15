

import 'package:examen_final_camps/providers/local_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//pagina de login

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalUserProvider localUserProvider = Provider.of<LocalUserProvider>(context, listen: false);

    //si s'ha guardat un usuari, es redirigeix a la home
    if (localUserProvider.nomUsuari != '') {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    }

    //si no s'ha guardat un usuari, es mostra el formulari
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: _UserForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          localUserProvider.save();
          Navigator.of(context).pushReplacementNamed('/home');
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

//formulari de login
class _UserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalUserProvider localUserProvider = Provider.of<LocalUserProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: localUserProvider.nomUsuari,
                onChanged: (value) => localUserProvider.nomUsuari = value,
                validator: (value) {
                  if (value == null || value.length < 5)
                    return 'El nom és massa curt';
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
                initialValue: '${localUserProvider.contrassenya}',
                onChanged: (value) {
                  localUserProvider.contrassenya = value;
                },
                validator: (value) {
                  if (value == null || value.length < 8)
                    return 'la contraseña es massa curta minim 8';
                },
                decoration: InputDecoration(
                  labelText: 'Contrasenya',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
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
