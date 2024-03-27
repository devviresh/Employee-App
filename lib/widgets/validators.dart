
String? isValidName(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Name.';
  }
  if (value.length < 3) {
    return 'Name must be at least 3 characters long!';
  }
  return null;
}

String? isValidDate(value) {
  if (value == null || value.isEmpty) {
    return 'Please Select Date';
  }
  return null;
}
