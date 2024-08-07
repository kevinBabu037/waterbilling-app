import 'package:flutter/material.dart';
import 'package:super_admin_app/application/utils/colors.dart';
import 'package:super_admin_app/application/utils/height_width.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/application/utils/validation.dart';
import 'package:super_admin_app/application/widgets/textformfield.dart';
import 'package:super_admin_app/data/models/agent.dart';
import 'package:super_admin_app/data/models/subzone.dart';
import 'package:super_admin_app/data/repositories/agent/agent.dart'; 
class AddAgent extends StatefulWidget {
  const AddAgent({super.key, required this.subZone});
  final SubZone subZone;

  @override
  ScreenSupervisorState createState() => ScreenSupervisorState();
}
 
class ScreenSupervisorState extends State<AddAgent> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.subZone.zoneName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                const Text( 
                  "Add Agent",
                  style: TextStyle(fontSize: 22),
                ),
                kHeight40,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator:(value) =>Validatior.normalTextFieldValedate(value),
                        controller: _nameController,
                        hintTxt: 'Name',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                       validator:(value) =>Validatior.validateEmail(value),
                        controller: _emailController,
                        hintTxt: 'Email',
                      ),
                    ),
                  ],
                ),
                kHeight20,
                CustomTextFormFeild(
                    validator:(value) =>Validatior.normalTextFieldValedate(value),
                        controller: _addressController,
                        hintTxt: 'Address',
                        maxLines: 3,
                      ),
                      kHeight20,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator:(value) =>Validatior.validatePhoneNumber(value),
                        controller: _phoneController,
                        hintTxt: 'Phone',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                        validator:(value) =>Validatior.normalTextFieldValedate(value),
                        controller: _cityController,
                        hintTxt: 'City',
                      ),
                    ), 
                  ],
                ),
                kHeight20,

                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator:(value) =>Validatior.validatePostalCode(value),
                        controller: _postalCodeController,
                        hintTxt: 'Postal Code',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                        validator:(value) =>Validatior.normalTextFieldValedate(value),
                        controller: _stateController,
                        hintTxt: 'State',
                      ),
                    ), 
                  ],
                ),
                kHeight20,
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            final agent = Agent( 
              name: _nameController.text, email: _emailController.text, phone:_phoneController.text, 
              address: _addressController.text, city:_cityController.text, state:_stateController.text, 
              postalCode:_postalCodeController.text, subZoneId: widget.subZone.subZoneId
              );
            await AgentSetvice().addAgent(agent).
            then((result) {
              if (result) { 
               _nameController.clear();
              _emailController.clear();
              _phoneController.clear();
              _addressController.clear();
              _cityController.clear();
              _stateController.clear();
              _postalCodeController.clear();  
              }
              kSnakBar(context, result?"Agent added":"Fail to add agent", result?kClrGreen:kClrRed);
            },);
          }
        },
      ),
    );
  }
}
