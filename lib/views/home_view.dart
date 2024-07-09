import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather%20cubit/get_weather_cubit.dart';
import 'package:weather_app/bloc/weather%20cubit/weather_states_cubit.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/screens/no_weather_body.dart';
import 'package:weather_app/screens/weather_info_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Weather App'),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const SearchView()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
        body: BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is NoWeatherState) {
              return const NoWeatherBody();
            } else if (state is WeatherLoadedState) {
              return WeatherInfoBody(
                weather: state.weatherModel,
              );
            } else {
              return const Text('Oops there was an  error');
            }
          },
        ));
  }
}
