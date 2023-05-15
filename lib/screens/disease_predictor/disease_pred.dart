import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import '../../main.dart';

class DiseasePred extends StatefulWidget {
  static const routeName = '/disease-predictor';

  @override
  State<DiseasePred> createState() => _DiseasePredState();
}

class _DiseasePredState extends State<DiseasePred> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        // asynch: true,
      );

      for (var element in predictions!) {
        setState(() {
          output = element['label'];
        });
      }
    }
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/models/tflite-model.tflite',
        labels: 'assets/models/labels.txt',
      );
    } catch (e) {
      print(e);
    }
  }

    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: !cameraController!.value.isInitialized
                      ? Container()
                      : AspectRatio(
                          aspectRatio: cameraController!.value.aspectRatio,
                          child: CameraPreview(cameraController!),
                        ),
                ),
              ),
              Text(
                output,
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20 ,
                  color: Colors.black
                ),
              ),
            ],
          ),
        );
  }
}
