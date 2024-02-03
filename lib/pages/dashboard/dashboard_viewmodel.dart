import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/pages/cards/bloc/card_bloc.dart';
import 'package:bizcard_app/pages/contacts/bloc/contacts_bloc.dart';
import 'package:bizcard_app/pages/contacts/bottomsheets/export_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/add_tag_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/card_options_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/card_settings_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/contact_options_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/create_card_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/mail_sheet.dart';
import 'package:bizcard_app/pages/dashboard/cubit/bottomnav_cubit.dart';
import 'package:bizcard_app/pages/dashboard/fragments/my_cards_fragment.dart';
import 'package:bizcard_app/pages/dashboard/fragments/my_contacts_fragment.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class DashboardViewModel extends BaseViewModel {
  final List bottomNavItems = [
    {'icon': AntIcons.idcardOutlined, 'label': 'Cards'},
    {'icon': Icons.contacts_outlined, 'label': 'Contacts'},
    {'icon': Icons.qr_code_scanner_outlined, 'label': 'Scan'},
    {'icon': Icons.settings_outlined, 'label': 'Settings'}
  ];

  late PageController controller;
  late TextEditingController cardnameController;

  late TextEditingController subjectController;
  late TextEditingController contentController;

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> mailFormKey = GlobalKey();

  late ValueNotifier<List<Contact>> contacts;

  DashboardViewModel() {
    controller = PageController();
    cardnameController = TextEditingController();

    subjectController = TextEditingController();
    contentController = TextEditingController();

    contacts = ValueNotifier(Global.contacts);
  }

  onSearch(String query) {
    var filtered = Global.contacts.where((e) {
      String name = e.card != null
          ? '${e.card?.name?.firstName ?? ''} ${e.card?.name?.lastName ?? ''}'
          : e.details?.name ?? '';
      String? email = e.card != null ? e.card?.email : e.details?.email;
      String? phone = e.card != null ? e.card?.phoneNumber : e.details?.phone;
      return name.toLowerCase().contains(query) ||
          (email != null && email.toLowerCase().contains(query)) ||
          (phone != null && phone.toLowerCase().contains(query));
    });
    contacts.value = [...filtered];
  }

  getPages(DashboardViewModel viewModel) {
    return [
      MyCardsFragment(viewModel: viewModel),
      MyContactsFragment(viewModel: viewModel)
    ];
  }

  onMove(index, BuildContext context) {
    if (index < 2) {
      controller.jumpToPage(index);
      context.read<HomePageCubit>().onPageChange(index);
    } else {
      Navigator.pushNamed(context, index == 2 ? Routes.scan : Routes.settings);
    }
  }

  openCardOptions(bizcard.Card card, BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return CardOptionsSheet(
            onClick: (v) {
              Navigator.pop(context);
              if (v == 'Edit details') {
                Navigator.of(context)
                    .pushNamed(Routes.cardBuilder, arguments: card.id);
              } else if (v == 'Delete') {
                context.read<CardBloc>().add(DeleteCardEvent(card.id));
              } else if (v == 'Preview') {
                Navigator.of(context)
                    .pushNamed(Routes.preview, arguments: card.id);
              } else if (v == 'Share') {
                Share.shareUri(Uri.parse(card.cardLink!));
              } else if (v == 'QrCode theme') {
                Navigator.of(context)
                    .pushNamed(Routes.qrTheme, arguments: card.id);
              } else if (v == 'Analytics') {
                Navigator.of(context)
                    .pushNamed(Routes.cardAnalytics, arguments: card.id);
              } else if (v == 'Settings') {
                openCardSettings(card, context);
              }
            },
          );
        });
  }

  openTagSheet(BuildContext context, Contact contact) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return AddTagSheet(
            contactId: contact.id,
            onSave: (tags) {
              Navigator.pop(context);
              context.read<ContactsBloc>().add(UpdateContactEvent(
                  contactId: contact.id, data: {'tags': tags}));
            },
          );
        });
  }

  openCardSettings(bizcard.Card card, BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return CardSettingsSheet(
            cardId: card.id,
            onClick: (updated) {
              context.read<CardBloc>().add(SaveCardSettingsEvent(updated));
            },
          );
        });
  }

  openContactOptions(Contact contact, BuildContext context, viewModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return ContactOptionsSheet(
            contact: contact,
            onClick: (v) async {
              Navigator.pop(context);
              if (v == 'Delete') {
                context
                    .read<ContactsBloc>()
                    .add(DeleteContactEvent(contactId: contact.id));
              } else if (v == 'Add Tags') {
                openTagSheet(context, contact);
              } else if (v == 'Send Mail') {
                openMailSheet(context,
                    contact.card?.email ?? contact.details?.email, viewModel);
              } else if (v == 'Save as Contact') {
                await saveVCard(contact: contact);
              } else if (v == 'Export') {
                openExportSheet(context, contact);
              } else if (v == 'Edit') {
                Navigator.pushNamed(context, Routes.editContact,
                    arguments: contact);
              } else if (v == 'Preview') {
                Navigator.pushNamed(context, Routes.preview,
                    arguments: contact.card?.id);
              }
            },
          );
        });
  }

  openCreateSheet(BuildContext context, viewModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (_) {
          return CreateCardSheet(
              viewModel: viewModel, onCreate: () => createCard(context));
        });
  }

  openMailSheet(BuildContext context, email, viewModel) {
    subjectController.clear();
    contentController.clear();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (_) {
          return MailSheet(
            viewModel: viewModel,
            onSave: () => sendMail(context, email),
          );
        });
  }

  sendMail(BuildContext context, String email) {
    if (!mailFormKey.currentState!.validate()) {
      return;
    }
    context.read<ContactsBloc>().add(SendMailEvent(
        emails: [email],
        subject: subjectController.trim(),
        content: contentController.trim()));
  }

  openExportSheet(BuildContext context, Contact? contact) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (_) {
          return ExportSheet(
            isAll: contact==null,
            onClick: (v) {
              Navigator.pop(context);
              context
                .read<ContactsBloc>()
                .add(ExportContactsEvent(exportId: v, ids: contact!=null ? [contact.id] : []));
          });
        });
  }

  createCard(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    Navigator.pop(context);
    context
        .read<CardBloc>()
        .add(CreateCardEvent(cardnameController.trim(), false));
  }

  @override
  void dispose() {}
}
