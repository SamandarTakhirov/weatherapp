import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';
import 'package:weatherapp/src/features/map/search_bloc/search_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../common/constants/app_colors.dart';
import '../../common/cubit/weather_cubit.dart';
import '../../common/models/weather_model.dart';
import '../../common/service/database_service.dart';
import '../../common/utils/custom_decoration.dart';
import '../home/home_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<YandexMapController> yandexMapController = Completer();
  late final WeatherCubit weatherCubit;
  late final TextEditingController textEditingController;
  late final SearchBloc searchBloc;
  late final FocusNode focusNode;
  List<PlacemarkMapObject> mapObjects = [];

  final ValueNotifier<bool> isFocused = ValueNotifier(false);
  final ValueNotifier<bool> isTap = ValueNotifier(false);

  @override
  void initState() {
    focusNode = FocusNode()
      ..addListener(() {
        isFocused.value = focusNode.hasFocus;
      });
    searchBloc = SearchBloc()
      ..add(
        const SearchFromStorageEvent(),
      );
    weatherCubit = WeatherCubit();
    textEditingController = TextEditingController()
      ..addListener(
        () {
          print(textEditingController.text);
          if (textEditingController.text.isEmpty) {
            searchBloc.add(const SearchFromStorageEvent());
          } else {
            searchBloc.add(
              SearchLocationEvent(
                query: textEditingController.text,
              ),
            );
          }
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchBloc.close();
    weatherCubit.close();
    textEditingController.dispose();
    super.dispose();
  }

  Future<WeatherModel> getCamera(
    YandexMapController controller, [
    WeatherModel? weatherModel,
  ]) async {
    if (weatherModel == null) {
      final value = await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition();
      weatherModel = WeatherModel(
        "name",
        value.latitude,
        value.longitude,
      );
      isTap.value = false;
    }
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: weatherModel.latitude!,
            longitude: weatherModel.longitude!,
          ),
        ),
      ),
      animation: const MapAnimation(),
    );
    return weatherModel;
  }

  Future<void> onMapCreated(YandexMapController controller) async {
    yandexMapController.complete(controller);
    final WeatherModel value = await getCamera(controller);
    weatherCubit.addMarker(value);
  }

  Future<void> onLocationTap(WeatherModel weatherModel) async {
    focusNode.unfocus();
    textEditingController.text = "${weatherModel.name}";
    final controller = await yandexMapController.future;
    await getCamera(
      controller,
      weatherModel,
    );
    weatherCubit.addMarker(
      weatherModel,
    );
    isTap.value = true;
    DataBaseService.dataBaseService.addLastLocation(weatherModel);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: searchBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ValueListenableBuilder(
                valueListenable: isTap,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value,
                    child: child!,
                  );
                },
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    surfaceTintColor: AppColors.mainColor,
                    backgroundColor: AppColors.white,
                    side: BorderSide(
                      color: AppColors.black,
                    ),
                    fixedSize: Size(
                      size.width * 0.75,
                      size.height * 0.065,
                    ),
                  ),
                  onPressed: () {
                    if (weatherCubit.state.mapObjects.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            final value = weatherCubit.state.mapObjects.first;
                            return HomePage(
                              weatherModel: WeatherModel(
                                value.mapId.value,
                                value.point.latitude,
                                value.point.longitude,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Add Location",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  side: BorderSide(
                    color: AppColors.black,
                  ),
                ),
                splashColor: AppColors.white,
                backgroundColor: AppColors.white,
                onPressed: () async {
                  final controller = await yandexMapController.future;
                  final WeatherModel weatherModel = await getCamera(controller);
                  weatherCubit.addMarker(
                    weatherModel,
                  );
                },
                child: Icon(
                  CupertinoIcons.map_pin_ellipse,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            StreamBuilder(
              stream: weatherCubit.stream,
              initialData: weatherCubit.state,
              builder: (context, snapshot) {
                return YandexMap(
                  mapObjects: snapshot.data!.mapObjects,
                  onMapCreated: onMapCreated,
                );
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        BackButton(
                          color: AppColors.black,
                        ),
                        SizedBox.fromSize(
                          size: Size(
                            size.width * 0.85,
                            size.height * 0.07,
                          ),
                          child: TextField(
                            focusNode: focusNode,
                            autofocus: true,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            textInputAction: TextInputAction.search,
                            cursorColor: AppColors.mainColor,
                            minLines: 1,
                            maxLines: 1,
                            controller: textEditingController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => textEditingController.clear(),
                              ),
                              filled: true,
                              hintText: "Add New Location",
                              hintStyle:
                                  context.textTheme.titleMedium?.copyWith(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.textColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.mainColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: isFocused,
                      builder: (context, value, child) {
                        return AnimatedContainer(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: size.height * 0.005,
                          ),
                          width: size.width,
                          height: value ? size.height * 0.3 : 0,
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          decoration: CustomDecoration.customDecoration(),
                          child: child,
                        );
                      },
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return state.map(
                            onSearchInitial: (searchInitial) => LocationBuilder(
                              onTap: onLocationTap,
                              isFromStorage: true,
                              weatherModels: searchInitial.searchLocations.toSet(),
                            ),
                            onSearchLoading: (searchLoading) =>
                                const SizedBox(),
                            onSearchSuccess: (searchSuccess) => LocationBuilder(
                              onTap: onLocationTap,
                              isFromStorage: false,
                              weatherModels: searchSuccess.searchLocations.toSet(),
                            ),
                            onSearchError: (searchError) => const SizedBox(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationBuilder extends StatelessWidget {
  final Set<WeatherModel> weatherModels;
  final void Function(WeatherModel weatherModel) onTap;
  final bool isFromStorage;

  const LocationBuilder({
    required this.weatherModels,
    required this.isFromStorage,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final location = weatherModels.elementAt(index);
        return ListTile(
          title: Text(
            "${location.name}",
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          onTap: () => onTap(location),
          trailing: isFromStorage
              ? Icon(
                  Icons.history,
                  color: AppColors.black,
                )
              : null,
        );
      },
      itemCount: weatherModels.length,
    );
  }
}
