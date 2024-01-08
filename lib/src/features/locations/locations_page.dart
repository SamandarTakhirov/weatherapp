import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/src/features/map/map_page.dart';
import '../../common/constants/app_images.dart';
import '../../common/constants/custom_gradient.dart';
import 'location_bloc/location_bloc.dart';
import 'widgets/custom_add_button.dart';
import 'widgets/custom_card.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late final LocationBloc locationBloc;

  @override
  void initState() {
    locationBloc = LocationBloc()..add(GetLocationEvent());
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: locationBloc,
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: CustomGradient.customGradient(),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      AppImages.icLineVR,
                    ),
                    SvgPicture.asset(
                      AppImages.icLineHR,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomAddButton(
                      size: size,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapPage(),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: BlocBuilder<LocationBloc, LocationState>(
                        bloc: locationBloc,
                        builder: (context, state) {
                          print(state);
                          return state.map(
                            onLocationLoading: (locationLoading) => const SizedBox(),
                            onLocationSuccess: (locationSuccess) {
                              return ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (context, index) => CustomCart(
                                  weathers: locationSuccess.weather.elementAt(index),
                                ),
                                itemCount: locationSuccess.weather.length,
                              );
                            },
                            onLocationError: (locationError) => const SizedBox(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
