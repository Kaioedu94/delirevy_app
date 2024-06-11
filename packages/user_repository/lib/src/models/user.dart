import '../entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;
  String phone;
  String dob;
  String address;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    required this.phone,
    required this.dob,
    required this.address,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
    phone: '',
    dob: '',
    address: '',
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
      phone: phone,
      dob: dob,
      address: address,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
      phone: entity.phone,
      dob: entity.dob,
      address: entity.address,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart, $phone, $dob, $address';
  }
}
