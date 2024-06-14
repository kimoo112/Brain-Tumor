part of 'object_detection_cubit.dart';

@immutable
sealed class ObjectDetectionState {}

final class ObjectDetectionInitial extends ObjectDetectionState {}
class ObjectDetectionModelLoaded extends ObjectDetectionState {}

class ObjectDetectionImagePicked extends ObjectDetectionState {
  final File image;

  ObjectDetectionImagePicked(this.image);
}

class ObjectDetectionDetected extends ObjectDetectionState {
  final String result;

  ObjectDetectionDetected(this.result);
}

class ObjectDetectionError extends ObjectDetectionState {
  final String message;

  ObjectDetectionError(this.message);
}