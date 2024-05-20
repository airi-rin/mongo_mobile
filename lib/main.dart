import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mongo_flutter/page/camera_page.dart';
import 'package:mongo_flutter/constant_route.dart';
import 'package:mongo_flutter/page/detail_label_page.dart';
import 'package:mongo_flutter/model/label_model.dart';

import 'page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyApp.cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static List<CameraDescription> cameras = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mongo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Home Page'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case NamedRoute.homePageName:
              {
                return MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: 'Home Page',
                  ),
                );
              }
            case NamedRoute.detailLabelPageName:
              {
                var labelModel = settings.arguments as LabelModel;
                return MaterialPageRoute(
                    builder: (context) =>
                        DetailLabelPage(labelModel: labelModel));
              }
            case NamedRoute.cameraPageName:
              {
                return MaterialPageRoute(builder: (context) => CameraScreen());
              }
          }
        });
  }
}
