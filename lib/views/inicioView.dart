import 'package:biblioteca_movil/views/guardarLibroView.dart' as guardarLibro;
import 'package:biblioteca_movil/views/modificarLibroView.dart' as modificarLibro;
import 'package:biblioteca_movil/views/mostrarLibrosView.dart';
import 'package:biblioteca_movil/views/personaView.dart';
import 'package:biblioteca_movil/views/busqueda.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_movil/utiles/Urls.dart';
import 'package:biblioteca_movil/views/sesionView.dart';

import 'mostrarLibrosView.dart';


void navegarInicioSesion(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => SesionLogin()),
  );
}



class InicioView extends StatelessWidget {
  const InicioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        automaticallyImplyLeading: false, //esto es para quitar la flecha y el usuario solo puede cerrar sesion para salir
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => guardarLibro.GuardarLibroView(),
                ),
              );
            },
            child: const Text('Guardar libro'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => modificarLibro.GuardarLibroView(),
                ),
              );
            },
            child: const Text('Modificar libro'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListarLibrosView(),
                ),
              );
            },
            child: const Text('Mostrar libros'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => personasView(),
                ),
              );
            },
            child: const Text('Ver persona'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusquedaView(),
                ),
              );
            },
            child: const Text('Búsqueda'),
          ),
          ElevatedButton(
            onPressed: () async {
              await borrarToken();
              navegarInicioSesion(context);
            },
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
