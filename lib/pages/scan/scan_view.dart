import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/scan/scan_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../routes/app_routes.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late ScanViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ScanViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        leadingWidth: 30,
      ),
      body: ValueListenableBuilder(
        valueListenable: _viewModel.scanCode,
        builder: (_, value, __) {
          return Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: value,
                  replacement: ValueListenableBuilder(
                    valueListenable: _viewModel.camInit,
                    builder: (_, value, __) {
                      if(!value){
                        return Container();
                      }
                      return AspectRatio(
                          aspectRatio: _viewModel.camController.value.aspectRatio,
                          child: CameraPreview(_viewModel.camController)  
                      );
                    }
                  ),
                  child: QRView(
                    key: _viewModel.qrKey,
                    onQRViewCreated: _viewModel.onQRViewCreated,
                  )
                )
              ),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x268c8c8c)),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: ()=>_viewModel.scanCode.value = false,
                      leading: const Icon(AntIcons.creditCardOutlined),
                      title: const Text('Scan a paper card'),
                      trailing: Visibility(
                        visible: !value,
                        child: const Icon(AntIcons.checkCircleFilled)),
                    ),
                    const Divider(color: Color(0x268c8c8c)),
                    ListTile(
                      onTap: ()=>_viewModel.scanCode.value = true,
                      leading: const Icon(AntIcons.qrcodeOutlined),
                      title: const Text('Scan a Qr code'),
                      trailing: Visibility(
                        visible: value,
                        child: const Icon(AntIcons.checkCircleFilled)),
                    ),
                  ],
                ),
              ),
          
              Visibility(
                visible: !value,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MainCard(
                        width: 100,
                        child: Column(
                          children: [
                            Icon(AntIcons.uploadOutlined),
                            Gap(size: 8),
                            Text('Upload')
                          ],
                      )),
                          
                      ValueListenableBuilder(
                        valueListenable: _viewModel.isExtracting,
                        builder: (_, extracting, __) {
                          return InkWell(
                            onTap: ()async{
                              if(!extracting){
                                await _viewModel.captureImage().then(
                                  (value) => Navigator.pushNamed(context, Routes.extracter, arguments: value));
                              }
                            },
                            child: CircleAvatar(
                              radius: 38,
                              child: extracting
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Icon(AntIcons.scanOutlined, size: 32),
                            ),
                          );
                        }
                      ),
                          
                      const MainCard(
                        width: 100,
                        child: Column(
                        children: [
                          Icon(Icons.bolt),
                          Gap(size: 8),
                          Text('Flash')
                        ],
                      )),
                          
                    ],
                  ),
                ),
              ),
          
            ],
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}