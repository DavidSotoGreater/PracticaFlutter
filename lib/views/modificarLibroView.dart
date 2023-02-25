import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:biblioteca_movil/utiles/Urls.dart';

class GuardarLibroView extends StatefulWidget {
  @override
  _GuardarLibroViewState createState() => _GuardarLibroViewState();
}

class _GuardarLibroViewState extends State<GuardarLibroView> {
  final _formKey = GlobalKey<FormState>();
  final _externalController = TextEditingController();
  final _autorController = TextEditingController();
  final _tituloController = TextEditingController();
  final _numPagController = TextEditingController();
  final _anioController = TextEditingController();
  final _editorialController = TextEditingController();
  final _edisionController = TextEditingController();
  final _isbnController = TextEditingController();

  Future<String?> obtenerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> guardarLibro() async {
    final baseUrl = base;
    final urlingresar = Uri.parse(base + 'libros/editar');
    final token = await obtenerToken();
    final url = (urlingresar);

    final body = {
      'external': _externalController.text,
      'autor': _autorController.text,
      'titulo': _tituloController.text,
      'numPag': _numPagController.text,
      'anio': _anioController.text,
      'editorial': _editorialController.text,
      'edision': _edisionController.text,
      'isbn': _isbnController.text,
    };

    log(Uri.parse(base + 'libros/editar').toString());
    final headers = {
      'Authorization': token!,
      'Content-Type': 'application/json',
    };

    log(json.encode(body));
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    //log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final evento = json.decode(response.body)['data']['evento'];
      if (evento == "Se ha modificado correctamente") {
        log("El objeto se ha modificado correctamente");
        final message = json.decode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        _externalController.clear();
        _autorController.clear();
        _tituloController.clear();
        _numPagController.clear();
        _anioController.clear();
        _editorialController.clear();
        _edisionController.clear();
        _isbnController.clear();
      } else if (evento == "Objeto no encontrado") {
        log("No se encontró el objeto deseado");
        final message = json.decode(response.body)['data']['evento'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } else {
      final message = json.decode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _externalController.dispose();
    _autorController.dispose();
    _tituloController.dispose();
    _numPagController.dispose();
    _anioController.dispose();
    _editorialController.dispose();
    _edisionController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardar Libro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _externalController,
                  decoration: InputDecoration(
                    labelText: 'id',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _autorController,
                  decoration: InputDecoration(
                    labelText: 'Autor',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numPagController,
                  decoration: InputDecoration(
                    labelText: 'numero de paginas',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Debe ingresar un número entero.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _anioController,
                  decoration: InputDecoration(
                    labelText: 'Año',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    if (int.tryParse(value) == null) {
                      return 'El valor ingresado debe ser un número entero.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _editorialController,
                  decoration: InputDecoration(
                    labelText: 'editorial',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edisionController,
                  decoration: InputDecoration(
                    labelText: 'Edisión',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _isbnController,
                  decoration: InputDecoration(
                    labelText: 'ISBN',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      guardarLibro();
                    }
                  },
                  child: Text('Guardar modificacion'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
