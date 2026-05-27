class AuthUser {
  final int id;
  final String firstName;
  final String lastName;
  final String businessName;
  final String email;
  final String phone;
  final String? website;
  final String? profilePhoto;
  final int roleId;

  const AuthUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.businessName,
    required this.email,
    required this.phone,
    this.website,
    this.profilePhoto,
    required this.roleId,
  });
}
