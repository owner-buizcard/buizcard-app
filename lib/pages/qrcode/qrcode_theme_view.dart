import 'dart:io';

import 'package:bizcard_app/constants/constants.dart';
import 'package:bizcard_app/pages/common/image/image_bloc.dart';
import 'package:bizcard_app/pages/qrcode/qrcode_theme_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/color_picker_field_wl.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/single_select_wl.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../cards/bloc/card_bloc.dart';

class QrcodeThemeView extends StatefulWidget {
  final String cardId;
  const QrcodeThemeView({super.key, required this.cardId});

  @override
  State<QrcodeThemeView> createState() => _QrcodeThemeViewState();
}

class _QrcodeThemeViewState extends State<QrcodeThemeView> {
  late QrcodeThemeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = QrcodeThemeViewModel(widget.cardId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if(state is Success){
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QrCode Theme'),
          actions: [
            TextButton(
                onPressed: () => _viewModel.onSave(context),
                child: const Text("Save")),
            const Gap(size: 8)
          ],
        ),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is PickedSuccess) {
              _viewModel.logopath = state.path;
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: QrImageView(
                      size: 200,
                      data: _viewModel.card.cardLink!,
                      gapless: false,
                      dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape:
                              _viewModel.qrinfo?.codeStyle == "dots"
                                  ? QrDataModuleShape.circle
                                  : QrDataModuleShape.square,
                          color: Global.hexToColor(
                              _viewModel.qrinfo?.fgColor ?? '#000000')),
                      eyeStyle: QrEyeStyle(
                          eyeShape: _viewModel.qrinfo?.eyeStyle == "circle"
                              ? QrEyeShape.circle
                              : QrEyeShape.square,
                          color: Global.hexToColor(
                              _viewModel.qrinfo?.eyeColor ?? '#000000')),
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size(50, 50),
                      ),
                      embeddedImage: state is PickedSuccess
                          ? FileImage(File(_viewModel.logopath!))
                          : _viewModel.qrinfo?.logo != null
                              ? NetworkImage(_viewModel.qrinfo!.logo!)
                                  as ImageProvider
                              : null),
                ),
                const Gap(size: 32),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () => context.read<ImageBloc>().add(
                              const UploadImageEvent(
                                  path: 'qr-code', upload: false)),
                          child: const Text('Upload Image'))),
                ),
                const Gap(size: 20),
                SingleSelectWL(
                    label: 'Code Style',
                    items: Constants.qrCodeStyle,
                    value: _viewModel.qrinfo?.codeStyle,
                    onChanged: (e) {
                      var qr = _viewModel.qrinfo?.copyWith(codeStyle: e);
                      _viewModel.qrinfo = qr;
                      setState(() {});
                    }),
                const Gap(size: 20),
                SingleSelectWL(
                  label: 'Eye Style',
                  items: Constants.qrEyeStyle,
                  value: _viewModel.qrinfo?.eyeStyle,
                  onChanged: (e) {
                    var qr = _viewModel.qrinfo?.copyWith(eyeStyle: e);
                    _viewModel.qrinfo = qr;
                    setState(() {});
                  },
                ),
                const Gap(size: 24),
                ColorPickerFieldWL(
                  label: 'QrCode color',
                  selected: _viewModel.qrinfo?.fgColor ?? "#000000",
                  onClick: (v) {
                    var qr = _viewModel.qrinfo?.copyWith(fgColor: v);
                    _viewModel.qrinfo = qr;
                    setState(() {});
                  },
                ),
                const Gap(size: 24),
                ColorPickerFieldWL(
                  label: 'Eye color',
                  selected: _viewModel.qrinfo?.eyeColor ?? "#000000",
                  onClick: (v) {
                    var qr = _viewModel.qrinfo?.copyWith(eyeColor: v);
                    _viewModel.qrinfo = qr;
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
