import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';
import '../../widgets/gap.dart';
import '../bloc/card_bloc.dart';

class BadgesView extends StatefulWidget {
  final String cardId;
  const BadgesView({super.key, required this.cardId});

  @override
  State<BadgesView> createState() => _BadgesViewState();
}

class _BadgesViewState extends State<BadgesView> {
  late List badges;

  @override
  void initState() {
    var card =
        Global.cards.value.firstWhere((element) => element.id == widget.cardId);
    badges = [...card.badges];
    super.initState();
  }

  pickImage(BuildContext context, String type) {
    context.read<ImageBloc>().add(UploadImageEvent(path: type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if(state is Success){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Badges'),
          actions: [
            TextButton(
              onPressed: () => {
                context.read<CardBloc>().add(SaveCardEvent(widget.cardId,  {'badges': badges}))
              }, 
              child: const Text("Save")),
            const Gap(size: 8)
          ],
        ),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is UploadedSuccess) {
              badges.add(state.link);
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16),
                    itemCount: badges.length,
                    itemBuilder: (_, idx) {
                      return Image.network(badges[idx]);
                    }),
                Visibility(
                  visible: badges.length < 6,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    child: ElevatedButton(
                        onPressed: badges.length < 6
                            ? () async => await pickImage(context, 'badge')
                            : null,
                        child: const Text('Add Badge')),
                  ),
                ),
                const Text("You can upload maximum 6 badges")
              ],
            );
          },
        ),
      ),
    );
  }
}
