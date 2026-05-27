class UserResponseDto {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String role;
  final String? profileImage;
  final String oauthProvider;

  const UserResponseDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
    this.profileImage,
    required this.oauthProvider,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) => UserResponseDto(
        id: json['id'],
        name: json['name'],
        lastName: json['last_name'],
        email: json['email'],
        role: json['role'],
        profileImage: json['profile_image'],
        oauthProvider: json['oauth_provider'] ?? 'email',
      );
}
