import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:biblioteca_movil/utiles/conexionWS.dart';
import 'package:biblioteca_movil/servicios/inicioSesionService.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:biblioteca_movil/views/registerPersonView.dart';
import 'package:biblioteca_movil/views/inicioView.dart';
import 'package:biblioteca_movil/utiles/Urls.dart';
import 'dart:developer';

class SesionLogin extends StatefulWidget {
  const SesionLogin({Key? key}) : super(key: key);

  @override
  State<SesionLogin> createState() => _SesionLoginState();
}

class _SesionLoginState extends State<SesionLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  ConexionWS conexionWS = new ConexionWS();
  late SharedPreferences _prefs;



  InicioSesionService inicioSesionService = new InicioSesionService();

  void mostrarMensaje(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    correoController.text = _prefs.getString('correo') ?? '';
    claveController.text = _prefs.getString('clave') ?? '';
  }



  void _iniciar() {
    setState(() {
      if (_formKey.currentState!.validate()) {
        Map<dynamic, dynamic> data = {
          "correo": correoController.text,
          "clave": claveController.text
        };

        inicioSesionService.inicio_sesion(data).then((value) {
          if (value.token != "") {
            log(value.token);
            log(value.msg);
            guardarToken(value.token);
            mostrarMensaje(context, 'Bienvenido');

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InicioView()),
              );
            });

            _prefs.setString('correo', correoController.text);
            _prefs.setString('clave', claveController.text);

          } else {
            mostrarMensaje(context, value.msg);
          }
          //log('SesionView:login');
          //log(value.token);
        });
        //conexionWS.solicitudPost('inicio_sesion', data, ConexionWS.NO_TOKEN);
        //conexionWS.solicitudGet('libros', ConexionWS.NO_TOKEN);
      }
    });
  }

  void _registrarse() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPersonView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  maxRadius: 100.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('imgs/login.png'),
                ),
                const Text(
                  'Inicio de sesion',
                  style: TextStyle(fontFamily: 'Lora', fontSize: 50.0),
                ),
                SizedBox(
                  width: 160.0,
                  height: 15.0,
                  child: Divider(color: Colors.blueAccent[600]),
                ),
                TextFormField(
                  enableInteractiveSelection: false,
                  controller: correoController,
                  decoration: const InputDecoration(
                    hintText: 'Correo',
                    labelText: 'Ingrese su correo',
                    suffixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Correo requerido';
                    }
                    if (!isEmail(value)) {
                      return 'Debe ser un correo valido';
                    }
                  },
                ),
                const Divider(
                  height: 18.0,
                ),
                TextFormField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  controller: claveController,
                  decoration: const InputDecoration(
                    hintText: 'Clave',
                    labelText: 'Ingrese su clave',
                    suffixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Clave requerida';
                    }
                  },
                ),
                const Divider(
                  height: 18.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: _iniciar,
                  child: const Text(
                    'Iniciar sesion',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 30.0,
                      fontFamily: 'Lora',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registrarse,
                  child: const Text(
                    'Registrarse ahora ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 30.0,
                      fontFamily: 'Lora',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
