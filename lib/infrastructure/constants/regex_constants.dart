class RegxConstants {

  // all the regex of are defined here

  static const String OnlyCharacters = r'^[a-zA-Z]*$';
  static const String AustralianMobile = r'(\+61|#|0)4[0-9]{8}';
  static const String RegexForUpperLowerLetters = r"^(?=.*[a-z])(?=.*[A-Z]).{8,}$";
  static const String RegexForNumber = r"^(?=.*?[0-9]).{8,}$";
  static const String RegexForSpecialCharacter = r"^(?=.*?[#?!@$%^&*-]).{8,}$";
  static const String RegexForEmail = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  static const String RegexForOnlyWhiteSpaces = r"^\s+$";
  static const String RegexForInValidChar = r"([^0-9A-Za-z_.@+-]+)";
  static const String RegexForValidEmail = r".+@.+\\.[A-Za-z]+";
  static const String RegexForImage = r"lf[/]([0-9]+)";
  static const String RegexForNickName = r"^(^[^0-9])([\w a-z A-Z 0-9][^@#])$";

}