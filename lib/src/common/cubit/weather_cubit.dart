import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/src/common/constants/app_images.dart';
import 'package:weatherapp/src/common/models/weather_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(const WeatherSuccess());

  void addMarker(WeatherModel weatherModel) {
    final PlacemarkMapObject placemarkMapObject = PlacemarkMapObject(
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            AppImages.location,
          ),
        ),
      ),
      mapId: MapObjectId(weatherModel.name!),
      point: Point(
        longitude: weatherModel.longitude!,
        latitude: weatherModel.latitude!,
      ),
    );
    emit(
      WeatherSuccess(
        mapObjects: [
          placemarkMapObject,
        ],
      ),
    );
  }
}
