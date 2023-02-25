import 'dart:convert';
import 'dart:developer';
import 'package:biblioteca_movil/utiles/Urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biblioteca_movil/utiles/Urls.dart';

class ListarLibrosView extends StatefulWidget {
  const ListarLibrosView({Key? key}) : super(key: key);

  @override
  _ListarLibrosViewState createState() => _ListarLibrosViewState();
}

class _ListarLibrosViewState extends State<ListarLibrosView> {
  late List<dynamic> _libros = [];
  String baseUrl = base;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final urlingresar = Uri.parse(base + 'libros');
    final token = await obtenerToken();
    final url = (urlingresar);
    final headers = {
      'Authorization': token,
    };
    final response = await http.get(
      url,
      headers: headers,
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        _libros = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Libros"),
      ),
      body: _libros.isEmpty // Comprobar si la lista está vacía en lugar de nula
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Editorial')),
                    DataColumn(label: Text('Código')),
                    DataColumn(label: Text('ISBN')),
                    DataColumn(label: Text('Edición')),
                    DataColumn(label: Text('Título')),
                    DataColumn(label: Text('Autores')),
                    DataColumn(label: Text('Año')),
                  ],
                  rows: _libros
                      .map(
                        (libro) => DataRow(cells: [
                          DataCell(Text(libro['editorial'] ?? '')),
                          DataCell(Text(libro['codigo'] ?? '')),
                          DataCell(Text(libro['isbn'] ?? '')),
                          DataCell(Text(libro['edision'] ?? '')),
                          DataCell(Text(libro['titulo'] ?? '')),
                          DataCell(Text(libro['autores'] ?? '')),
                          DataCell(Text(libro['anio'].toString() ?? '')),
                        ]),
                      )
                      .toList(),
                  dividerThickness: 1,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.yellow[200]!),
                  dataRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue),
                  dataRowHeight: 60,
                  headingTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  dataTextStyle: TextStyle(fontSize: 13),
                ),
              ),
            ),
    );
  }
}
