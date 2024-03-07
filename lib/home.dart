import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  File? pickedMedia;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 189, 204),
        title: Text(
          'Image To Text Converter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<MediaFile>? media = await GalleryPicker.pickMedia(
              context: context, singleMedia: true);
          if (media != null && media.isNotEmpty) {
            var data = await media.first.getFile();
            setState(() {
              pickedMedia = data;
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("asset/bag.png"))),
          child: SingleChildScrollView(child: _BuildII())),
    );
  }

  Widget _BuildII() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_imageView(), _extractTextView()],
    );
  }

  Widget _imageView() {
    if (pickedMedia == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 200),
        child: const Center(
          child: Text(
            "Please Select a Image",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Center(
      child: Image.file(
        pickedMedia!,
        width: 200,
      ),
    );
  }

  Widget _extractTextView() {
    if (pickedMedia == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 300),
          child: Text(
            "No Result",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: FutureBuilder(
          future: _extractText(pickedMedia!),
          builder: (context, snapshot) {
            return TextSelectionTheme(
              data: TextSelectionThemeData(cursorColor: Colors.red),
              child: SelectableText(
                snapshot.data ?? "",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            );
          }),
    );
  }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }
}
