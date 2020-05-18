import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'dart:async';
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  Io.File picture,imagee;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(onTap: getImage,
        child: Text('walo'),)
      ),
      drawer: Text('This is the drawer'),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future getImage() async {
    String link = "http://www.pngmart.com/files/3/Dates-Transparent-Background.png ";
      final directory = await getApplicationDocumentsDirectory();
      Io.File imgg = await DefaultCacheManager().getSingleFile(link);

      img.Image image =decodeImage(imgg.readAsBytesSync());
      img.Image thumbnail = copyResize(image, 60, 60);
      String res = await Tflite.loadModel(
    model: "images/model.tflite",
    labels: "images/Labels.txt",
    numThreads: 1 // defaults to 1
    );
    var recognitions = await Tflite.runModelOnBinary(
  binary: imageToByteListFloat32(thumbnail, 60, 0, 255.0),// required
  numResults: 6,    // defaults to 5
  threshold: 0.01,  // defaults to 0.1
);

  
  print(recognitions);
    //   FirebaseModelInterpreter interpreter = FirebaseModelInterpreter.instance;
    //   FirebaseModelManager manager = FirebaseModelManager.instance;
    //   FirebaseModelInputOutputOptions mDataOptions;
    //   try{

    //   }catch(e){
    //     print(e);
    //   }
    //   manager.registerCloudModelSource(
    //       FirebaseCloudModelSource(modelName: "fruits-classification"));
      // var imageBytes = (await rootBundle.load("images/apple.png")).buffer;
       //img.Image image = img.decodePng(imageBytes.asUint8List());
    //   print(imageBytes.asUint8List());
       //image = img.copyResize(image, 60, 60);
    //   var results ;
    //   interpreter.run(
    //                 "fruits-classification",
    //                 FirebaseModelInputOutputOptions(
    //                     0,
    //                     FirebaseModelDataType.INT32,
    //                     [1, 60, 60, 3],
    //                     0,
    //                     FirebaseModelDataType.INT32,
    //                     [1,53]),
    //                 imageToByteList(image)).catchError((e){print(e);}).then((onValue){
    //                   results = onValue;
    //                 });
    // print(results);
    // });
    
  }
  Uint8List imageToByteListFloat32(
    img.Image image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  print(buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
      print((img.getRed(pixel)  ));
      buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}
Uint8List imageToByteListUint8(img.Image image, int inputSize) {
  var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
  var buffer = Uint8List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = img.getRed(pixel);
      buffer[pixelIndex++] = img.getGreen(pixel);
      buffer[pixelIndex++] = img.getBlue(pixel);
    }
  }
  return convertedBytes.buffer.asUint8List();
}
}

