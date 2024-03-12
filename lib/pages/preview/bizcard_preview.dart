import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/preview/bizcard_preview_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cards/bloc/card_bloc.dart';
import '../contacts/bloc/contacts_bloc.dart';
import '../widgets/avatar_ph.dart';
import '../widgets/banner_ph.dart';
import '../widgets/divider_text.dart';

class BizcardPreview extends StatefulWidget {
  final String cardId;
  const BizcardPreview({super.key, required this.cardId});

  @override
  State<BizcardPreview> createState() => _BizcardPreviewState();
}

class _BizcardPreviewState extends State<BizcardPreview> {
  late BizcardPreviewViewModel _viewModel;

  @override
  void initState() {
    _viewModel = BizcardPreviewViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state is ContactCreated) {}
      },
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardDetailsFetched) {
            _viewModel.card = state.card;
            _viewModel.isOwnCard = state.ownCard;
          }

          print(_viewModel.card?.badges.length??0);

          return Scaffold(
            appBar: AppBar(
              title: Text(_viewModel.card?.cardName ?? ''),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(AntIcons.shareAltOutlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _viewModel.isOwnCard
                ? null
                : BlocBuilder<ContactsBloc, ContactsState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: FloatingActionButton.extended(
                            onPressed: (state is Creating || state is ContactCreated) 
                              ? null : () => context
                                .read<ContactsBloc>()
                                .add(SaveContactEvent(_viewModel.card!.id, _viewModel.card!.createdBy)),
                            label: state is Creating
                              ? const CircularProgressIndicator()
                              : Text(state is ContactCreated ? 'Saved' : 'Save Contact')),
                      );
                    },
                  ),
            body: ListView(
              padding: const EdgeInsets.only(bottom: 72),
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      BannerPH(image: _viewModel.card?.banner),
                      Positioned(
                          bottom: 0,
                          child: AvatarPH(
                            image: _viewModel.card?.picture,
                          )),
                    ],
                  ),
                ),
                const Gap(size: 16),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      '${_viewModel.card?.name?.firstName ?? ''} ${_viewModel.card?.name?.middleName ?? ''} ${_viewModel.card?.name?.lastName ?? ''}',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const Gap(size: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Visibility(
                      visible: _viewModel.card?.bio != null,
                      child: (_viewModel.card?.bio??'')
                          .btext(context, color: 'dark', align: 'center')),
                ),
                Divider(
                    height: 32,
                    color: Colors.grey[200],
                    indent: 50,
                    endIndent: 50),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: _viewModel.card?.logo != null
                        ? NetworkImage(_viewModel.card!.logo!)
                        : null,
                    child: _viewModel.card?.logo == null
                        ? const Icon(Icons.business)
                        : null,
                  ),
                  title: Text(
                    _viewModel.card?.company?.companyName ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: (_viewModel.card?.company?.department ?? '')
                      .btext(context, color: 'dark'),
                ),
                Visibility(
                    visible: _viewModel.card?.address != null,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      leading: const Icon(AntIcons.pushpinOutlined),
                      title: Text(_viewModel.card?.address?.string() ?? ''),
                    )),
                Visibility(
                    visible: _viewModel.card?.email != null,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      leading: const Icon(AntIcons.mailOutlined),
                      title: Text(_viewModel.card?.email ?? ''),
                    )),
                Visibility(
                    visible: _viewModel.card?.phoneNumber != null,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      leading: const Icon(AntIcons.phoneOutlined),
                      title: Text(_viewModel.card?.phoneNumber??''),
                    )),
                Visibility(
                    visible: _viewModel.card?.company?.companyWebsite != null,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      leading: const Icon(AntIcons.globalOutlined),
                      title: Text(_viewModel.card?.company?.companyWebsite??''),
                    )),
                const Gap(size: 16),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16),
                      itemCount: _viewModel.card?.badges.length??0,
                      itemBuilder: (_, idx) {
                        return Image.network(_viewModel.card?.badges[idx]??'');
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Visibility(
                      visible:
                          _viewModel.card?.company?.companyDescription != null,
                      child: MainCard(
                          child: (_viewModel.card?.company?.companyDescription??'')
                              .btext(context, color: 'dark', align: 'center'))),
                ),
                const Gap(size: 32),
                const DividerText(text: 'Follow Me On'),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _viewModel.card?.fields.length??0,
                    itemBuilder: (_, index) {
                      var item = _viewModel.card!.fields[index];
                      return Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/${item.icon}', width: 80,),
                            ),
                          ),
                          // item.title.btext(context, align: "center", color: 'dark')
                        ],
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
