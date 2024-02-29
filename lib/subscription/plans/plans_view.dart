import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/subscription/plans/plans_viewmodel.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlansView extends StatefulWidget {
  const PlansView({super.key});

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> {
  late PlansViewModel _viewModel;
  bool isMonthly = true;

  @override
  void initState() {
    _viewModel = PlansViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return ValueListenableBuilder(
      valueListenable: _viewModel.selected,
      builder: (_, selectedIndex, __) {
        var selectedPlan = Global.plans[selectedIndex];
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upgrade'),
          ),
          bottomNavigationBar: Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color.fromARGB(37, 124, 123, 123), blurRadius: 4)]
            ),
            child: ListTile(
              title: Text('${isMonthly ? selectedPlan.price['m']['amount_string']: selectedPlan.price['y']['amount_string']}', style: GoogleFonts.inter().copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700
              )),
              subtitle: Text('per 1 ${isMonthly ? 'month' : 'year'} plan',
                style: GoogleFonts.inter().copyWith(
                      fontSize: 12,
                      color: Colors.grey
                    )
                  ),
                  
              trailing: SizedBox(
                width: 140, 
                height: 50,
                child: ElevatedButton(onPressed: (){}, child: const Text('Subscribe'))),
            )
          ),
          body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
        
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AnimatedToggleSwitch.size(
                      current: isMonthly ? 0 : 1, 
                      indicatorSize: const Size.fromWidth(300),
                      values: const [0, 1],
                      onChanged: ((i)=> setState(()=>isMonthly=(i==0)) ),  
                      selectedIconScale: 1.1,
                      iconList: [
                        Text('Monthly', style: isMonthly ? const TextStyle(color: Colors.white, fontWeight: FontWeight.w700) : null),
                        Text('Yearly (20% Off)', style: isMonthly ? null : const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
                      ],
                    ),
                  ),
        
                  const Gap(size: 32),
        
                  ...Global.plans.map(
                    (e){
              
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          onTap: ()=>_viewModel.selected.value=Global.plans.indexOf(e),
                          contentPadding: const EdgeInsets.fromLTRB(12, 4, 20, 4),
                          leading: Container(
                            width: 20,
                            padding: const EdgeInsets.only(top: 4),
                            alignment: Alignment.topLeft,
                            child: Icon(
                              selectedPlan.id == e.id
                                ? Icons.check_circle : Icons.radio_button_off_outlined,
                                color: selectedPlan.id == e.id
                                ? ColorsConst.primary : Colors.grey.shade300, 
                                size: 20),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(e.name,
                              style: GoogleFonts.inter().copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w700
                              )
                            ),
                          ),
                          
                          subtitle: Text(e.description,
                            style: GoogleFonts.inter().copyWith(
                                  fontSize: 12,
                                  color: Colors.grey
                                )
                              ),
                          trailing: Text('${isMonthly ? e.price['m']['amount_string']: e.price['y']['amount_string']}', style: GoogleFonts.inter().copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                              )),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: selectedPlan.id == e.id  ? ColorsConst.primary : Colors.grey.shade300
                            ),
                            borderRadius: BorderRadius.circular(4)
                          ),
                        ),
                      );
                    }).toList(),
        
                    const Gap(size: 16),
        
                    const Text(
                      'All that you will get with this package', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorsConst.primary
                      ), textAlign: TextAlign.center),
        
                    const Gap(size: 16),
        
                    ...selectedPlan.features.map(
                      (e) => ListTile(
                        leading: const Icon(Icons.check, size: 20, color: Colors.green),
                        title: Text(e, style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        )),
                      )).toList()
                ], 
          ),
        );
      }
    );
  }
}