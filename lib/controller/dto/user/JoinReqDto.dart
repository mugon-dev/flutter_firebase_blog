class JoinReqDto {
  final String? username;
  final String? email;
  final String? password;

  JoinReqDto(this.username, this.email, this.password);
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
