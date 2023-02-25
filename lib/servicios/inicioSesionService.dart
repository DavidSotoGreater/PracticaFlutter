import 'dart:convert';
import 'dart:developer';
import 'package:biblioteca_movil/servicios/modelo/inicioSesionWS.dart';
import 'package:biblioteca_movil/utiles/conexionWS.dart';

import '../utiles/conexionWS.dart';
import 'modelo/inicioSesionWS.dart';

class InicioSesionService {
  ConexionWS restCliente = ConexionWS();
  Future<InicioSesionWS> inicio_sesion(Map<dynamic, dynamic> mapa) async {
    log('InicioSesionService:inicio_sesion');
    RespuestaGenerica response = await restCliente.solicitudPost(
        'inicio_sesion', mapa, ConexionWS.NO_TOKEN);
    //log(response.code.toString());
    return _inicioSesionJson((response.code == 200) ? response.data: null);

  }

  InicioSesionWS _inicioSesionJson(dynamic data) {
    var inicio = InicioSesionWS();

    log("InicioSesionService");
    if(data != null) {
      Map<String, dynamic> mapa = jsonDecode(data);
      if(mapa['msg'] == 'OK' || mapa ['msg'] == 'ok'){
        inicio = InicioSesionWS.fromMap(mapa['data']);
      }
      inicio.code = mapa['code'];
      inicio.msg = mapa['msg'];
    }else{
      inicio.code = '400';
      inicio.msg = 'error fatal';
    }
    return inicio;
  }
}
