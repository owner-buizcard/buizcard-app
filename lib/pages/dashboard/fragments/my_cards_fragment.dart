import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../widgets/gap.dart';

class MyCardsFragment extends StatelessWidget {
  final DashboardViewModel viewModel;
  const MyCardsFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('My Cards', style: Theme.of(context).textTheme.titleMedium),
              TextButton(onPressed: (){}, child: const Text('View All'))
            ],
          ),

          const Gap(size: 10),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Color(0x268c8c8c), blurRadius: 8)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Column(
                children: [

                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          heightFactor: 0.75,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/bizcard-spiderlingz.appspot.com/o/test%2Fcolor6.jpg?alt=media&token=391cb770-4500-459d-825e-21d4bb8a48bd')),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(6)
                              )
                            ),
                          ),
                        ),
                    
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/bizcard-spiderlingz.appspot.com/o/test%2Fdownload.jpeg?alt=media&token=9c3c77de-2bfa-4dab-a8e6-043cefd96871'),
                            ),
                          ),
                        )
                    
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: 'Jack Ferros'.titletext(context),
                            subtitle: 'Flutter developer'.bltext(context),
                            trailing: InkWell(
                              onTap: ()=>viewModel.openCardOptions(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0x55D6D6D6),
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: const Icon(Icons.more_vert, color: Color(0xFF797272),),
                              ),
                            ),
                          ),
                      
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                QrImageView(
                                  size: 160,
                                  data: 'data'
                                )
                              ],
                            ),
                          ),
                      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              'Updated 1 hour ago'.btext(context),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0x241677FF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('Basic Card', style: Theme.of(context).textTheme.bodySmall),
                              )
                            ],
                          ),
                      
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(bottom: 8, top: 8),
          //   child: )
        ],
      ),
    );
  }
}