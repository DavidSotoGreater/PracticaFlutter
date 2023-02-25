import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

// URL base del servidor, siempre usar la IP correspondiente y no la de localhost
String base = "http://192.168.0.105:8081/api/v1/";
String token = "";

// Función para guardar una cadena de texto en las preferencias compartidas
// key: la clave con la que se guardará la cadena de texto
// value: la cadena de texto que se desea guardar
_guardar(String key, String value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(key, value);
}

// Función para obtener una cadena de texto de las preferencias compartidas
// esta funcion retorna un future object que se resolvera con la cadena de texto asociada a la clave
//especificada
Future<String>_obtener(String key/*, String value*/) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final data = await preferences.getString(key);
  return data.toString();
}

//guardar token
Future<void> guardarToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  log('token almacenado');
}

// Recuperar un token
Future<String> obtenerToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  if (token == null) {
    log('No se pudo obtener el token de SharedPreferences. Se devolverá una cadena vacía en su lugar.');
    return '';
  }
  log('token recuperado');
  return token;
}


// Borrar un token
Future<void> borrarToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  log('token borrado');
}

