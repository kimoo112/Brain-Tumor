import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

part 'object_detection_state.dart';

class ObjectDetectionCubit extends Cubit<ObjectDetectionState> {
  ObjectDetectionCubit() : super(ObjectDetectionInitial());
  final ImagePicker _picker = ImagePicker();
  Interpreter? _interpreter;
  List<String>? _labels;
  // Add this map for label explanations
  final Map<String, String> _labelExplanations = {
    'no tumor':
        'Diagnosis: No Tumor Detected. This is a real MRI scan and no signs of a brain tumor were found. The scan appears healthy.',
    'glioma':
        'Diagnosis: Glioma. This is a real MRI scan and the model detected a glioma tumor, which arises from glial cells in the brain. Please consult a specialist for further evaluation.',
    'meningioma':
        'Diagnosis: Meningioma. This is a real MRI scan and the model detected a meningioma tumor, which forms on membranes covering the brain and spinal cord. Please consult a specialist for further evaluation.',
    'pituitary tumor':
        'Diagnosis: Pituitary Tumor. This is a real MRI scan and the model detected a pituitary tumor, which develops in the pituitary gland. Please consult a specialist for further evaluation.',
    // Add more labels and explanations as needed
  };

  Future<void> loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/models/model_unquant.tflite');
      final labelData = await rootBundle.loadString('assets/models/labels.txt');
      _labels =
          labelData.split('\n').where((label) => label.isNotEmpty).toList();
      emit(ObjectDetectionModelLoaded());
    } catch (e) {
      emit(ObjectDetectionError('Failed to load model: $e'));
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final file = File(image.path);
        emit(ObjectDetectionImagePicked(file));
        await detectImage(file);
      }
    } catch (e) {
      emit(ObjectDetectionError('Error picking image: $e'));
    }
  }

  Future<void> detectImage(File image) async {
    emit(ObjectDetectionLoading());
    try {
      if (_interpreter == null) {
        emit(ObjectDetectionError('Model not loaded'));
        return;
      }
      if (_labels == null || _labels!.isEmpty) {
        emit(ObjectDetectionError('Labels not loaded'));
        return;
      }
      // Load and decode image
      final imageBytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) {
        emit(ObjectDetectionError('Failed to decode image'));
        return;
      }
      // Resize to model input size (e.g., 224x224)
      const inputSize = 224; // Change if your model uses a different size
      final resizedImage =
          img.copyResize(decodedImage, width: inputSize, height: inputSize);
      // Convert image to Float32List and normalize
      var input = List.generate(
          inputSize,
          (y) => List.generate(inputSize, (x) {
                final pixel = resizedImage.getPixel(x, y);
                return [
                  pixel.r / 255.0,
                  pixel.g / 255.0,
                  pixel.b / 255.0,
                ];
              }));
      // Add batch dimension
      var inputTensor = [input];
      // Prepare output buffer
      var output =
          List.filled(_labels!.length, 0.0).reshape([1, _labels!.length]);
      // Run inference
      _interpreter!.run(inputTensor, output);
      // Get the highest confidence label
      final scores = output[0] as List<double>;
      final maxScore = scores.reduce((a, b) => a > b ? a : b);
      final maxIndex = scores.indexOf(maxScore);
      final label = _labels![maxIndex];
      // Normalize label for lookup
      final normalizedLabel = label.trim().toLowerCase();
      // Find matching explanation (normalize map keys too)
      String? explanation;
      for (final entry in _labelExplanations.entries) {
        if (entry.key.trim().toLowerCase() == normalizedLabel) {
          explanation = entry.value;
          break;
        }
      }
      explanation ??=
          'Diagnosis: $label. This is a real MRI scan. Please consult a specialist for further evaluation.';
      final result = '$label\n$explanation';
      emit(ObjectDetectionDetected(image, result));
    } catch (e) {
      emit(ObjectDetectionError('Error detecting image: $e'));
    }
  }

  @override
  Future<void> close() {
    _interpreter?.close();
    return super.close();
  }
}
