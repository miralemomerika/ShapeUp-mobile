class LoginResponse {
  String? isAuthSuccessful;
  String? errorMessage;
  String? token;
  String? role;

  LoginResponse({
    this.isAuthSuccessful,
    this.errorMessage,
    this.token,
    this.role
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(isAuthSuccessful: json['isAuthSuccessful'],
      errorMessage: json['errorMessage'],
      token: json['token'],
      role: json['role']);
  }

  Map<String, dynamic> toJson() => {'isAuthSuccessful':isAuthSuccessful, 'errorMessage':errorMessage, 'token':token, 'role':role};
}