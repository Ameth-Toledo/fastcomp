class RegisterResponseDto {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String role;

  const RegisterResponseDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
  });

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) => RegisterResponseDto(
        id: json['id'],
        name: json['name'],
        lastName: json['last_name'],
        email: json['email'],
        role: json['role'],
      );
}
