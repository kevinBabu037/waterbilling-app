import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/subzone/bloc/bloc/subzone_bloc.dart';
import 'package:super_admin_app/application/utils/colors.dart';
import 'package:super_admin_app/application/utils/height_width.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/application/utils/styles.dart';
import 'package:super_admin_app/application/utils/validation.dart';
import 'package:super_admin_app/application/widgets/error_ui_and_empty_ui_text.dart';
import 'package:super_admin_app/application/widgets/login_text_formfield.dart';
import 'package:super_admin_app/application/widgets/textformfield.dart';
import 'package:super_admin_app/data/models/zonelist.dart';
import 'package:super_admin_app/data/repositories/sub%20zone/subzone_service.dart';

class AddSubZone extends StatefulWidget {
  const AddSubZone({super.key, required this.zone});
 final Zone zone;
  @override
  ScreenZoneState createState() => ScreenZoneState();
}

class ScreenZoneState extends State<AddSubZone> {
  final _formKey = GlobalKey<FormState>();
  final _subZonecontroller = TextEditingController();
  final _zoneDescriptionController = TextEditingController();

  @override
  void dispose() {
    _subZonecontroller.dispose();
    _zoneDescriptionController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    context.read<SubZoneBloc>().add(GetAllSubZonesEvent(id: widget.zone.zoneId));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.zone.zoneName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight15,
              const Text(
                "Add SubZone", 
                style: TextStyle(fontSize: 22),
              ),
              kHeight30,
              BuildTextFormField(
                controller: _subZonecontroller,
                prfixIcon: Icons.abc,
                hintTxt: 'Sub Zone Name',
                validator: (value)=>Validatior.validateZoneNameAndDiscription(value)
                  
              ),
              kHeight40,
              CustomTextFormFeild(
                controller: _zoneDescriptionController,
                hintTxt: "Description",
                validator: (value) =>Validatior.validateZoneNameAndDiscription(value) ,
                maxLines: 7,
                ),
                kHeight10,
                const Text('SubZones',style: TextStyle(fontSize: 22),),
                kHeight10,
      BlocBuilder<SubZoneBloc, SubZoneState>( 
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            final subZoneName = _subZonecontroller.text;
            final description = _zoneDescriptionController.text;
             AddSubZoneService().addsubZone(subZoneName,description,widget.zone.zoneId).
             then((v){
          if (v) {
            context.read<SubZoneBloc>().add(GetAllSubZonesEvent(id: widget.zone.zoneId));
            _subZonecontroller.clear();
            _zoneDescriptionController.clear(); 
          }
          v ? kSnakBar(context, "Zone added successfully", kClrGreen)
           : kSnakBar(context, "Failed to add zone", kClrRed);

         });

           
          }
        },
      ),
    );
  }
}
