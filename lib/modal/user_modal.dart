class User {
  int id;
  String name;
  String email;
  String phone;
  String website;
  String companyName;
  String city;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      companyName: json['company']?['name'] as String? ?? '',
      city: json['address']?['city'] as String? ?? '',
    );
  }
}
