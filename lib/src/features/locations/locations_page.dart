import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/src/features/map/map_page.dart';
import '../../common/constants/app_images.dart';
import '../../common/constants/custom_gradient.dart';
import 'widgets/custom_add_button.dart';
import 'widgets/custom_card.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
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
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) => CustomCart(
                        size: size,
                        country: "Tashkent, Uzbekistan",
                        temperature: "12",
                        weather: "Cloudy",
                      ),
                      itemCount: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
