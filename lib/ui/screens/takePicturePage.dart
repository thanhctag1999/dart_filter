import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;

  const TakePicturePage({Key? key, required this.camera}) : super(key: key);

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  late CameraController _cameraController;
  late Future _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.max);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      if (!_cameraController.value.isTakingPicture) {
        XFile image = await _cameraController.takePicture();
        if (!mounted) return;
        Navigator.pop(context, image);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
              const SnackBar(content: Text('Already taking a picture.')));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _toggleCamera() async {
    // Ensure that the camera controller is initialized
    await _initializeCameraControllerFuture;

    // Get the current camera description
    CameraDescription currentCamera = _cameraController.description;

    // Get a list of all available cameras
    List<CameraDescription> cameras = await availableCameras();

    // Find the index of the current camera in the list
    int currentIndex =
        cameras.indexWhere((camera) => camera.name == currentCamera.name);

    // Calculate the index of the next camera (toggle between front and back cameras)
    int nextIndex = (currentIndex + 1) % cameras.length;

    // Get the next camera description
    CameraDescription nextCamera = cameras[nextIndex];

    // Dispose the current camera controller
    await _cameraController.dispose();

    // Initialize the camera controller with the next camera
    _cameraController = CameraController(
      nextCamera,
      ResolutionPreset.medium, // Adjust the resolution preset as needed
    );

    // Initialize the camera controller asynchronously
    _initializeCameraControllerFuture = _cameraController.initialize();

    // Refresh the UI to display the camera preview from the new camera
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 235, 184, 0),
        child: const Icon(Icons.camera),
        onPressed: () => _takePicture(context),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.flip_camera_ios,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              // Call a function to toggle between front and back cameras
              _toggleCamera();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(_cameraController),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
