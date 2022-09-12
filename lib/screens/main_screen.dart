import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  MainScreen({required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//bu kısımda static veriler vardır;
  //kullanıcağım verileri tanımlıyorum;
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late var city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      //static verileri oto. olarak anlık bir şekilde aktarılacak;
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints
            .expand(), //ile ekleyeceğimiz görsel genişleyip telefona uyumlu hale gelmesini sağlar
        decoration: BoxDecoration(
            image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Text(
              '$temperature°',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80.0,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
