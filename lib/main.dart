import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/src/common/service/database_service.dart';

import 'src/common/widgets/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DataBaseService.create();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}
