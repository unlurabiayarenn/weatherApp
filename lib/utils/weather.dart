//Hava durumu işlemlerini API ile sağlayacağımız için API ile ilgili işlemleri burda gerçekleştiricez.,
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'location.dart';

const apiKey = "521571a8438680b5308b372fb017a6fd";

class WeatherDisplayData {
  //görüntüleme verileri burası tutacak;
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
//anlık sıcaklık; -API den alınacak veriler;
  var currentTemperature;
  var currentCondition;
  var city;

  Future<void> getcurrentTemperature() async {
    // o anlık sıcaklığı çekicek
    String apiEndpoint =
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&exclude=hourly,daily&units=metric';
    final Uri url = Uri.parse(apiEndpoint);
    Response response = await http.get(url);

    if (response.statusCode == 200) {
      //gelen(JSON) değeri okumak için;
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API'den deger gelmiyor!");
    }
  }

  //görüntüleme değişkenlerimizi burası tutacaktır;
  WeatherDisplayData getWeatherDisplayData() {
    //kontrol edeceğimiz ilk şey;
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon:
              Icon(FontAwesomeIcons.cloud, size: 75.0, color: Colors.white),
          weatherImage: AssetImage('assets/images/bulutluhava.png'));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        //akşam;
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.moon, size: 75.0, color: Colors.white),
            weatherImage: AssetImage('assets/images/gece.png'));
      } else {
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.sun, size: 75.0, color: Colors.white),
            weatherImage: AssetImage('assets/images/gunesli.png'));
      }
    }
  }
}
