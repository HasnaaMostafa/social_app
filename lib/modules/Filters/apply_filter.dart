import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as image;

class ApplyFilter {
  static Uint8List applySepiaFilter(Uint8List original) {
    final decoded = image.decodeImage(original.toList())!;
    final sepia = image.sepia(decoded);
    final encoded = Uint8List.fromList(image.encodeJpg(sepia));
    return encoded;
  }

  static Uint8List applyGrayscaleFilter(Uint8List original) {
    final decoded = image.decodeImage(original.toList())!;
    final grayscale = image.grayscale(decoded);
    final encoded = Uint8List.fromList(image.encodeJpg(grayscale));
    return encoded;
  }

  static Uint8List applyBlurFilter(Uint8List original) {
    final decoded = image.decodeImage(original.toList())!;
    final blurred = image.gaussianBlur(decoded, 10);
    final encoded = Uint8List.fromList(image.encodeJpg(blurred));
    return encoded;
  }

  static Uint8List applyBrightnessFilter(Uint8List original) {
    final decoded = image.decodeImage(original.toList())!;
    final brightness = image.brightness(decoded, 100);
    final encoded = Uint8List.fromList(image.encodeJpg(brightness!));
    return encoded;
  }

  static Uint8List applyContrastFilter(Uint8List original) {
    final decoded = image.decodeImage(original.toList())!;
    final contrast = image.contrast(decoded, 1.5);
    final encoded = Uint8List.fromList(image.encodeJpg(contrast!));
    return encoded;
  }

  static Uint8List applyInvertFilter(Uint8List original) {
    final decoded = image.decodeImage(original.toList())!;
    final inverted = image.invert(decoded);
    final encoded = Uint8List.fromList(image.encodeJpg(inverted));
    return encoded;
  }
}
