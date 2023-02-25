import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class personasView extends StatefulWidget{
  const personasView({Key? key}) : super(key: key);

  @override
  State<personasView> createState() => _personaViewState();


  /*const Book({
    required this.nombre,
    required this.apellido,
    required this.identificacion,
    required this.tipo,
    required this.direccion,
    required this.telefono,
})*/
}
/*
const allPersonas =[
  Persona(
    nombre:'David',
    apellido:'Soto',
    identificacion:'1150394367',
    tipo:'cedula',
    direccion:'Samana',
    telefono:'0995855215',
  ),
];
*/

class _personaViewState extends State<personasView> {
  final String _nombre = "";
  final String _apellido= "";
  final String _identificacion= "";
  final String _tipo= "";
  final String _direccion= "";
  final String _telefono= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                maxRadius: 100.0,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage("imgs/login.png"),
              ),
              Text(
                "Panel de usuario",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 2000.0,
                height: 20.0,
                child: Divider(
                  color: Colors.black,
                  thickness: 1.5,
                  height: 15.0,
                ),
              ),
              Divider(
                height: 45.0,
                color: Colors.transparent,
              ),

              Text(
                "",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),

                  ),
                  child: Text(
                    "Modificar perfil",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0
                    ),
                  ),
                  onPressed: ()
                  {
                    print("$_direccion || $_telefono");
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
