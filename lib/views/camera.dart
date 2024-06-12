import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: const Color.fromRGBO(122, 198, 189, 1),
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  child: const Text(
                    "Select from Gallery",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(width: 16),
                MaterialButton(
                  color: const Color.fromRGBO(122, 198, 189, 1),
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                  child: const Text(
                    "Capture Photo",
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
