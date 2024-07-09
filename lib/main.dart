import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather%20cubit/get_weather_cubit.dart';
import 'package:weather_app/bloc/weather%20cubit/weather_states_cubit.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: getThemeColor(
                      BlocProvider.of<GetWeatherCubit>(context)
                          .weatherModel
                          ?.weatheCondetion),
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: const HomeView(),
            );
          },
        );
      }),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  // Convert the condition to lowercase for case-insensitive matching
  condition = condition.toLowerCase();

  // Group similar conditions and assign a color
  if (condition.contains('clear') || condition.contains('sunny')) {
    return Colors.amber;
  } else if (condition.contains('cloudy') || condition.contains('overcast')) {
    return Colors.blueGrey;
  } else if (condition.contains('rain') || condition.contains('drizzle')) {
    return Colors.lightBlue;
  } else if (condition.contains('snow') || condition.contains('sleet')) {
    return Colors.cyan;
  } else if (condition.contains('thunder')) {
    return Colors.deepPurple;
  } else if (condition.contains('fog')) {
    return Colors.grey;
  } else {
    // Default color for other conditions
    return Colors.blue;
  }
}
