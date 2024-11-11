// Main response model
class SignUpResponse {
  bool success;
  Data data;
  String message;

  SignUpResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  // Factory method to create an instance from JSON
  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

// Data model containing user information and access token
class Data {
  User user;
  String accessToken;
  String tokenType;

  Data({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  // Factory method to create an instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json['user']),
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}

// User model containing user details
class User {
  String name;
  String role;
  String email;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  User({
    required this.name,
    required this.role,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  // Factory method to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      role: json['role'],
      email: json['email'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
