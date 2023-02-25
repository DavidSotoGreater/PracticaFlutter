import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:biblioteca_movil/views/busqueda.dart';
import 'package:biblioteca_movil/views/guardarLibroView.dart' as guardarLibro;
import 'package:biblioteca_movil/views/inicioView.dart';
import 'package:biblioteca_movil/views/modificarLibroView.dart'
    as modificarLibro;
import 'package:biblioteca_movil/views/mostrarLibrosView.dart';
import 'package:biblioteca_movil/views/personaView.dart';
import 'package:biblioteca_movil/views/registerPersonView.dart';
import 'package:biblioteca_movil/views/sesionView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Móvil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
// Rutas públicas
        '/login': (context) => FutureBuilder<String?>(
              future: getToken(),
              builder: (context, snapshot) {
                return const SesionLogin();
              },
            ),
        '/register': (context) => RegisterPersonView(),
        // Rutas protegidas
        '/guardarLibro': (context) => guardarLibro.GuardarLibroView(),
        '/modificarLibro': (context) => modificarLibro.GuardarLibroView(),
        '/mostrarLibros': (context) => ListarLibrosView(),
        '/mostrarPersonas': (context) => personasView(),
        '/buscarLibros': (context) => BusquedaView(),
        '/inicio': (context) => InicioView()

      },
      onGenerateRoute: (settings) {
        if (_isProtectedRoute(settings)) {
          return _createProtectedRoute(settings);
        }
        return null;
      },
    );
  }

// Obtener el token de sesión desde SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

// Verificar si una ruta es protegida
  bool _isProtectedRoute(RouteSettings settings) {
    return settings.name == '/guardarLibro' ||
        settings.name == '/modificarLibro' ||
        settings.name == '/mostrarLibros' ||
        settings.name == '/mostrarPersonas' ||
        settings.name == '/buscarLibros'||
        settings.name == '/inicio';
  }

// Crear una ruta protegida que requiere un token de sesión
  MaterialPageRoute<dynamic> _createProtectedRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return FutureBuilder<String?>(
          future: getToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _createRoute(settings);
            } else {
              return const SesionLogin();
            }
          },
        );
      },
      settings: settings,
    );
  }

// creacion de ruta con base en nombre de la misma,
  Widget _createRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/buscarLibros':
        return BusquedaView();
      case '/mostrarPersonas':
        return personasView();
      case '/guardarLibro':
        return guardarLibro.GuardarLibroView();
      case '/modificarLibro':
        return modificarLibro.GuardarLibroView();
      case '/mostrarLibros':
        return ListarLibrosView();
      case '/inicio':
        return InicioView();
      default:
        return SizedBox.shrink();
    }
  }
}
