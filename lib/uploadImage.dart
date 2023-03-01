import 'dart:io'; // io package required for input output operations
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart'; //image picker package hekps to upload images from sysytem files
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // modal progresshud is the widgt useed to show loading symbol in flutter
import 'package:postapiapp/palletes.dart';
import 'package:http/http.dart' as http; // http used for api connection

//File? image;
class UploadImage extends StatefulWidget {
  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  //--------Defining required varialble
  File? image; //creating an file object
  final _picker = ImagePicker(); //from added dependency image picker
  bool showSnipper =
      false; // to show the loading symbol while the image is retrived

  Future getImage() async {
    //---------Getting an image from gallery, camera can also be used
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (pickedFile != null) {
      // if an image is choosan/not null
      image = File(pickedFile
          .path); //the picked image's path is assigned to image object

      setState(() {});
    } else {
      print('no image selected');
    }
  }

  Future<void> UploadImage() async {
    //the loading symbol is activated in the process of rotating
    setState(() {
      showSnipper = true;
    });

// a stream object is created and the image is read
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    //storing post api url
    var uri = Uri.parse("https://fakestoreapi.com/products");

    //getting api connection request
    var request = http.MultipartRequest("POST", uri);

    //created before hand key in postman("image") in this case
    var multiport = http.MultipartFile("image", stream, length);

    //adding files through request
    request.files.add(multiport);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSnipper = false;
      });
      print("image uploaded");
    } else {
      print("failed image upload");
      setState(() {
        showSnipper = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      //modal progresshud is the widgt useed to show loading symbol in flutter
      inAsyncCall: showSnipper,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("image upload"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                  child: image == null
                      ? const Center(
                          child: Text('pick image'),
                        )
                      : Center(
                          //look it is a lambda function
                          // if image is null pickimage is shown, else image is displayed
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 60,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
            const SizedBox(
              height: 150,
              width: 100,
            ),
            GestureDetector(
              onTap: () {
                UploadImage();
              },
              child: Container(
                height: 50,
                color: Pallete.primarycolor,
                child: const Text("upload image"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
