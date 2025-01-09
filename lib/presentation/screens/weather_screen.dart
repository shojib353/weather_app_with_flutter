import 'package:flutter/material.dart';
import 'package:weather_app/core/services/api_service.dart';
import 'package:weather_app/core/utils/constants/urls.dart';
import 'package:weather_app/core/utils/date_service.dart';
import 'package:weather_app/data/model/weather_model.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = true;
  final ApiService _apiService = ApiService();
  late WeatherModel weatherModel;

  // Fetch weather data from the API
  void _loadWeatherData() async {

      final data = await _apiService.fetchData(weatherUrl);
      weatherModel = WeatherModel.fromJson(data);



        isLoading = false;
      setState(() {});


  }

  @override
  void initState() {
    super.initState();

    _loadWeatherData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar:AppBar(
        backgroundColor: Colors.black38,
        title: Padding(

         padding: const EdgeInsets.all(10),
          child: Row(


           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height: 5,),
                 Text(

                   isLoading
                       ? 'Loading...' // Placeholder text while loading
                       : weatherModel.location!.name.toString(),
                   style: TextStyle(
                     fontSize: 18, // Set font size to 18 (or any size you prefer)
                     color: Colors.white, // Set text color to white
                   ),
                 ),

                 Text(
                   style: TextStyle(
                     fontSize: 15, // Set font size to 18 (or any size you prefer)
                     color: Colors.grey, // Set text color to white
                   ),

                   isLoading
                       ? 'Loading...' // Placeholder text while loading
                       : formatDate(weatherModel.location!.localtime.toString()),
                 ),
                 SizedBox(height: 5,),
               ],
             ),

             
           ],


          ),
        ),
        actions: [
      Container(

     // Padding around the icon to create a circle
      decoration: BoxDecoration(

        shape: BoxShape.rectangle,
        // Make the background a circle
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {
          // Define the action when the icon is pressed
          print('Menu button pressed');
        },
        icon: const ImageIcon(
          AssetImage("assets/images/menu.png",),
          size: 20,
          color: Colors.white,

          // Icon color
        ),
      ),
    ),
    SizedBox(width: 20), // Space between the icons
    ],

      ),
      
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Show a loading spinner
            : Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                        children: [

              Container(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 40,),

                          Text('${weatherModel.current!.tempC}°',
                            style: TextStyle(

                                fontSize: 88
                                ,
                                color: Colors.white
                            ),),

                          Text('${weatherModel.current!.condition!.text}',
                            style: TextStyle(
                                fontSize: 18
                                ,
                                color: Colors.grey
                            ),)
                        ],
                      ),
                      Image.network(
                        height: 200,
                        weatherModel.current!.condition!.icon.toString(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, size: 30, color: Colors.red);
                        },
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Card(
                  color:Color(0xFF202329),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Icon(
                              Icons.wind_power_outlined, // Replace this with your IconData, e.g., Icons.wind_power
                              size: 24.0, // Set the desired size
                              color: Colors.blue, // Optional: Set the icon color
                            ),
                            Text(weatherModel.current!.windKph.toString()+' kph',
                            style: TextStyle(
                              fontSize: 20
                                ,color: Colors.white
                            ),),
                            Text("Wind",
                              style: TextStyle(
                                  fontSize: 20
                                      ,color: Colors.white
                              ),),
                          ],



                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Icon(
                          Icons.hub_outlined, // Replace this with your IconData, e.g., Icons.wind_power
                          size: 24.0, // Set the desired size
                          color: Colors.blue, // Optional: Set the icon color
                        ),
                            Text(weatherModel.current!.humidity.toString()+' %',
                              style: TextStyle(
                                  fontSize: 20
                                  ,color: Colors.white
                              ),),
                            Text("Humidity",
                              style: TextStyle(
                                  fontSize: 20
                                  ,color: Colors.white
                              ),),
                          ],



                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("🌧️",
                              style: TextStyle(
                                  fontSize: 25
                                      ,color: Colors.blueAccent
                              ),),
                            Text('${weatherModel.forecast!.forecastday![0].day!.dailyChanceOfRain} %',
                              style: TextStyle(
                                  fontSize: 20
                                  ,color: Colors.white
                              ),),
                            Text("Rain",
                              style: TextStyle(
                                  fontSize: 20
                                  ,color: Colors.white
                              ),),
                          ],



                        ),

                      ],
                    ),
                  ),
                ),
              )




                        ],
                      ),
            ),
      ),
    );
  }
}
