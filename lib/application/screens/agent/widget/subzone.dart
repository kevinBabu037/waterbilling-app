import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/agent/widget/add_agent.dart';
import 'package:super_admin_app/application/screens/subzone/bloc/bloc/subzone_bloc.dart';
import 'package:super_admin_app/application/utils/routs.dart';
import 'package:super_admin_app/application/utils/styles.dart';
import 'package:super_admin_app/application/widgets/error_ui_and_empty_ui_text.dart';
import 'package:super_admin_app/data/models/zonelist.dart';

class SubzoneWidget extends StatelessWidget {
  const SubzoneWidget({super.key, required this.zone});
  final Zone zone;

  @override
  Widget build(BuildContext context) {
    context.read<SubZoneBloc>().add(GetAllSubZonesEvent(id: zone.zoneId));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(zone.zoneName),
      ),
       body: BlocBuilder<SubZoneBloc, SubZoneState>( 
        builder: (context, state) {
          if (state is SubZoneLoadingState) {
            return kCircularProgressIndicator;
          }
          if (state is SubZoneSucessState) {
            return Expanded(
              child: ListView.separated( 
                  itemBuilder: (context, index) {
                    final zone = state.zones[index];
                    return 
                     ListTile(
                      title: Text(zone.zoneName), 
                      subtitle: Text("SubZone ID: ${zone.subZoneId}"),
                      leading:const CircleAvatar( 
                        child:  Icon(Icons.location_on),
                      ),
                      onTap: () => kNavigationPush(context, AddAgent(subZone: zone,)),
                    );
                  }, 
                  separatorBuilder: (context, index) =>const Divider(), 
                  itemCount: state.zones.length
                  ),
            );
          }
          if (state is SubZoneEmptyState) {  
            return centerText("No zone avilable");
          }
          return centerText("fail to fech");
        },
      ),
    );
  }
}