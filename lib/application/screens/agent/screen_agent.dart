import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/agent/widget/subzone.dart';
import 'package:super_admin_app/application/screens/zone/bloc/bloc/zone_bloc.dart';
import 'package:super_admin_app/application/utils/routs.dart';
import 'package:super_admin_app/application/utils/styles.dart';
import 'package:super_admin_app/application/widgets/error_ui_and_empty_ui_text.dart';

class ScreenAgent extends StatelessWidget {
  const ScreenAgent({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ZoneBloc>().add(GetAllZonesEvent());
    return Scaffold(
      appBar: AppBar(title:const Text("Agent Mnagement"),),
      body: SizedBox(
        child: BlocBuilder<ZoneBloc, ZoneState>(  
          builder: (context, state) {
            if (state is ZoneLoadingState) {
              return kCircularProgressIndicator;
            }
            if (state is ZoneSucessState) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final zone = state.zones[index];
                    return  ListTile(
                      title: Text(zone.zoneName),
                      subtitle: Text("Zone ID: ${zone.zoneId}"),
                      leading:const CircleAvatar(
                        child:  Icon(Icons.location_on),
                      ),
                      onTap: () => kNavigationPush(context, SubzoneWidget(zone:zone)), 
                      trailing:const Icon(Icons.arrow_forward_ios,size: 15,),
                    );
                  }, 
                  separatorBuilder: (context, index) =>const Divider(), 
                  itemCount: state.zones.length
                  );
            }
            if (state is ZoneEmptyState) {
              return centerText("No zone avilable");
            }
            return centerText("fail to fech");
          },
        ),
      ),
    );
    
  }
}