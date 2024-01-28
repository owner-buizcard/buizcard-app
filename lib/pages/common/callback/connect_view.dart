import 'package:bizcard_app/pages/settings/bloc/settings_bloc.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/gap.dart';

class ConnectView extends StatefulWidget {
  final String url;
  const ConnectView({super.key, required this.url});

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  @override
  void initState() {
    context.read<SettingsBloc>().add(IntegrateEvent(url: widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if(state is Success){
          Navigator.pushNamed(context, Routes.home);
        }else if(state is Failure){
          toast('Connection failed', success: false);
          Navigator.pushNamed(context, Routes.home);
        }
      },
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(strokeWidth: 2)),
              Gap(size: 32),
              Text('Connecting...'),
            ],
          ),
        ),
      ),
    );
  }
}
