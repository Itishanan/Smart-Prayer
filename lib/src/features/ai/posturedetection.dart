/*
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'posture_detection_controller.dart'; // Import the controller

class PostureDetection extends StatelessWidget {
  final PostureDetectionController controller = Get.put(PostureDetectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posture Detection'),
      ),
      body: Center(
        child: GetBuilder<PostureDetectionController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.imagePath != null)
                    Image.file(File(controller.imagePath!)),
                  if (controller.isLiveCameraEnabled && controller.isCameraInitialized)
                    CameraPreview(controller.cameraController),
                  SizedBox(height: 16),
                  controller.isLoading
                      ? CircularProgressIndicator()
                      : Text('Detected Label: ${controller.label ?? 'Unknown'}'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickFromGallery();
                    },
                    child: Text('Pick Image from Gallery'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.toggleLiveCamera(); // Add this method to toggle live camera view
                    },
                    child: Text('Toggle Live Camera'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.stopCamera(); // Add this method to stop camera and close TFLite model
                    },
                    child: Text('Stop'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
*/
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posture Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostureDetectionScreen(),
    );
  }
}

class PostureDetectionScreen extends StatefulWidget {
  @override
  _PostureDetectionScreenState createState() => _PostureDetectionScreenState();
}

class _PostureDetectionScreenState extends State<PostureDetectionScreen> {
  File? _image;
  final picker = ImagePicker();
  late Interpreter _interpreter;
  List<String> _labels = [];
  String _result = '';

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadLabels();
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model/pose_classifier.tflite');
  }

  Future<void> _loadLabels() async {
    final labelData = await File('assets/model/pose_labels.txt').readAsString();
    setState(() {
      _labels = labelData.split('\n');
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });

    if (_image != null) {
      await _classifyImage(_image!);
    }
  }

  Future<void> _classifyImage(File image) async {
    if (_labels.isEmpty) {
      setState(() {
        _result = 'Labels not loaded yet.';
      });
      return;
    }

    final inputImage = await _preprocessImage(image);
    final input = inputImage.buffer.asUint8List();

    var output = List<double>.filled(_labels.length, 0).reshape([1, _labels.length]);
    _interpreter.run(input, output);

    setState(() {
      _result = _labels[output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b))];
    });
  }

  Future<Uint8List> _preprocessImage(File imageFile) async {
    final image = await decodeImageFromList(imageFile.readAsBytesSync());
    final resizedImage = await _resizeImage(image, 224, 224);
    final inputImage = await _imageToByteListFloat32(resizedImage, 224, 224);
    return inputImage;
  }

  Future<ui.Image> _resizeImage(ui.Image image, int width, int height) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder)
      ..drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
        Paint(),
      );
    final resizedImage = await pictureRecorder.endRecording().toImage(width, height);
    return resizedImage;
  }

  Future<Uint8List> _imageToByteListFloat32(ui.Image image, int width, int height) async {
    final byteData = await image.toByteData();
    final buffer = Float32List(width * height * 3).buffer;
    final byteBuffer = buffer.asByteData();

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final pixelIndex = (y * width + x) * 4;
        final red = byteData!.getUint8(pixelIndex);
        final green = byteData.getUint8(pixelIndex + 1);
        final blue = byteData.getUint8(pixelIndex + 2);

        final index = y * width + x;
        byteBuffer.setFloat32(index * 3 + 0, red / 255.0);
        byteBuffer.setFloat32(index * 3 + 1, green / 255.0);
        byteBuffer.setFloat32(index * 3 + 2, blue / 255.0);
      }
    }
    return buffer.asUint8List();
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posture Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}