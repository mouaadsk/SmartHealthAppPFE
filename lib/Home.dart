import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:image_picker/image_picker.dart'  ;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:smarthealth/FireAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarthealth/LoginPage.dart';
import 'package:tflite/tflite.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:mlkit/mlkit.dart';
import 'package:image/image.dart' as img;
import 'Recipes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.auth, this.signedOut, this.signedIn});
  final FireAuth auth;
  final VoidCallback signedOut, signedIn;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class aboutPage extends StatefulWidget {
  @override
  _aboutPageState createState() => new _aboutPageState();
}

class MyAppl extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _img = 'assets/images/nickfrost.jpg';
  final String _fullName = "Mariam Sebbar";
  final String _email = "crasy.meryam@gmail.com";

 File image;

//  To use Gallery or File Manager to pick Image
//  Comment Line No. 19 and uncomment Line number 20
  picker() async {
    
//    File img = await ImagePicker.pickImage(source: ImageSource.camera);
 File img = await ImagePicker.pickImage(source: ImageSource.gallery);
 print('Picker is called');
  }
//  To use Gallery or Fickeile Manager to pick Image
//  Comment Line No. 19 and uncomment Line number 20

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Home'), backgroundColor: Color(0xff01A0C7)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new Container(
              color: Color(0xff01A0C7),
              child: new UserAccountsDrawerHeader(
                accountName: new Text(_fullName),
                accountEmail: new Text(_email),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: AssetImage(_img),
                ),
              ),
            ),
            new ListTile(
              title: new Text('Edit Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyAppl()));
              },
            ),
            new ListTile(
              title: new Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new aboutPage()));
              },
            ),
            new ListTile(
              title: new Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                widget.signedOut();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(
                              auth: widget.auth,
                              onSignedIn: widget.signedIn,
                            )));
              },
            ),
          ],
        ),
      ),
      body: new Container(
        child: new SingleChildScrollView(
          child: new ConstrainedBox(
            constraints: new BoxConstraints(),
            child: new Column(
              children: <Widget>[
                new Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0)),
                Center(
                  child: Text("Last Added"),
                ),
                new SizedBox(
                    height: 700.0,
                    width: 360.0,
                    child: new Carousel(
                      images: [
                        new ExactAssetImage("assets/images/6.jpg"),
                        new ExactAssetImage("assets/images/5.jpg"),
                        new ExactAssetImage("assets/images/3.jpg"),
                        new ExactAssetImage("assets/images/1.jpg"),
                        new ExactAssetImage("assets/images/4.jpg"),
                        new ExactAssetImage("assets/images/2.jpg")
                      ],
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.grey,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.grey.withOpacity(0.2),
                      borderRadius: true,
                      moveIndicatorFromBottom: 18.0,
                      noRadiusForIndicator: true,
                      overlayShadow: true,
                      overlayShadowColors: Colors.white,
                      overlayShadowSize: 0.7,
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 300.0),
                  child: FloatingActionButton(
                    tooltip: 'Camera',
                    child: Icon(Icons.camera_alt, color: Colors.white),
                    backgroundColor: Colors.black,
                    onPressed: picker,
                      // String image,recipe,ingredient,steps;
                    //   Navigator.of(context).pop();
                    //   Navigator.push(
                    // context,
                    // new MaterialPageRoute(
                    //     builder: (BuildContext context) => new Recipe()));
                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _aboutPageState extends State<aboutPage> {
  final String _img = 'assets/images/nickfrost.jpg';
  final String _fullName = "Mariam Sebbar";
  final String _email = "crasy.meryam@gmail.com";

  @override
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('About'), backgroundColor: Color(0xff01A0C7)),
        //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
        body: new Container(
          padding: new EdgeInsets.all(25.0),
          child: new Text(
              '    Health apps are application programs that offer health-related services for smartphones and tablet PCs.\n     Because they’re accessible to patients both at home and on-the-go, health apps are a part of the movement towards mobile health (mHealth) programs in health care. \n     There are many varieties of health apps available for purchase from app stores.\n Some are designed to help consumers make healthier choices in their everyday life by offering advice about fitness or nutrition. \n     Others help doctors and patients communicate from afar, like apps for diabetics that automatically sent glucose readings to their primary care physicians. \nSome apps are aimed at physicians themselves—many apps combine mHealth with electronic medical records (EMR), allowing doctors to keep accurate records that are easily accessible.\n\n     Most people do not carry medical records when they leave home. They do not realize that in an emergency these medical records can make a big difference; additionally, it is hard to predict when an emergency might occur. In fact, they could save a life. Previous medications, history of allergy to medications, and other significant medical or surgical history can help a health professional through PHA tools to optimize treatment.[citation needed]\n     A Personal Health Application (PHA) tool contains a patient personal data (name, date of birth and other demographic details). It also includes a patient’s diagnosis or health condition and details about the various treatment/assessments delivered by health professionals during an episode of care from a health care provider. It contains an individuals health-related information accumulated during an entire lifetime.\n\n Background The rapid growth in the number of mobile health applications could have profound significance in the prevention of disease or in the treatment of patients with chronic disease such as diabetes.\nObjective\nThe objective of this study was to describe the characteristics of the most common mobile health care applications available in the Apple iTunes marketplace. \nMethods\nWe undertook a descriptive analysis of a sample of applications in the “health and wellness” category of the Apple iTunes Store. We characterized each application in terms of its health factor and primary method of user engagement. The main outcome measures of the analysis were price, health factors, and methods of user engagement. Results Among the 400 applications that met the inclusion criteria, the mean price of the most frequently downloaded paid applications was US 2.24 (SD 1.30), and the mean price of the most currently available paid applications was US 2.27 (SD 1.60). Fitness/training applications were the most popular (43.5%, 174/400). The next two most common categories were health resource (15.0%, 60/400) and diet/caloric intake (14.3%, 57/400). Applications in the health resource category constituted 5.5% (22/400) of the applications reviewed. Self-monitoring was the most common primary user engagement method (74.8%, 299/400). A total of 20.8% (83/400) of the applications used two or more user engagement approaches, with self-monitoring and progress tracking being the most frequent. Conclusions Most of the popular mobile health applications focus on fitness and self-monitoring. The approaches to user engagement utilized by these applications are limited and present an opportunity to improve the effectiveness of the technology. Keywords: cellular phone, Internet, medical informatics applications, social media Go to:IntroductionMobile Devices and mHealth The development of mobile communications devices such as smartphones and tablet computers has spurred rapid growth in the field of mobile health (mHealth), the use of mobile-enabled applications that collect or deliver health care information and data. These applications offer the potential for dynamic engagement of patients and providers in health care and a new means of improving health outcomes. This technology could have profound application in the prevention of cardiovascular disease or in the treatment of patients with chronic disease such as diabetes and congestive heart failure. The rapid growth in mHealth has outpaced the science needed to validate the clinical effectiveness (and safety) of health-related applications. Due to the proliferation of smartphones and health-centric mobile applications (app), the US Food and Drug Administration recently issued guidance that will apply a similar risk-based approach to assure the safety and effectiveness of mHealth apps as other medical devices [1].mHealth offers a unique opportunity to tailor and customize care for individual patients on the basis of health needs and behavioral attributes. Self-monitoring tools and apps are growing faster than more traditional telemedicine interventions because of the ubiquity of smartphones and the minimal development cost of health-related apps in providing flexible, scalable, mobile, and interoperable platforms [2].mHealth Patient Engagement mHealth also promises greater patient engagement, given the technology’s near instant and always-on functionality, and continual use for multiple tasks. This concept is critical to the behavior change required for improved patient outcomes. However, little is known about the health needs or health behaviors targeted by current mHealth offerings. Therefore, in this study, we set out to describe the most popular mHealth apps, both in purpose and engagement method, available in the Apple iTunes marketplace.'),
        ));
  }
}

class _State extends State<MyAppl>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit Profile'),
          backgroundColor:Color(0xff01A0C7)
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                    hintText: 'Full Name',
                    icon: new Icon(Icons.people)
                ),
                autocorrect: true,
                autofocus: true,
                //displaying text keyboard
                keyboardType: TextInputType.text,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: 'Age',
                ),
                autocorrect: true,
                autofocus: true,
                //displaying text keyboard
                keyboardType: TextInputType.text,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: 'Disease',
                ),
                autocorrect: true,
                autofocus: true,
                //displaying text keyboard
                keyboardType: TextInputType.text,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: 'Height',
                ),
                autocorrect: true,
                autofocus: true,
                //displaying text keyboard
                keyboardType: TextInputType.text,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: 'Weight',
                ),
                autocorrect: true,
                autofocus: true,
                //displaying text keyboard
                keyboardType: TextInputType.text,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: 'Password',
                ),
                autocorrect: true,
                autofocus: true,
                //displaying text keyboard
                keyboardType: TextInputType.text,
              ),
        Container(
          margin: const EdgeInsets.only( left: 280.0, top:0.0 , bottom:50.0),),
        new FloatingActionButton(
        onPressed: (){},
        tooltip: 'Next',
        child: Icon(Icons.arrow_forward, color: Color(0xff01A0C7)),
        backgroundColor: Colors.white,
          )
            ],
          ),
        ),
      ),
    );
  }

}

  Future<List> getImage(File imgg) async {
    ;
    final directory = await getApplicationDocumentsDirectory();


    img.Image image =img.decodeImage(imgg.readAsBytesSync());
    img.Image thumbnail = img.copyResize(image, 60, 60);
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

  
  return recognitions;
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
