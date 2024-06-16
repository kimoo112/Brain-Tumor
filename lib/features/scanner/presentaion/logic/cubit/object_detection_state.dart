part of 'object_detection_cubit.dart';

@immutable
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
  final String result;
  ObjectDetectionDetected(this.image, this.result);
}

class ObjectDetectionError extends ObjectDetectionState {
  final String message;

  ObjectDetectionError(this.message);
}
