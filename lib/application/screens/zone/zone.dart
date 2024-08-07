import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/zone/bloc/bloc/zone_bloc.dart';
import 'package:super_admin_app/application/utils/colors.dart';
import 'package:super_admin_app/application/utils/height_width.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/application/utils/validation.dart';
import 'package:super_admin_app/application/widgets/login_text_formfield.dart';
import 'package:super_admin_app/application/widgets/textformfield.dart';
import 'package:super_admin_app/data/repositories/zone/add_zone_service.dart';

class ScreenZone extends StatelessWidget {
  const  ScreenZone({super.key});



  @override
  Widget build(BuildContext context) {
     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
       final nameController = TextEditingController();
       final discriptionController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Zone Management",  
                  style: TextStyle(fontSize: 22),
                ),
                
                kHeight30,
                BuildTextFormField(
                  controller: nameController,
                  prfixIcon: Icons.abc,
                  hintTxt: 'Zone Name',
                  validator: (value) => Validatior.validateZoneNameAndDiscription(value),
                ),
                kHeight40,
                CustomTextFormFeild(
                  controller: discriptionController,
                  hintTxt: "Description",
                  validator: (value) => Validatior.validateZoneNameAndDiscription(value),
                  maxLines: 7,
                ),
              ],
            ),
          ),
        ),
      ), 
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            bool success = await AddZoneService().addZone(nameController.text, discriptionController.text);
             if (success) {
               nameController.clear();
               discriptionController.clear();
               context.read<ZoneBloc>().add(GetAllZonesEvent());
             }
            kSnakBar( 
              context,
              success ? "Zone added successfully" : "Failed to add zone",
              success ? kClrGreen : kClrRed,
            );
          }
        },
      ),
    );
  }
}
