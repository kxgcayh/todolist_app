// ignore_for_file: constant_identifier_names, non_constant_identifier_names, prefer_const_declarations

class STATUS {
  static int get OK => 200;
  static int get BAD_REQUEST => 400;
  static int get NOT_AUTHORIZED => 403;
  static int get NOT_FOUND => 404;
  static int get INTERNAL_ERROR => 500;
  static int get CONNECTION_TIMEOUT => 408;
}

class MESSAGE {
  static String get OK => 'Success';
  static String get BAD_REQUEST => 'Bad Request';
  static String get NOT_AUTHORIZED => 'Forbidden';
  static String get NOT_FOUND => 'Not Found';
  static String get INTERNAL_ERROR => 'Internal Server Error';
  static String get CONNECTION_TIMEOUT => "Connection Timeout";
  static String get DEFAULT {
    return 'Please check your internet connection and try again';
  }
}
