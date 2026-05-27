class RegisterRequestDto {
  final String firstName;
  final String lastName;
  final String businessName;
  final String email;
  final String password;
  final String phone;
  final String? website;

  const RegisterRequestDto({
    required this.firstName,
    required this.lastName,
    required this.businessName,
    required this.email,
    required this.password,
    required this.phone,
    this.website,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'businessName': businessName,
        'email': email,
        'password': password,
        'phone': phone,
        if (website != null) 'website': website,
      };
}
