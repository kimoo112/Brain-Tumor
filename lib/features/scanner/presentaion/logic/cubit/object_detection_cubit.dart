import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tflite_v2/tflite_v2.dart';

part 'object_detection_state.dart';

class ObjectDetectionCubit extends Cubit<ObjectDetectionState> {
  ObjectDetectionCubit() : super(ObjectDetectionInitial());
  final ImagePicker _picker = ImagePicker();
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
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
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      emit(ObjectDetectionDetected(recognitions.toString()));
    } catch (e) {
      emit(ObjectDetectionError('Error detecting image: $e'));
    }
  }
}