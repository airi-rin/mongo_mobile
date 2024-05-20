import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../service/label_service.dart';
import '../main.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  String _result = '';
  File? _image;

  @override
  void initState() {
    super.initState();
    controller = CameraController(MyApp.cameras[0], ResolutionPreset.medium);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void _setResult(String result) {
    setState(() {
      _result = result;
    });
  }

  void _setImage(XFile image) {
    setState(() {
      _image = File(image.path);
      _result = '';
    });
  }

  void _reset() {
    setState(() {
      _image = null;
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Camera'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: _image == null
                  ? CameraPreview(controller!)
                  : Image.file(_image!),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple, width: 10.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            _image != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        ElevatedButton(
                            onPressed: () async {
                              _setResult(
                                  await LabelService.predict(_image!.path));
                            },
                            child: Text('No resnet')),
                        ElevatedButton(
                            onPressed: () async {
                              _setResult(await LabelService.predictResnet(
                                  _image!.path));
                            },
                            child: Text('Resnet')),
                      ])
                : Container(),
            Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: Text(
                _result,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _image == null
          ? FloatingActionButton(
              onPressed: () async {
                XFile? image = await controller!.takePicture();
                _setImage(image);
              },
              child: Icon(Icons.camera),
            )
          : FloatingActionButton(
              onPressed: _reset,
              child: Icon(Icons.delete),
            ),
    );
  }
}
