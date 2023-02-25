import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:biblioteca_movil/utiles/conexionWS.dart';
import 'package:biblioteca_movil/utiles/conexionWS.dart';

class BusquedaView extends StatefulWidget {
  @override
  _BusquedaViewState createState() => _BusquedaViewState();
}

class _BusquedaViewState extends State<BusquedaView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerTitulo = TextEditingController();
  final TextEditingController _controllerAutor = TextEditingController();
  final TextEditingController _controllerEditorial = TextEditingController();
  final TextEditingController _controllerISBN = TextEditingController();

  bool _isLoading = false;
  List<dynamic> _libros = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Búsqueda"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _controllerTitulo,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextFormField(
                controller: _controllerAutor,
                decoration: InputDecoration(labelText: 'Autor'),
              ),
              TextFormField(
                controller: _controllerEditorial,
                decoration: InputDecoration(labelText: 'Editorial'),
              ),
              TextFormField(
                controller: _controllerISBN,
                decoration: InputDecoration(labelText: 'ISBN'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _buscarLibros,
                child: _isLoading ? CircularProgressIndicator() : Text('Buscar'),
              ),

              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _libros.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_libros[index]['titulo']),
                      subtitle: Text(_libros[index]['autor']),
                      trailing: Text(_libros[index]['isbn']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buscarLibros() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _libros = [];
      });
      Map<String, dynamic> data = {
        'titulo': _controllerTitulo.text,
        'autor': _controllerAutor.text,
        'editorial': _controllerEditorial.text,
        'isbn': _controllerISBN.text,
      };
      try {
        final response = await ConexionWS().solicitudPost('libros/buscar', data, ConexionWS.NO_TOKEN);
        if (response.code == 200) {
          setState(() {
            _libros = response.data;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message)));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error de conexión')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
