class LoginReqDto {
  final String? email;
  final String? password;

  LoginReqDto(this.email, this.password);
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
