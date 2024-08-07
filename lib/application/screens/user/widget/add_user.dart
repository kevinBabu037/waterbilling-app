import 'package:flutter/material.dart';
import 'package:super_admin_app/application/utils/height_width.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/application/utils/validation.dart';
import 'package:super_admin_app/application/widgets/textformfield.dart';
import 'package:super_admin_app/data/models/subzone.dart';
import 'package:super_admin_app/data/models/user.dart';
import 'package:super_admin_app/data/repositories/user/user_service.dart';
import '../../../utils/colors.dart'; 

class AddUser extends StatefulWidget {
  const AddUser({super.key, required this.subZone, required this.zoneID});

  final SubZone subZone;
  final String zoneID;

  @override
  AddUserState createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _houseNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _houseNoController.dispose();
    _addressController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    _postalCodeController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(widget.subZone.zoneName),
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
                  "Add User",
                  style: TextStyle(fontSize: 22),
                ),
                kHeight40,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.normalTextFieldValedate(value),
                        controller: _nameController,
                        hintTxt: 'Name',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.validatePhoneNumber(value),
                        controller: _phoneController,
                        hintTxt: 'Phone',
                      ),
                    ),
                  ],
                ),
                kHeight20,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.normalTextFieldValedate(value),
                        controller: _houseNoController,
                        hintTxt: 'House No',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.normalTextFieldValedate(value),
                        controller: _streetController,
                        hintTxt: 'Street',
                      ),
                    ),
                  ],
                ),
                kHeight20,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.normalTextFieldValedate(value),
                        controller: _landmarkController,
                        hintTxt: 'Landmark',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.validatePostalCode(value),
                        controller: _postalCodeController,
                        hintTxt: 'Postal Code',
                      ),
                    ),
                  ],
                ),
                kHeight20,
                CustomTextFormFeild(
                  validator: (value) => Validatior.normalTextFieldValedate(value),
                  controller: _addressController,
                  hintTxt: 'Address',
                  maxLines: 3,
                ),
                kHeight20,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.validateLatitude(value),
                        controller: _latitudeController,
                        hintTxt: 'Latitude',
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: CustomTextFormFeild(
                        validator: (value) => Validatior.validateLongitude(value),
                        controller: _longitudeController,
                        hintTxt: 'Longitude',
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
            final user = User(
              name: _nameController.text,
              phone: _phoneController.text,
              houseNo: _houseNoController.text,
              address: _addressController.text,
              street: _streetController.text,
              landmark: _landmarkController.text,
              postalCode: _postalCodeController.text,
              latitude: _latitudeController.text,
              longitude: _longitudeController.text,
              subZoneId:widget.subZone.subZoneId, 
              zoneId: widget.zoneID, 
            );

            final result = await UserService().addUser(user);
            kSnakBar(context, result ? "User added" : "Failed to add user", result ? kClrGreen : kClrRed);

            if (result) {
              _nameController.clear();
              _phoneController.clear();
              _houseNoController.clear();
              _addressController.clear();
              _streetController.clear();
              _landmarkController.clear();
              _postalCodeController.clear();
              _latitudeController.clear();
              _longitudeController.clear();
            }
          }
        },
      ),
    );
  }
}
