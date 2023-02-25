import 'dart:convert';
import 'dart:developer';
import 'Urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Clase que se encarga de realizar la conexión con el servidor a través de HTTP
class ConexionWS {
  final String NAME = "ConexionWS";
  static String NO_TOKEN = "NO_TOKEN";

  // Función para realizar una solicitud HTTP de tipo POSt
  //dir_recurso es el recurso al que se desea acceder
  //data son los datos que se deseann enviar al servidor
  //token es el token de autenticacion, si existe.
  Future<RespuestaGenerica> solicitudPost(String dir_recurso,
      Map<dynamic, dynamic> data,
      String token) async {
    log("${this.NAME}:solicitudPost");
    Map<String, String> _header = {'Content-Type':'application/json'};
    if(token != NO_TOKEN) {
      _header = {'Content-Type':'application/json', 'Authorization':token};
    }
    final String url = base + dir_recurso;
    final uri = Uri.parse(url);
    try{
      final response = await http.post(uri, headers: _header, body: jsonEncode(data));
      if(response.statusCode != 200) {
        //log('Error ${response.body}');
        //ssi la respuesta del servidor no es 200, se retorna un objeto respuesta generico
        //con el codigo de respuesta, el cuerpo, y un mensaje de error
        return _respuestaJson(response.statusCode, response.body, "Hubo un error de validacion o no esta authorizado");
      } else {
        //sino, si es 200, se retornara un objeto con los mismos datos, pero con un mensaje de exito
        log('OK');
        return _respuestaJson(response.statusCode, response.body, "OK");
      }

    }catch(e) {
      //de cumplirse el catch, retorna un codigo de respuesta de 0, el mensaje de error y la
      //excepcion como datos
      log('Error algo sucedio ${e.toString()}');
      Map<dynamic, dynamic> mapa = {'data':e.toString()};
      return _respuestaJson(0, mapa, "Hubo un error de validacion o no esta authorizado");
    }
  }

  //esta funcion de solicitud get
  // con la dir_recurso para la direccion del recurso
  // token, el token para autenticarse, si esque existe
  void solicitudGet(String dir_recurso,
      String token) async {
    log("${this.NAME}:solicitudGET");
    Map<String, String> _header = {'Content-Type':'application/json'};
    if(token != NO_TOKEN) {
      _header = {'Content-Type':'application/json', 'Authorization':token};
    }
    final String url = base + dir_recurso;
    final uri = Uri.parse(url);
    try{
      final response = await http.get(uri, headers: _header);
      log(response.statusCode.toString());
      log(response.body);
    }catch(e) {
      log('Error algo sucedio ${e.toString()}');
    }
  }
  RespuestaGenerica _respuestaJson(int code, dynamic data, String message) {
    var respuesta = RespuestaGenerica();
    respuesta.code = code;
    respuesta.message = message;
    respuesta.data = data;
    return respuesta;
  }
}
//CLASE GENERICA
class RespuestaGenerica {
  String message = "";
  int code = 0;
  dynamic data;
  RespuestaGenerica({this.code = 0, this.message="", this.data});
}


/*
Future<void> obtenerLibros() async {
  final token = await obtenerToken();
  final url = Uri.parse('http://192.168.0.105:8081/api/v1/libros');
  final headers = {
    'Authorization': token!,
  };
  final response = await http.get(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    final List<Book> books = [];
    for (var book in jsonData) {
      books.add(Book.fromJson(book));
    }
    setState(() {
      _books = books;
    });
  } else {
    final message = json.decode(response.body)['message'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}*/