import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/subzone/bloc/bloc/subzone_bloc.dart';
import 'package:super_admin_app/application/screens/user/widget/add_user.dart';
import 'package:super_admin_app/application/utils/routs.dart';
import 'package:super_admin_app/application/utils/styles.dart';
import 'package:super_admin_app/application/widgets/error_ui_and_empty_ui_text.dart';
import 'package:super_admin_app/data/models/zonelist.dart';

class SubzonesUser extends StatelessWidget {
  const SubzonesUser({super.key, required this.zone});
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
                    final subZone = state.zones[index];
                    return 
                     ListTile(
                      title: Text(subZone.zoneName), 
                      subtitle: Text("SubZone ID: ${subZone.subZoneId}"),
                      leading:const CircleAvatar( 
                        child:  Icon(Icons.location_on),
                      ),
                      onTap: () => kNavigationPush(context, AddUser(subZone:subZone ,zoneID:zone.zoneId ,)),
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