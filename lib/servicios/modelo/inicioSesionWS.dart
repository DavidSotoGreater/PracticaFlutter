
import 'dart:developer';

class InicioSesionWS {
  String external="";
  String correo="";
  String token="";
  String msg="";
  String code="";
  InicioSesionWS({this.external="",this.correo="", this.msg=""});

  InicioSesionWS.fromMap(Map <dynamic, dynamic> mapa) {
    correo = mapa["correo"];
    token = mapa["token"];
    external = mapa["external"];


    //msg = mapa["msg"];
    //code = mapa["code"];
  }

}

