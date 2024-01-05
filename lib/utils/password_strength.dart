// has number
bool hasNumber(String value) {
  return RegExp(r'[0-9]').hasMatch(value);
}

// has mix of small and capitals
bool hasMixed(String value) {
  return RegExp(r'[a-z]').hasMatch(value) && RegExp(r'[A-Z]').hasMatch(value);
}

// has special chars
bool hasSpecial(String value) {
  return RegExp(r'[!#@$%^&*)(+=._-]').hasMatch(value);
}

// set color based on password strength
Map<String, dynamic> strengthColor(int count) {
  if (count < 2) return {'label': 'Poor', 'color': '0xFFE57373'};
  if (count < 3) return {'label': 'Weak', 'color': '0xFFFFB74D'};
  if (count < 4) return {'label': 'Normal', 'color': '0xFFF57F17'};
  if (count < 5) return {'label': 'Good', 'color': '0xFF81C784'};
  if (count < 6) return {'label': 'Strong', 'color': '0xFF4CAF50'};
  return {'label': 'Poor', 'color': '0xFFE57373'};
}

// password strength indicator
int strengthIndicator(String value) {
  int strengths = 0;
  if (value.length > 5) strengths += 1;
  if (value.length > 7) strengths += 1;
  if (hasNumber(value)) strengths += 1;
  if (hasSpecial(value)) strengths += 1;
  if (hasMixed(value)) strengths += 1;
  return strengths;
}
