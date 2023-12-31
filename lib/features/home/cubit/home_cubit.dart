import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/app/core/enums.dart';
import 'package:weather/domain/models/weather_model.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.weatherRepository}) : super(const HomeState());

  final WeatherRepository weatherRepository;

  Future<void> getWeatherModel({
    required String city,
  }) async {
    emit(const HomeState(status: Status.loading));
    try {
      final weatherModel = await weatherRepository.getWeatherModel(city: city);
      emit(
        HomeState(
          model: weatherModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
