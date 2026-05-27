class UserResponseDto {
  final int id;
  final String firstName;
  final String lastName;
  final String businessName;
  final String email;
  final String phone;
  final String? website;
  final String? profilePhoto;
  final int roleId;

  const UserResponseDto({
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

  factory UserResponseDto.fromJson(Map<String, dynamic> json) => UserResponseDto(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        businessName: json['businessName'],
        email: json['email'],
        phone: json['phone'],
        website: json['website'],
        profilePhoto: json['profilePhoto'],
        roleId: json['roleId'],
      );
}
