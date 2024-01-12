import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/scan/scan_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: _viewModel.qrKey,
              onQRViewCreated: _viewModel.onQRViewCreated,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x268c8c8c)),
              borderRadius: BorderRadius.circular(6)
            ),
            child: const Column(
              children: [
                ListTile(
                  leading: Icon(AntIcons.creditCardOutlined),
                  title: Text('Scan a paper card'),
                  trailing: Icon(AntIcons.checkCircleFilled),
                ),
                Divider(color: Color(0x268c8c8c)),
                ListTile(
                  leading: Icon(AntIcons.qrcodeOutlined),
                  title: Text('Scan a Qr code'),
                  trailing: Icon(AntIcons.checkCircleFilled),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainCard(
                  width: 100,
                  child: Column(
                    children: [
                      Icon(AntIcons.uploadOutlined),
                      Gap(size: 8),
                      Text('Upload')
                    ],
                )),

                CircleAvatar(
                  radius: 38,
                  child: Icon(AntIcons.scanOutlined, size: 32),
                ),

                MainCard(
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

        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}