import 'package:flutter/material.dart';

class RegisterPersonView extends StatefulWidget {
  @override
  _RegisterPersonViewState createState() => _RegisterPersonViewState();
}

class _RegisterPersonViewState extends State<RegisterPersonView> {
  late final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _lastName = "";
  String _address = "";
  String _identification = "";
  String _phone = "";
  String _idType = "";
  int _roleId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar persona'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombres'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => _name = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un apellido';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una dirección';
                  }
                  return null;
                },
                onSaved: (value) => _address = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Identificación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una identificación';
                  }
                  return null;
                },
                onSaved: (value) => _identification = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un teléfono';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value ?? '',
              ),
              TextFormField(
                decoration:
                InputDecoration(labelText: 'Tipo de identificación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un tipo de identificación';
                  }
                  return null;
                },
                onSaved: (value) => _idType = value ?? '',
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Rol'),
                value: _roleId,
                items: [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Rol 1')
                  )
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecciona un rol';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _roleId = value ?? 0),
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState?.save();

                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
