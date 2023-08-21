import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoController extends ChangeNotifier{
  double lat = 0.00;
  double long = 0.00;
  String erro = '';

  GeoController(){
    getPosicao();
  }

  getPosicao() async{
    try{
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    }catch(e){
      erro = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _posicaoAtual () async{
    LocationPermission permisao;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if(!ativado){
      return Future.error('Por Favor, habilite a localização no seu Smartphone');
    }

    permisao = await Geolocator.checkPermission();

    if(permisao == LocationPermission.denied){
      permisao = await Geolocator.requestPermission();
      if(permisao == LocationPermission.denied){
        return Future.error('Você precisa autorizar o acesso à Localização');
      }
    }

    if(permisao == LocationPermission.deniedForever){
      return Future.error('Você precisa autorizar o acesso à Localização');
    }

    return await Geolocator.getCurrentPosition();
  }
}