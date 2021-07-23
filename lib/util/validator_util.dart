import 'package:validators/validators.dart';

Function validatorUsername() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (!isAlphanumeric(value)) {
      return "유저네임에 한글이나 특수문자가 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "유저네임의 길이를 초과하였습니다.";
    } else if (value.length < 3) {
      return "유저네임의 최소 길이는 4자입니다.";
    } else {
      return null;
    }
  };
}

Function validatorPassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "패스워드에 공백이 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "패스워드의 길이를 초과하였습니다.";
    } else if (value.length < 4) {
      return "패스워드의 최소 길이는 4자입니다.";
    } else {
      return null;
    }
  };
}

Function validatorEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "이메일에 공백이 들어갈 수 없습니다.";
    } else if (!isEmail(value)) {
      return "이메일 형식에 맞지 않습니다.";
    } else {
      return null;
    }
  };
}

Function validatorTitle() {
  return (String? value) {
    if (value!.isEmpty) {
      return "타이틀에는 공백이 들어갈 수 없습니다.";
    } else if (value.length > 30) {
      return "제목의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

Function validatorContent() {
  return (String? value) {
    if (value!.isEmpty) {
      return "내용은 공백이 들어갈 수 없습니다.";
    } else if (value.length > 500) {
      return "내용의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}
