import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sociall_app_2/modules/Filters/apply_filter.dart';

import 'progress_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen(
      {super.key, required this.postImage, required this.onSaveImage});

  final File postImage;
  final void Function(Uint8List?) onSaveImage;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _showProgress = false;
  Uint8List? _image;
  Uint8List? _originalImage;
  Uint8List? _filteredImage;

  @override
  void initState() {
    super.initState();
    _loadImageSync(widget.postImage.path);
    _saveImage();
  }

  void _loadImageSync(String? path) {
    if (path == null) return;

    setState(() {
      _showProgress = true;
    });
    final image = File(path).readAsBytesSync();
    setState(() {
      _image = image;
      _originalImage = image;
      _showProgress = false;
    });
  }

  Future<void> _loadImageAsync(String? path) async {
    if (path == null) return;

    setState(() {
      _showProgress = true;
    });
    final image = await File(path).readAsBytes();
    setState(() {
      _image = image;
      _originalImage = image;
      _showProgress = false;
    });
  }

  void _applySepiaSync() async {
    setState(() {
      _showProgress = true;
    });
    final image = ApplyFilter.applySepiaFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
    // await Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NewPostsScreen(filteredImage: image),
    //   ),
    //   (route) => false,
    // );
  }

  void _applySepiaAsync() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final image = ApplyFilter.applySepiaFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applySepiaInIsolate() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(ApplyFilter.applySepiaFilter, _image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyGrayscaleSync() {
    setState(() {
      _showProgress = true;
    });
    final image = ApplyFilter.applyGrayscaleFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyGrayscaleAsync() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final image = ApplyFilter.applyGrayscaleFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyGrayscaleIsolate() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(ApplyFilter.applyGrayscaleFilter, _image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyBlurSync() {
    setState(() {
      _showProgress = true;
    });
    final image = ApplyFilter.applyBlurFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyBlurAsync() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final image = ApplyFilter.applyBlurFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyBlurIsolate() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(ApplyFilter.applyBlurFilter, _image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyBrightnessSync() {
    setState(() {
      _showProgress = true;
    });
    final image = ApplyFilter.applyBrightnessFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyBrightnessAsync() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final image = ApplyFilter.applyBrightnessFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyBrightnessIsolate() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(ApplyFilter.applyBrightnessFilter, _image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyContrastSync() {
    setState(() {
      _showProgress = true;
    });
    final image = ApplyFilter.applyContrastFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyContrastAsync() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final image = ApplyFilter.applyContrastFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyContrastIsolate() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(ApplyFilter.applyContrastFilter, _image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyInvertSync() {
    setState(() {
      _showProgress = true;
    });
    final image = ApplyFilter.applyInvertFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyInvertAsync() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final image = ApplyFilter.applyInvertFilter(_image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _applyInvertIsolate() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(ApplyFilter.applyInvertFilter, _image!);
    setState(() {
      _image = image;
      _filteredImage = _image;
      widget.onSaveImage(_filteredImage);
      _showProgress = false;
    });
  }

  void _undo() {
    setState(() {
      _filteredImage = null;
      _image = _originalImage;
      widget.onSaveImage(_image);
    });
  }

  // void _clear() {
  //   setState(() {
  //     SocialCubit.get(context).postImage=null;
  //     _image = null;
  //     _filteredImage = null;
  //     widget.onSaveImage(_image);
  //   });
  // }

  void _saveImage() async {
    if (_filteredImage != null) {
      setState(() {
        widget.onSaveImage(_filteredImage);
      });
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => NewPostsScreen(
      //             filteredImage: _image,
      //           )),
      //   (route) => false,
      //); // Pop with the filtered image
    }
  }

  @override
  void dispose() {
    // _saveImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   IconButton(
          //       onPressed: _saveImage, icon: const Icon(IconBroken.Shield_Done))
          // ],
          ),
      body: Stack(
        children: [
          if (_image != null)
            Center(
              child: Image.memory(_image!, gaplessPlayback: true),
            ),
          ProgressWidget(show: _showProgress),
          if (_filteredImage != null)
            Center(
              child: Image.memory(_filteredImage!),
            ),
          ProgressWidget(show: _showProgress),
        ],
      ),
      persistentFooterButtons: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applySepiaSync : null,
                child: const Text('Sepia (sync)'),
              ),
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applySepiaAsync : null,
                child: const Text('Sepia (async)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applySepiaInIsolate
                    : null,
                child: const Text('Sepia (isolate)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyGrayscaleSync
                    : null,
                child: const Text('Grayscale (sync)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyGrayscaleAsync
                    : null,
                child: const Text('Grayscale (async)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyGrayscaleIsolate
                    : null,
                child: const Text('Grayscale (isolate)'),
              ),
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applyBlurSync : null,
                child: const Text('Blur (sync)'),
              ),
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applyBlurAsync : null,
                child: const Text('Blur (async)'),
              ),
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applyBlurIsolate : null,
                child: const Text('Blur (isolate)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyBrightnessSync
                    : null,
                child: const Text('Bright (sync)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyBrightnessAsync
                    : null,
                child: const Text('Bright (async)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyBrightnessIsolate
                    : null,
                child: const Text('Bright (isolate)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyContrastSync
                    : null,
                child: const Text('Contrast (sync)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyContrastAsync
                    : null,
                child: const Text('Contrast (async)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyContrastIsolate
                    : null,
                child: const Text('Contrast (isolate)'),
              ),
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applyInvertSync : null,
                child: const Text('Invert (sync)'),
              ),
              TextButton(
                onPressed:
                    !_showProgress && _image != null ? _applyInvertAsync : null,
                child: const Text('Invert (async)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null
                    ? _applyInvertIsolate
                    : null,
                child: const Text('Invert (isolate)'),
              ),
              TextButton(
                onPressed: !_showProgress && _image != null ? _undo : null,
                child: const Text('Undo'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
