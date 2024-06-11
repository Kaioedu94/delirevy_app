class MyUserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;
  String phone;
  String dob;
  String address;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    required this.phone,
    required this.dob,
    required this.address,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
      'phone': phone,
      'dob': dob,
      'address': address,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      hasActiveCart: doc['hasActiveCart'],
      phone: doc['phone'],
      dob: doc['dob'],
      address: doc['address'],
    );
  }
}
