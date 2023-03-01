import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Uploadimage {
  static const String _baseUrl =
      'https://fakestoreapi.com'; //why static and const?

  Future imageUpload(File file) async {
    var request =
        await http.MultipartRequest("POST", Uri.parse("$_baseUrl/test.php"))
          ..files.add(await http.MultipartFile.fromPath("sendimage", file.path,
              contentType: MediaType("image", "png")));
    final send = await request.send();
    final Response = await http.Response.fromStream(send);
    if (Response.statusCode == 200) {
      print("upload successfull");
    }
  }
}
