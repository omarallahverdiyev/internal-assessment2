import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internal_assessment_app/seller/adding/image_item.dart';
class ImageSelection extends StatefulWidget {
  const ImageSelection({super.key, required this.onImagesSelected});

  final Function(List<ImageItem>) onImagesSelected;

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  final List<ImageItem> _images = [];

  void _addImages() {

    showAdaptiveDialog(context: context, builder: (context) => AlertDialog.adaptive(
      title: const Text('Pick method'),
      content: Center(
        child: SizedBox(
          height: 100,
          child: IntrinsicWidth(
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      preferredCameraDevice: CameraDevice.rear,
                      imageQuality: 100,
                      maxHeight: 500,
                      maxWidth: 500,
                    );
                    if (image != null) {
                      setState(
                        () {
                          _images
                              .add(ImageItem(image: FileImage(File(image.path))));
                              widget.onImagesSelected(_images);
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.camera),
                ),
                IconButton(
                    onPressed: () async {
                      final images = await ImagePicker().pickMultiImage();
                      setState(() {
                        for (var image in images) {
                          _images
                              .add(ImageItem(image: FileImage(File(image.path))));
                              widget.onImagesSelected(_images);
                        }
                      });
                    },
                    icon: const Icon(Icons.image))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        onReorder: (int oldIndex, int newIndex) {
          setState(
            () {
              final image = _images.removeAt(oldIndex);
              _images.insert(newIndex, image);
              widget.onImagesSelected(_images);
            },
          );
        },
        children: [
          for (final image in _images)
            Stack(
              key: ValueKey(image.key),
              children: [
                Image(image: image.image, width: 160, height: 200),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          _images.remove(image);
                          widget.onImagesSelected(_images);
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          IconButton(
            key: const ValueKey('add button'),
            onPressed: _addImages,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
