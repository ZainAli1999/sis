String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ?? '');
  if (!isEmailValid) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null) {
    return 'Please type a password';
  }
  if (password.length < 6) {
    return 'Your password should at least be 6 characters';
  }
  return null;
}

String? validateName(String? name) {
  final nameRegex = RegExp(r'^[a-zA-Z\s]{1,50}$');
  if (name == null) {
    return 'Name cannot be null';
  } else if (name.length < 3) {
    return 'Name should be at least 3 characters';
  } else if (!nameRegex.hasMatch(name)) {
    return 'Please enter a valid name';
  } else {
    return null;
  }
}

String? validateField(String? field) {
  if (field == '') {
    return 'Please fill the field';
  }
  return null;
}

String? validateCnic(String? cnic) {
  // Define the CNIC pattern
  final RegExp cnicPattern = RegExp(r'^\d{5}-\d{7}-\d$');

  if (cnic == null || cnic.isEmpty) {
    return 'Please enter your CNIC number';
  } else if (!cnicPattern.hasMatch(cnic)) {
    return 'Your CNIC must follow the pattern: 11111-2222222-3';
  }

  return null; // Return null if validation is successful
}

String? validatePhone(String? password) {
  if (password == null) {
    return 'Please enter your phone number';
  }
  if (password.length < 10) {
    return 'Your phone number should be 10 digits long';
  }
  if (password.length > 10) {
    return 'Enter only 10 digits of Phone Number';
  }
  return null;
}
