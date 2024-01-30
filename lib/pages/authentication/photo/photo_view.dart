import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/authentication/photo/photo_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/avatar_ph.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';
import '../bloc/auth_bloc.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late PhotoViewModel _viewModel;

  @override
  void initState() {
    _viewModel = PhotoViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is PhotoSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (route) => false);
              }
            },
          ),
          BlocListener<ImageBloc, ImageState>(
            listener: (context, state) {
              if(state is UploadedSuccess && state.type=='picture'){
                _viewModel.picture.value = state.link;
              }
            },
          ),
        ],
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Text('Set your photo',
                style: Theme.of(context).textTheme.titleMedium),
            'Make your profile more engaging'.btext(context),
            const Gap(size: 80),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 140,
                width: 140,
                child: ValueListenableBuilder(
                    valueListenable: _viewModel.picture,
                    builder: (_, value, __) {
                      return Stack(
                        children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(70),
                              onTap: () async => await _viewModel.pickImage(
                                  context, 'picture'),
                              child: AvatarPH(
                                image: value,
                                radius: 70,
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(18),
                                color: const Color(0x80000000),
                              ),
                              child: const Icon(AntIcons.cameraOutlined,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            const Gap(size: 80),
            ValueListenableBuilder(
              valueListenable: _viewModel.picture,
              builder: (_, val, __) {
                bool enable = val!=null && val.isNotEmpty;
                return ElevatedButton(
                  onPressed: enable ? (){ 
                    context.read<AuthBloc>().add(UploadPictureEvent(picture: _viewModel.picture.value!));
                  } : null,
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    side: const MaterialStatePropertyAll(BorderSide.none),
                    backgroundColor: MaterialStatePropertyAll(enable ? null : Colors.grey ),
                  ),
                  child: const Text('Continue')
                );
              }
            ),
            const Gap(size: 24),
            TextButton(onPressed: () {
              context.read<AuthBloc>().add(InitAppEvent());
            }, child: const Text('Skip'))
          ],
        ),
      ),
    );
  }
}
