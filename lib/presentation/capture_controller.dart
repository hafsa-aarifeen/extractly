import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/extraction_result.dart';
import 'providers.dart';

/// What the capture screen is currently doing.
enum CaptureStatus { idle, working, done, error }

/// Immutable snapshot of the capture flow's state.
@immutable
class CaptureState {
  const CaptureState({
    this.status = CaptureStatus.idle,
    this.result,
    this.imageBytes,
    this.message,
  });

  final CaptureStatus status;
  final ExtractionResult? result;
  final Uint8List? imageBytes;
  final String? message;

  CaptureState copyWith({
    CaptureStatus? status,
    ExtractionResult? result,
    Uint8List? imageBytes,
    String? message,
  }) {
    return CaptureState(
      status: status ?? this.status,
      result: result ?? this.result,
      imageBytes: imageBytes ?? this.imageBytes,
      message: message ?? this.message,
    );
  }
}

/// Drives: pick image → call Gemini → expose the result for the review screen.
class CaptureController extends StateNotifier<CaptureState> {
  CaptureController(this._ref) : super(const CaptureState());

  final Ref _ref;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickAndExtract(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: 1600, // downscale before upload — smaller, faster, cheaper
        imageQuality: 85,
      );
      if (picked == null) {
        return; // user cancelled the picker
      }

      final bytes = await picked.readAsBytes();
      state = CaptureState(status: CaptureStatus.working, imageBytes: bytes);

      final service = _ref.read(geminiExtractionServiceProvider);
      final result = await service.extract(bytes);

      state = state.copyWith(status: CaptureStatus.done, result: result);
    } catch (e) {
      state = CaptureState(
        status: CaptureStatus.error,
        message: 'Something went wrong: $e',
      );
    }
  }

  void reset() => state = const CaptureState();
}

final captureControllerProvider =
    StateNotifierProvider<CaptureController, CaptureState>((ref) {
      return CaptureController(ref);
    });
