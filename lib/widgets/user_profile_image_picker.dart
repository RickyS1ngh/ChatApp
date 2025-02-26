import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImagePicker extends StatefulWidget {
  const UserProfileImagePicker(this.onSelectedImage, {super.key});
  final void Function(File image) onSelectedImage;

  @override
  State<UserProfileImagePicker> createState() => _UserProfileImagePickerState();
}

class _UserProfileImagePickerState extends State<UserProfileImagePicker> {
  File? _selectedImage;

  void _takeProfileImage() async {
    final imagePicker = ImagePicker();
    final imagePicked = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (imagePicked == null) {
      return;
    }

    setState(() {
      _selectedImage = File(imagePicked.path);
    });

    widget.onSelectedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            foregroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null),
        TextButton.icon(
          onPressed: _takeProfileImage,
          label: Text(
            'Add Profile Picture',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: const Icon((Icons.image)),
        )
      ],
    );
  }
}
