class UpdateReqDto {
  final String? uid;
  final String? nickname;

  UpdateReqDto({this.nickname, this.uid});
  Map<String, dynamic> toJson() => {
        "nickname": nickname,
      };
}
