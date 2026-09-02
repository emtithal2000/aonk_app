class DriverSession {
  final String name;
  final String username;

  const DriverSession({
    required this.name,
    required this.username,
  });

  factory DriverSession.fromJson(Map<String, dynamic> json) {
    return DriverSession(
      name: json['name'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
      };

  bool get isValid => name.isNotEmpty && username.isNotEmpty;
}
