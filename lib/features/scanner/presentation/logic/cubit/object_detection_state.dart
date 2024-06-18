part of 'object_detection_cubit.dart';

sealed class ObjectDetectionState {}

final class ObjectDetectionInitial extends ObjectDetectionState {}

class ObjectDetectionLoading extends ObjectDetectionState {}

class ObjectDetectionModelLoaded extends ObjectDetectionState {}

class ObjectDetectionImagePicked extends ObjectDetectionState {
  final File image;

  ObjectDetectionImagePicked(this.image);
}

class ObjectDetectionDetected extends ObjectDetectionState {
  final File image;
  final String recognition;
  ObjectDetectionDetected(this.image, this.recognition);
}

class ObjectDetectionError extends ObjectDetectionState {
  final String errMessage;

  ObjectDetectionError(this.errMessage);
}
