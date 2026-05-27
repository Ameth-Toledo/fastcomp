class AuthUser {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String role;
  final String? profileImage;
  final String oauthProvider;

  const AuthUser({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
    this.profileImage,
    this.oauthProvider = 'email',
  });
}
