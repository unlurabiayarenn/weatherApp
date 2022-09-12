/*
  İnternetten dosya okuyacağı için veriler anında gelmeyeceği için bekleme kısmı için burası kullanılacaktır.
*/
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/screens/main_screen.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    //kontrol için;
    if (locationData.latitude == null || locationData.longitude == null) {
      print("Konum bilgileri alınamıyor.");
    } else {
      print("latitude:" + locationData.latitude.toString());
      print("longitude:" + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = new WeatherData(locationData: locationData);
    await weatherData.getcurrentTemperature();

    if (weatherData.currentCondition == null ||
        weatherData.currentTemperature == null) {
      print("API den sıcaklık veya durum bilgisi boş dönüyor!");
    }
    //burdan sonra main_screen e gelicez, konum bilgimi ve hava durumumu alıcak;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  //otomatik olarak çağırmka için;
  void initState() {
    // Proje başladığında ilk önce burda başlıyo
    super.initState();
    //getLocationData();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.blue]),
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
