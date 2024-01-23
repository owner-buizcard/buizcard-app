import 'dart:io';

import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanViewModel extends BaseViewModel {
  
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  late TextRecognizer textRecognizer;
  late List<TextBlock> textBlocks;
  late ValueNotifier<bool> camInit;
  late CameraController camController;

  late ValueNotifier<bool> scanCode;

  ValueNotifier<bool> isExtracting = ValueNotifier(false);

  ScanViewModel(){
    scanCode = ValueNotifier(false);

    textRecognizer = GoogleMlKit.vision.textRecognizer();
    textBlocks = [];
    camInit = ValueNotifier(false);
    openCamera();

    scanCode.addListener(() { 
      if(scanCode.value){
        closeCamera();
      }else{
        openCamera();
      }
    });
  }

  openCamera(){
    camController = CameraController(Global.cameras[0], ResolutionPreset.max);
    camController.initialize().then((value) => camInit.value = true);
  }

  closeCamera(){
    camInit.value = false;
    camController.dispose();
  }

  Future<String> captureImage()async{
    XFile result = await camController.takePicture();
    File file = File(result.path);
    return await startTextRecognition(file);
  }

  Future<String> startTextRecognition(File file) async {
    try {
      isExtracting.value = true;
      final inputImage = InputImage.fromFile(file);
      final results = await textRecognizer.processImage(inputImage);
      textBlocks = results.blocks;
      var extracted = textBlocks.map((e) => e.text.toString()).toList().join(' ');
      return extracted;
    } catch (e) {
      isExtracting.value = false;
      return '';
    }
  }

  String extractText() {
    return textBlocks.map((block) => block.text).join(' ');
  }
  
  onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {

    });
  }
  
  @override
  void dispose() {
    camController.dispose();
    textRecognizer.close();
    controller?.dispose();
  }
}