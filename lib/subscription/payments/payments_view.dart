import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentsView extends StatefulWidget {
  const PaymentsView({super.key});

  @override
  State<PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscriptions'),
        actions: [
          TextButton(
            onPressed: ()=>Navigator.pushNamed(context, Routes.plans), 
            child: const Text('Upgrade+')),
          const Gap(size: 8)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...Global.subscriptions.keys.map(
            (e){
              var subs = Global.subscriptions[e] as List;

              if(subs.isEmpty){
                return Container();
              }

              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$e'.toUpperCase(),
                    style: GoogleFonts.inter().copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.blueGrey)),
                  const Gap(size: 16),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: subs.map((e){
                      return MainCard(
                        p: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(e['name'], 
                                style: GoogleFonts.inter().copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.black)
                            ),
                          ),
                          subtitle: Text('${formatDate(e['startAt'])} - ${formatDate(e['endAt'])}'),
                          trailing: Text(e['duration']),
                        ),
                      );
                    }).toList()
                  ),
                  const Gap(size: 8)
                ],
              );
            })
        ],
      ),
    );
  }
}