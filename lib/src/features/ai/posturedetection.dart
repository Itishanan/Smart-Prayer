import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';
class PostureDetection extends StatefulWidget {
  const PostureDetection({Key? key}) : super(key: key);

  @override
  _PostureDetectionState createState() => _PostureDetectionState();
}

class _PostureDetectionState extends State<PostureDetection> {
  late PoseDetector poseDetector;
  List<PoseLandmark> _landmarks = [];
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    poseDetector = PoseDetector(
      options: PoseDetectorOptions(
        mode: PoseDetectionMode.single,
        model: PoseDetectionModel.accurate,
      ),
    );
  }

  @override
  void dispose() {
    poseDetector.close();
    super.dispose();
  }

  Future<void> _detectPose() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _loadImageBytes(); // Load image bytes
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final poses = await poseDetector.processImage(inputImage);
      if (poses.isNotEmpty) {
        setState(() {
          _landmarks = poses.first.landmarks.values.toList();
        });
      }
    }
  }

  Future<void> _loadImageBytes() async {
    if (_image != null) {
      _imageBytes = await _image!.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Posture Detection'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_imageBytes != null)
              FutureBuilder<void>(
                future: _loadImageBytes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While loading, show a loading indicator
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // Once loading is complete, show the result
                    return Container(
                      height: 200,
                      width: 200,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CustomPaint(
                          painter: PosePainter(_imageBytes!, _landmarks, context),
                        ),
                      ),
                    );
                  }
                },
              ),
            ElevatedButton(
              onPressed: _detectPose,
              child: Text('Select Image and Detect Pose'),
            ),
          ],
        ),
      ),
    );
  }
}

class PosePainter extends CustomPainter {
  final Uint8List imageBytes;
  final List<PoseLandmark> landmarks;
  final BuildContext context;

  PosePainter(this.imageBytes, this.landmarks, this.context);

  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Load the image using Image.memory
    final imageWidget = Image.memory(imageBytes);
    final imgSize = Size(imageWidget.width!.toDouble(), imageWidget.height!.toDouble());

    // Resolve the image
    await precacheImage(imageWidget.image, context);

    // Draw the image on canvas
    imageWidget.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo info, bool _) {
          final img = info.image;
          final srcRect = Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble());
          final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
          canvas.drawImageRect(img, srcRect, dstRect, paint);

          // Draw landmarks
          for (final landmark in landmarks) {
            final landmarkX = landmark.x * size.width;
            final landmarkY = landmark.y * size.height;
            canvas.drawCircle(Offset(landmarkX, landmarkY), 5, paint);
          }
        },
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
