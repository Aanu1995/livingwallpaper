import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:livingwallpaper/models/image.dart';
import 'package:livingwallpaper/views/utils/constants.dart';

class ApiService {
  static Future<List<Image>> getAllImages(
      {http.Client client, int pageNumber = 1, String category}) async {
    String url =
        "https://pixabay.com/api/?key=${ConstantUtils.key}&image_type=photo&orientation=vertical&page=$pageNumber";
    String url2 =
        "https://pixabay.com/api/?key=${ConstantUtils.key}&q=$category&image_type=photo&orientation=vertical&page=$pageNumber";
    try {
      http.Response response = client != null
          ? await client.get(category == null ? url : url2)
          : await http.get(category == null ? url : url2);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List result = map["hits"];
        return result.map((rawPost) => Image.fromMap(map: rawPost)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
