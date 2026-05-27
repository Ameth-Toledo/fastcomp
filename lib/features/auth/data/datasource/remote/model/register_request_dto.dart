class RegisterRequestDto {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String? dialCode;
  final String? phoneNumber;

  const RegisterRequestDto({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    this.dialCode,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'last_name': lastName,
        'email': email,
        'password': password,
        if (dialCode != null) 'dial_code': dialCode,
        if (phoneNumber != null) 'phone_number': phoneNumber,
      };
}
