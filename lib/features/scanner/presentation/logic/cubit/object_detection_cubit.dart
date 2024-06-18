import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

part 'object_detection_state.dart';

class ObjectDetectionCubit extends Cubit<ObjectDetectionState> {
  ObjectDetectionCubit() : super(ObjectDetectionInitial());
  final ImagePicker _picker = ImagePicker();

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/models/model_unquant.tflite",
        labels: "assets/models/labels.txt",
      );
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
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      String formattedResult = _formatRecognitions(recognitions);
      emit(ObjectDetectionDetected(image, formattedResult.toString()));
    } catch (e) {
      emit(ObjectDetectionError('Error detecting image: $e'));
    }
  }

  String _formatRecognitions(List<dynamic>? recognitions) {
    if (recognitions == null || recognitions.isEmpty) {
      return 'No objects detected';
    }

    StringBuffer buffer = StringBuffer();
    for (var recognition in recognitions) {
      buffer.writeln('${recognition["label"]}');
    }
    return buffer.toString();
  }
}
