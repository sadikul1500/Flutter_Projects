//import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xff01AEBC),
      ),

      // Main Screen in our app
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  // Variables Declared
  //bool _loading = true;
  //late File _image;
  //final imagePicker = ImagePicker();
  //List _predictions = [];
  late CameraController cameraController;
  CameraImage? cameraImage;
  late List recognitionsList;
  String result = "";
  String confidence_value = "";

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {
        cameraController.startImageStream((image) => {
              cameraImage = image,
              runModel(),
            });
      });
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 4,
        threshold: 0.1,
        asynch: true,
      );

      for (var element in recognitions!) {
        //print(element["confidence"].runtimeType);
        double confidence = element["confidence"] * 100;
        setState(() {
          result = element["label"];
          confidence_value = " " + confidence.toStringAsFixed(2) + "%";
          //print(result);
        });
      }

      // setState(() {
      //   cameraImage;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    initCamera();
  }

  loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  // List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
  //   if (recognitionsList.isEmpty) return [];

  //   double factorX = screen.width;
  //   double factorY = screen.height;

  //   Color colorPick = Colors.pink;

  //   return recognitionsList.map((result) {
  //     return Positioned(
  //       left: result["rect"]["x"] * factorX,
  //       top: result["rect"]["y"] * factorY,
  //       width: result["rect"]["w"] * factorX,
  //       height: result["rect"]["h"] * factorY,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //           border: Border.all(color: Colors.pink, width: 2.0),
  //         ),
  //         child: Text(
  //           "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
  //           style: TextStyle(
  //             background: Paint()..color = colorPick,
  //             color: Colors.black,
  //             fontSize: 18.0,
  //           ),
  //         ),
  //       ),
  //     );
  //   }).toList();
  // }

  @override
  void dispose() {
    super.dispose();
    cameraController.stopImageStream();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Face Mask Detector"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height - 170,
                width: MediaQuery.of(context).size.width,
                child: !cameraController.value.isInitialized
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
              ),
            ),
            Text(
              result + confidence_value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: result == "Mask"
                      ? Colors.green.shade300
                      : (result == "Covered Mask_Mouth_Chin" ||
                              result == "Covered Mask_Nose_Mouth")
                          ? Colors.yellow.shade300
                          : result == "Covered Mask_Chin"
                              ? Colors.blue[300]
                              : Colors.red[300]),
            )
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   List<Widget> list = [];

  //   list.add(
  //     Positioned(
  //       top: 0.0,
  //       left: 0.0,
  //       width: size.width,
  //       height: size.height - 100,
  //       child: Container(
  //         height: size.height - 100,
  //         child: (!cameraController.value.isInitialized)
  //             ? Container()
  //             : AspectRatio(
  //                 aspectRatio: cameraController.value.aspectRatio,
  //                 child: CameraPreview(cameraController),
  //               ),
  //       ),
  //     ),
  //   );

  //   // if (cameraImage != null) {
  //   //   list.addAll(displayBoxesAroundRecognizedObjects(size));
  //   // }

  //   return SafeArea(
  //     child: Scaffold(
  //       backgroundColor: Colors.black,
  //       body: Container(
  //         margin: const EdgeInsets.only(top: 50),
  //         color: Colors.black,
  //         child: Stack(
  //           children: list,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Created detectImage() for detecting the image
  // Future detectImage(image) async {
  //   var prediction = await Tflite.runModelOnImage(
  //     path: image.path,
  //     numResults: 2,
  //     threshold: 0.6,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //   );
  //   setState(() {
  //     _loading = false;
  //     if (image != null) {
  //       _image = File(image.path);
  //       _predictions = prediction!;
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // Methods to pick the image  from Camera and Gallery
  // Future loadImageGallery() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.gallery);
  //   detectImage(image);
  // }

  // Future loadImageCamera() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   detectImage(image);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // Appbar declared
  //     appBar: AppBar(
  //       title: Text(
  //         'Face Mask Detection',
  //         style: GoogleFonts.robotoCondensed(),
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       // Column containing images and buttons
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           // Image will display here
  //           _loading == false
  //               ? Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Container(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           height: 280,
  //                           width: 220,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(25),
  //                           ),
  //                           child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(25),
  //                               child: Image.file(_image)),
  //                         ),
  //                         const SizedBox(height: 10),

  //                         Text(
  //                           _predictions.isNotEmpty
  //                               ? _predictions[0]['label']
  //                                   .toString()
  //                                   .substring(2)
  //                               : '',
  //                           style: GoogleFonts.robotoCondensed(
  //                             fontSize: 20,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 10),
  //                         // Text('Safer: '+"${(_predictions[0]
  //                         // ['confidence']*100).toString()}%"),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               : Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Container(
  //                     height: 300,
  //                     width: 250,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(15),
  //                       color: Colors.grey,
  //                     ),
  //                     child: const Center(child: Text('Image Appears here')),
  //                   ),
  //                 ),
  //           const SizedBox(height: 10),

  //           // Capture Image from Camera
  //           Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: Container(
  //               height: 50,
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   // Methods we created above
  //                   loadImageCamera();
  //                 },
  //                 child: const Text('Capture Image'),
  //                 style: ElevatedButton.styleFrom(
  //                   shadowColor: const Color(0xff01AEBC),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(15),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 10),

  //           // Capture Image from Gallery
  //           Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: Container(
  //               height: 50,
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   // Methods we created above
  //                   loadImageGallery();
  //                 },
  //                 child: const Text('Pick Image from Gallery'),
  //                 style: ElevatedButton.styleFrom(
  //                   shadowColor: Color(0xff01AEBC),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(15),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
