import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/get_weather_emoji.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/presentation/widgets/temperature_progress_bar.dart';

import '../../core/utils/date_service.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({super.key, required this.weatherModel,required this.isLoading});

  final WeatherModel weatherModel;
  final isLoading;

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {

  var i=0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black38,
        title: Padding(

          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,


            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text(

                    widget.isLoading
                        ? 'Loading...' // Placeholder text while loading
                        : widget.weatherModel.location!.name.toString(),
                    style: TextStyle(
                      fontSize: 28, // Set font size to 18 (or any size you prefer)
                      color: Colors.white, // Set text color to white
                    ),
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

                Navigator.pop(context);


              },
              icon: const Icon(
               Icons.menu_open,
                size: 40,
                color: Colors.white,

                // Icon color
              ),
            ),
          ),
          SizedBox(width: 20), // Space between the icons
        ],

      ),
      body: SafeArea(
        child: widget.isLoading
            ? const Center(child: CircularProgressIndicator()) // Show a loading spinner
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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

                            Text('${widget.weatherModel.current!.tempC}°',
                              style: TextStyle(

                                  fontSize: 88
                                  ,
                                  color: Colors.white
                              ),),

                            Row(
                              children: [
                                Text('${widget.weatherModel.current!.condition!.text}',
                                  style: TextStyle(
                                      fontSize: 18
                                      ,
                                      color: Colors.grey
                                  ),),
                                Text(" ${getWeatherEmoji(widget.weatherModel.current!.condition!.text.toString())}")
                              ],
                            )
                          ],
                        ),

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
                              Text(widget.weatherModel.current!.windKph.toString()+' kph',
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
                              Text(widget.weatherModel.current!.humidity.toString()+' %',
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
                              Text('${widget.weatherModel.forecast!.forecastday![0].day!.dailyChanceOfRain} %',
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
                ),
                SizedBox(height: 20,),

                for(var day in widget.weatherModel.forecast!.forecastday!)

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: SizedBox(
                      width: 140,
                      child: Text("${getDayName(day.date.toString())}",
                          style: TextStyle(
                              fontSize: 20
                                  ,color: Colors.white,
                          ),),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5,),


                        Text("${day.day!.mintempC!.toInt()} °",
                        style: TextStyle(
                          fontSize: 25
                          ,color: Colors.white,
                        ),
                        ),
                        SizedBox(width: 5,),
    Expanded(
      child: TemperatureProgressBar(
      minTemp: day.day!.mintempC!.toInt(),
      maxTemp: day.day!.maxtempC!.toInt(),
      ),
    ),
                        SizedBox(width: 5,),
                        Text("${day.day!.maxtempC!.toInt()} °",
                          style: TextStyle(
                              fontSize: 25
                            ,color: Colors.white,
                          ),)
                      ],
                    ),
                    trailing:  Text(" ${getWeatherEmoji(day.day!.condition!.text.toString())}",
                    style: TextStyle(
                      fontSize: 20,
                    ),),

                    ),

                  ),









              ],
            ),
          ),
        ),
      ),
    );
  }
}
