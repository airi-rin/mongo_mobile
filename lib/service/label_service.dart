import 'dart:convert';

import 'package:mongo_flutter/model/label_model.dart';
import 'package:http/http.dart' as http;

class LabelService {
  static final String URL = 'http://192.168.228.203:5000/api/labels/';
  // static final String URL = 'http://192.168.0.3:5000/api/labels/';

  static Future<List<LabelModel>> getList() async {
      var url = Uri.parse(URL + "list");
      var response = await http.get(url);

      var listMap = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      List<LabelModel> result =
        listMap.map((e) => LabelModel.fromJson(e)).toList();

      return result;
  }

  static Future<String> predict(String imagePath) async {
    var url = Uri.parse(URL + "predict/no-resnet");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }

    return response.body;
  }

  static Future<String> predictResnet(String imagePath) async {
    var url = Uri.parse(URL + "predict/resnet");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }

    return response.body;
  }
}
