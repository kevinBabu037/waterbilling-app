import 'package:flutter/material.dart';
import 'package:super_admin_app/application/utils/colors.dart';
import 'package:super_admin_app/application/utils/height_width.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/application/utils/validation.dart';
import 'package:super_admin_app/application/widgets/textformfield.dart';
import 'package:super_admin_app/data/models/supervisor.dart';
import 'package:super_admin_app/data/models/zonelist.dart';
import 'package:super_admin_app/data/repositories/supervisor/supervisor.dart'; 

class AddSuperVisor extends StatefulWidget {
  const AddSuperVisor({super.key, required this.zone});
  final Zone zone;

  @override
  ScreenAgentState createState() => ScreenAgentState();
}
 
class ScreenAgentState extends State<AddSuperVisor> {
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
      appBar: AppBar(centerTitle: true, title: Text(widget.zone.zoneName),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                const Text(
                  "Add Supervisor",
                  style: TextStyle(fontSize: 22),
                ),
          
                kHeight30,
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async { 
           addButtonAction();
        },
      ),
    );
  }

  
 
  addButtonAction(){
    if (_formKey.currentState?.validate() ?? false) {
            final model = Supervisor(
              name: _nameController.text, 
              email: _emailController.text, phone: _phoneController.text, 
              address: _addressController.text, city: _cityController.text, 
              state: _stateController.text, postalCode: _postalCodeController.text,
              zoneId:widget.zone.zoneId 
             );
           SupervisorService().addSubSupervisor(model)
           .then((result) {
              kSnakBar(context,result? "Supervisor Added":"fail to add Supervisor",result? kClrGreen :kClrRed);
              if (result) {
                   _nameController.clear();
                   _emailController.clear();
                   _phoneController.clear();
                   _addressController.clear();
                   _cityController.clear();
                   _stateController.clear();
                   _postalCodeController.clear();
              }
           },);
            
          }
  }

}
