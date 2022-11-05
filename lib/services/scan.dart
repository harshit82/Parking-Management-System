import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _text = "TEXT";

  late Size _previewOcr;

  ///
  /// OCR Method
  ///
  Future<void> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
        fps: 5.0,
      );
      setState(() => _text = texts[0].value);
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((previewSizes) => setState(() {
          _previewOcr = previewSizes[_cameraOcr]!.first;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _read(),
          child: const Icon(Icons.scanner),
        ),
        body: Center(
          child: Text(
            _text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
