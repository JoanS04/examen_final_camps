

import 'package:examen_final_camps/providers/local_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalUserProvider localUserProvider = Provider.of<LocalUserProvider>(context, listen: false);

    if (localUserProvider.nomUsuari != '') {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: _UserForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          localUserProvider.save();
          Navigator.of(context).pushNamed('/home');
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

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
                initialValue: '${localUserProvider.contrassenya}',
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
