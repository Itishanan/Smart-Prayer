import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'package:tflite_v2/tflite_v2.dart';

class PostureDetectionController extends GetxController {
  late CameraController cameraController;
  bool isCameraInitialized = false;
  bool isLiveCameraEnabled = false; // Track live camera view state
  List? results;
  bool isLoading = false;
  String? label = 'Unknown';
  String? imagePath; // Track selected image path

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    loadModel();
  }

  initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false, // If audio is not needed, set enableAudio to false
    );

    try {
      await cameraController.initialize();
      isCameraInitialized = true;
      update(); // Notify GetX to update the UI

      if (isLiveCameraEnabled) {
        cameraController.startImageStream((CameraImage image) {
          var bytesList = image.planes.map((plane) => plane.bytes).toList();
          classifyImage(bytesList, image.width, image.height);
        });
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model/pose_classifier.tflite",
      labels: "assets/model/pose_labels.txt",
    );
    if (kDebugMode) {
      print("Model loading status: $res");
    }
  }

  classifyImage(List<Uint8List> bytesList, int imageWidth, int imageHeight) async {
    if (isLoading) return;

    isLoading = true;
    update(); // Notify GetX to update the UI

    var recognitions = await Tflite.runModelOnFrame(
      bytesList: bytesList,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 2,
      threshold: 0.1,
      asynch: true,
    );

    results = recognitions;
    label = recognitions!.isNotEmpty ? recognitions[0]['label'] : 'Unknown';

    isLoading = false;
    update(); // Notify GetX to update the UI
  }

  pickFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path; // Update the selected image path
      classifyImage([File(pickedFile.path).readAsBytesSync()], 0, 0); // Pass 0 as width and height for gallery images
    }
  }

  toggleLiveCamera() {
    isLiveCameraEnabled = !isLiveCameraEnabled;
    if (isLiveCameraEnabled) {
      cameraController.startImageStream((CameraImage image) {
        var bytesList = image.planes.map((plane) => plane.bytes).toList();
        classifyImage(bytesList, image.width, image.height);
      });
    } else {
      cameraController.stopImageStream();
    }
    update(); // Notify GetX to update the UI
  }

  stopCamera() {
    cameraController.stopImageStream(); // Stop the camera stream
    Tflite.close(); // Close the TFLite model
    update(); // Notify GetX to update the UI
  }

  @override
  void onClose() {
    cameraController.dispose(); // Dispose of camera controller
    super.onClose();
  }
}
