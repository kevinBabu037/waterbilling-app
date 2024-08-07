
class Validatior {


  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }
    final emailRegExp = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); 
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  //////////////////////////

      static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    // Check for capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }
   
   ///////////////////
  
   static String? validateZoneNameAndDiscription(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'At least 3 characters long';
    }
    return null;
  }

  static String ? tenantIDValidate(String? value){
    if (value == null || value.isEmpty || value.length < 6) {
      return 'At least 3 characters long';
    }
    return null;
  }


 static String? normalTextFieldValedate(String? value){
     if (value == null || value.isEmpty || value.length < 3) {
      return 'At least 3 characters long';
    }
    return null;
  }

   static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneNumberRegex = RegExp(r'^\+91\d{10}$');
    if (!phoneNumberRegex.hasMatch(value)) {
      return 'Enter a valid +91 phone number (10 digits)';
    }
    return null;
  }


  static String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Postal code is required';
    }
    final postalCodeRegex = RegExp(r'^\d{6}$');
    if (!postalCodeRegex.hasMatch(value)) {
      return 'Enter a valid 6-digit postal code';
    }
    return null;
  }

 static String? validateLatitude(String? value) {
  final lat = double.tryParse(value ?? '');
  if (lat == null) {
    return 'Invalid latitude';
  }
  if (lat < -90 || lat > 90) {
    return 'Latitude must be between -90 and 90';
  }
  return null;
}

 static String? validateLongitude(String? value) {
  final lon = double.tryParse(value ?? '');
  if (lon == null) {
    return 'Invalid longitude';
  }
  if (lon < -180 || lon > 180) {
    return 'Longitude must be between -180 and 180';
  }
  return null;
}



}


